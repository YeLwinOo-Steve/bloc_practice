import 'package:bloc/bloc.dart';

import '../data/model/weather.dart';
import '../data/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;
  WeatherBloc(this._weatherRepository) : super(WeatherInitial()){
    on<FetchWeather>((event,emit) async {
      try{
        emit(WeatherLoading());
        final weather = await _weatherRepository.fetchWeather(event.cityName);
        emit(WeatherLoaded(weather));
        }on NetworkException {
          emit(WeatherError('Could not fetch data. Is internet connected?'));
        }
    });
  }

  // Stream<WeatherState> mapEventToState(
  //   WeatherEvent event,
  // ) async* {
  //   if (event is FetchWeather) {
  //     try {
  //       yield WeatherLoading();
  //       final weather = await _weatherRepository.fetchWeather(event.cityName);
  //       yield WeatherLoaded(weather);
  //     } on NetworkException {
  //       yield WeatherError('Could not fetch data. Is internet connected?');
  //     }
  //   }
  // }
}
