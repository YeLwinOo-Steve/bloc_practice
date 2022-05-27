import 'package:bloc_counter/logic/bloc/counter_cubit.dart';
import 'package:bloc_counter/logic/bloc/counter_state.dart';
import 'package:bloc_counter/logic/bloc/internet_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  group('Counter Cubit', (){
    final Connectivity connectivity = Connectivity();
    late CounterCubit counterCubit;
    late InternetCubit internetCubit;
    setUp((){
      internetCubit = InternetCubit(connectivity: connectivity);
      counterCubit = CounterCubit();
    });
    
    tearDown((){
      counterCubit.close();
    });
    
    test('the initial value for the CounterCubit is CounterState(count: 0)', (){
      expect(counterCubit.state, CounterState(count: 0));
    });
    
    blocTest('the cubit should emit a CounterState(count: 1, isIncremented: true) when increment() function is called',
        build: () => counterCubit,
    act: (CounterCubit cubit) => cubit.increment(),
    expect: () => [CounterState(count: 1,isIncremented: true)]);

    blocTest('the cubit should emit a CounterState(count: -1, isIncremented: false) when decrement() function is called',
        build: () => counterCubit,
        act: (CounterCubit cubit) => cubit.decrement(),
        expect: () => [CounterState(count: -1,isIncremented: false)]);
  });
}