import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../models/models.dart';

part 'post_event.dart';
part 'post_state.dart';

const int postLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.httpClient}) : super(const PostState()) {
    on<PostFetched>(_onPostFetched,transformer: throttleDroppable(throttleDuration));
  }
  final http.Client httpClient;

  Future<void> _onPostFetched(
      PostFetched event, Emitter<PostState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts();
        return emit(state.copyWith(
            status: PostStatus.success, posts: posts, hasReachedMax: false));
      }
      final posts = await _fetchPosts(state.posts.length);
      if (posts.isEmpty) {
        emit(state.copyWith(hasReachedMax: true));
      } else {
        emit(state.copyWith(
            status: PostStatus.success,
            posts: List.of(state.posts)..addAll(posts),
            hasReachedMax: false));
      }
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<List<Post>> _fetchPosts([int startIndex = 0]) async {
    final response = await httpClient.get(
      Uri.https('jsonplaceholder.typicode.com', '/posts',
          <String, String>{'_start': '$startIndex', '_limit': '$postLimit'}),
    );

    if(response.statusCode == 200){
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        return Post(
          id: json['id'] as int,
          title: json['title'] as String,
          body: json['body'] as String
        );
      }).toList();
    }
    throw Exception('Error while fetching posts');
  }
}
