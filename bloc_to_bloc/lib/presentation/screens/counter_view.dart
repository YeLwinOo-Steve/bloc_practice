import 'package:bloc_counter/constants/enums.dart';
import 'package:bloc_counter/logic/bloc/internet_cubit.dart';
import 'package:bloc_counter/presentation/screens/second_counter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/bloc/counter_cubit.dart';
import '../../logic/bloc/counter_state.dart';
import '../../logic/bloc/internet_state.dart';

class CounterView extends StatefulWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Cubit'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<InternetCubit, InternetState>(builder: (context, state) {
            if (state is InternetConnected) {
              if (state.connectionType == ConnectionType.wifi) {
                return const Text("WIFI");
              } else if (state.connectionType == ConnectionType.mobile) {
                return const Text("Internet");
              }
            } else if (state is InternetDisconnected) {
              return const Text("Disconnected");
            }
            return const CircularProgressIndicator();
          }),
          BlocConsumer<CounterCubit, CounterState>(listener: (context, state) {
            if (state.isIncremented!) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Incremented')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Decremented')),
              );
            }
          }, builder: (context, state) {
            return Text(
              '${state.count}',
              style: const TextStyle(fontSize: 40),
            );
          }),
          const SizedBox(
            height: 30.0,
          ),
          Builder(
            builder: (context) {
              final internetState = context.watch<InternetCubit>().state;
              final counterState = context.watch<CounterCubit>().state;
              if(internetState is InternetConnected && internetState.connectionType == ConnectionType.mobile){
                return Text("Counter : ${counterState.count} \t Internet: Mobile");
              }else if(internetState is InternetConnected && internetState.connectionType == ConnectionType.wifi){
                return Text("Counter : ${counterState.count} \t Internet: Wifi");
              }else{
                return Text("Counter : ${counterState.count} \t Internet: Disconnected");
              }
            }
          ),
          const SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                color: Theme.of(context).primaryColor,
                height: 60.0,
                minWidth: 60.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
                onPressed: () {
                  context.read<CounterCubit>().increment();
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              MaterialButton(
                color: Theme.of(context).primaryColor,
                height: 60.0,
                minWidth: 60.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
                onPressed: () {
                  context.read<CounterCubit>().decrement();
                },
                child: const Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30.0,
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, '/second');
            },
            child: const Text(
              'Go to second screen',
              style: TextStyle(color: Colors.white),
            ),
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(
            height: 30.0,
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, '/third');
            },
            child: const Text(
              'Go to third screen',
              style: TextStyle(color: Colors.white),
            ),
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
