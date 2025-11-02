import 'weather.dart';

class Forecast {
  const Forecast({
    required this.date,
    required this.weather,
    required this.minTemperature,
    required this.maxTemperature,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.windDeg,
    required this.precipitation,
    required this.precipitationProbability,
  });

  final DateTime date;
  final Weather weather;
  final double minTemperature;
  final double maxTemperature;
  final int humidity;
  final int pressure;
  final double windSpeed;
  final int windDeg;
  final double precipitation;
  final double precipitationProbability;
}
