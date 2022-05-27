import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/pages/weather_search_page.dart';
import 'bloc/weather_bloc.dart';
// import 'cubit/weather_cubit.dart';
import 'data/weather_repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(FakeWeatherRepository()),
      child: MaterialApp(
        title: 'Material App',
        home: WeatherSearchPage(),
      ),
    );
  }
}