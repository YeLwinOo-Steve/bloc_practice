import 'package:equatable/equatable.dart';
class CounterState extends Equatable{
  CounterState({required this.count,this.isIncremented});
  final int count;
  bool? isIncremented;

  @override
  List<Object?> get props => [ count, isIncremented ];
}