import 'package:bloc_counter/presentation/screens/counter_view.dart';
import 'package:bloc_counter/presentation/screens/second_counter_view.dart';
import 'package:bloc_counter/presentation/screens/third_counter_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings){
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const CounterView());
      case '/second':
        return MaterialPageRoute(builder: (_) => const SecondCounterView());
      case '/third':
        return MaterialPageRoute(builder: (_) => const ThirdCounterView());
      default:
        return MaterialPageRoute(builder: (_) => const ErrorPage());
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error Page'),
      ),
      body: Center(
        child: Text('404 Page not found!'),
      ),
    );
  }
}
