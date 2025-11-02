part of 'weather_bloc.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;
  final List<Forecast> forecasts;
  final List<HourlyForecast> hourlyForecasts;

  WeatherLoaded(
    this.weather, {
    this.forecasts = const [],
    this.hourlyForecasts = const [],
  });
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);
}

class ForecastLoading extends WeatherState {}

class ForecastLoaded extends WeatherState {
  final List<Forecast> forecast;

  ForecastLoaded(this.forecast);
}

class ForecastError extends WeatherState {
  final String message;

  ForecastError(this.message);
}

class CitiesSearchLoading extends WeatherState {}

class CitiesSearchLoaded extends WeatherState {
  final List<Location> cities;

  CitiesSearchLoaded(this.cities);
}

class CitiesSearchError extends WeatherState {
  final String message;

  CitiesSearchError(this.message);
}

class LocationLoading extends WeatherState {}

class LocationLoaded extends WeatherState {
  final Location location;

  LocationLoaded(this.location);
}

class LocationError extends WeatherState {
  final String message;

  LocationError(this.message);
}

class CitySaved extends WeatherState {}
