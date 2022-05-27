import 'package:bloc/bloc.dart';
import 'package:bloc_counter/presentation/router/app_router.dart';
import 'package:bloc_counter/presentation/screens/second_counter_view.dart';
import 'package:bloc_counter/presentation/screens/third_counter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/bloc/counter_cubit.dart';
import 'presentation/screens/counter_view.dart';

void main(){
    runApp(CounterApp());
}

class CounterApp extends StatelessWidget{
  final AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (_) => CounterCubit(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blueGrey
        ),
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}
