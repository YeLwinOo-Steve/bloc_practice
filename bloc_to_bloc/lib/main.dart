import 'package:bloc_counter/logic/bloc/internet_cubit.dart';
import 'package:bloc_counter/presentation/router/app_router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'logic/bloc/counter_cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(storageDirectory: await getApplicationDocumentsDirectory());
  HydratedBlocOverrides.runZoned(() => runApp(CounterApp(
    connectivity: Connectivity(),
    appRouter: AppRouter(),
  )),
  storage: storage);
}

class CounterApp extends StatelessWidget {
  final Connectivity connectivity;
  final AppRouter appRouter;
  CounterApp({Key? key, required this.connectivity, required this.appRouter})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
            create: (internetCubitContext) => InternetCubit(connectivity: connectivity)),
        BlocProvider<CounterCubit>(
            create: (counterCubitContext) =>
                CounterCubit())
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
