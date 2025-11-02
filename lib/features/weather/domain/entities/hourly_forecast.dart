import 'weather.dart';

class HourlyForecast {
  final DateTime dateTime;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final int pressure;
  final double windSpeed;
  final int windDirection;
  final double precipitationProbability;
  final Weather weather;

  HourlyForecast({
    required this.dateTime,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.windDirection,
    required this.precipitationProbability,
    required this.weather,
  });
}
