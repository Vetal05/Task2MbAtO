part of 'weather_bloc.dart';

abstract class WeatherEvent {}

class GetWeatherEvent extends WeatherEvent {
  final double? latitude;
  final double? longitude;
  final String? cityName;

  GetWeatherEvent({this.latitude, this.longitude, this.cityName});
}

class GetForecastEvent extends WeatherEvent {
  final double? latitude;
  final double? longitude;
  final String? cityName;

  GetForecastEvent({this.latitude, this.longitude, this.cityName});
}

class SearchCitiesEvent extends WeatherEvent {
  final String query;

  SearchCitiesEvent(this.query);
}

class GetCurrentLocationEvent extends WeatherEvent {}

class SaveCityEvent extends WeatherEvent {
  final Location city;

  SaveCityEvent(this.city);
}
