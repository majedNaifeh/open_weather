import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:open_weather_bloc_listener/models/custom_error.dart';
import 'package:open_weather_bloc_listener/models/weather.dart';

import '../../repositories/weather_repository.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository})
      : super(WeatherState.initial()) {
    on<FetchWeatherEvent>(_fetchWeather);
  }

  Future<void> _fetchWeather(
      FetchWeatherEvent event, Emitter<WeatherState> emit) async {
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final Weather weather = await weatherRepository.fetchWeather(event.city);
      emit(state.copyWith(status: WeatherStatus.loaded, weather: weather));
      print("State: $state");
    } on CustomError catch (e) {
      emit(state.copyWith(error: e, status: WeatherStatus.error));
      print(state);
    }
  }
}
