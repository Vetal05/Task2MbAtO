import '../../domain/entities/forecast.dart';
import 'weather_model.dart';

class ForecastModel extends Forecast {
  const ForecastModel({
    required super.date,
    required super.weather,
    required super.minTemperature,
    required super.maxTemperature,
    required super.humidity,
    required super.pressure,
    required super.windSpeed,
    required super.windDeg,
    required super.precipitation,
    required super.precipitationProbability,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      date: DateTime.parse(json['dt_txt']),
      weather: WeatherModel.fromJson(json),
      minTemperature: (json['main']['temp_min'] as num).toDouble(),
      maxTemperature: (json['main']['temp_max'] as num).toDouble(),
      humidity: json['main']['humidity'],
      pressure: json['main']['pressure'],
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      windDeg: json['wind']['deg'] ?? 0,
      precipitation: (json['rain']?['3h'] ?? 0.0) as double,
      precipitationProbability: json['pop']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dt_txt': date.toIso8601String(),
      'main': {
        'temp_min': minTemperature,
        'temp_max': maxTemperature,
        'humidity': humidity,
        'pressure': pressure,
      },
      'wind': {'speed': windSpeed},
      'rain': {'3h': precipitation},
    };
  }
}
