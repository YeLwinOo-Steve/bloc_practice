import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/bloc/counter_cubit.dart';
import '../../logic/bloc/counter_state.dart';

class SecondCounterView extends StatefulWidget {
  const SecondCounterView({Key? key}) : super(key: key);

  @override
  State<SecondCounterView> createState() => _SecondCounterViewState();
}

class _SecondCounterViewState extends State<SecondCounterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade200,
      appBar: AppBar(
        title: const Text('Second screen'),
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
