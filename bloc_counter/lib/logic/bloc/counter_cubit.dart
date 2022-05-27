import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(count: 0));

  void increment() => emit(CounterState(count: state.count + 1,isIncremented: true));
  void decrement() => emit(CounterState(count: state.count - 1,isIncremented: false));
}