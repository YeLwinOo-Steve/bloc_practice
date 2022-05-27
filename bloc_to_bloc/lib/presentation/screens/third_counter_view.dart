import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/bloc/counter_cubit.dart';
import '../../logic/bloc/counter_state.dart';

class ThirdCounterView extends StatefulWidget {
  const ThirdCounterView({Key? key}) : super(key: key);

  @override
  State<ThirdCounterView> createState() => _ThirdCounterViewState();
}

class _ThirdCounterViewState extends State<ThirdCounterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade200,
      appBar: AppBar(
        title: const Text('Third screen'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocConsumer<CounterCubit,CounterState>(
              listener: (context,state) {
                if(state.isIncremented!){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Incremented')),
                  );
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Decremented')),
                  );
                }
              },
              builder: (context, state) {
                return Text(
                  '${state.count}',style: const TextStyle(fontSize: 40),);
              }
          ),
          const SizedBox(height: 50.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                color: Theme.of(context).primaryColor,
                height: 60.0,
                minWidth: 60.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                onPressed: (){
                  context.read<CounterCubit>().increment();
                },
                child: const Icon(Icons.add,color: Colors.white,),),
              MaterialButton(
                color: Theme.of(context).primaryColor,
                height: 60.0,
                minWidth: 60.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                onPressed: (){
                  context.read<CounterCubit>().decrement();
                },
                child: const Icon(Icons.remove,color: Colors.white,),)
            ],
          )
        ],
      ),
    );
  }
}
