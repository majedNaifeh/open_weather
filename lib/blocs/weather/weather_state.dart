part of 'weather_bloc.dart';

enum WeatherStatus {
  initial,
  loading,
  loaded,
  error,
}

class WeatherState extends Equatable {
  final WeatherStatus status;
  final Weather weather;
  final CustomError error;

  WeatherState({
    required this.status,
    required this.weather,
    required this.error,
  });
  factory WeatherState.initial() {
    return WeatherState(
        weather: Weather.initial(),
        status: WeatherStatus.initial,
        error: CustomError());
  }

  @override
  List<Object> get props => [status, weather, error];

  @override
  String toString() {
    return 'WeatherState{status: $status, weather: $weather, error: $error}';
  }

  WeatherState copyWith({
    WeatherStatus? status,
    Weather? weather,
    CustomError? error,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
      error: error ?? this.error,
    );
  }
}
