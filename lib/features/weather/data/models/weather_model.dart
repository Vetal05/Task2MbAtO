import '../../domain/entities/weather.dart';

class WeatherModel extends Weather {
  const WeatherModel({
    required super.id,
    required super.main,
    required super.description,
    required super.icon,
    required super.temperature,
    required super.feelsLike,
    required super.humidity,
    required super.pressure,
    required super.windSpeed,
    required super.windDirection,
    required super.visibility,
    required super.cloudiness,
    required super.sunrise,
    required super.sunset,
    required super.cityName,
    required super.country,
    required super.latitude,
    required super.longitude,
    required super.timestamp,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    final main = json['main'];
    final wind = json['wind'];
    final sys = json['sys'];
    final coord = json['coord'];

    return WeatherModel(
      id: weather['id'],
      main: weather['main'],
      description: weather['description'],
      icon: weather['icon'],
      temperature: (main['temp'] as num).toDouble(),
      feelsLike: (main['feels_like'] as num).toDouble(),
      humidity: main['humidity'],
      pressure: main['pressure'],
      windSpeed: (wind['speed'] as num).toDouble(),
      windDirection: wind['deg'] ?? 0,
      visibility: json['visibility'] ?? 0,
      cloudiness: (json['clouds'] as Map<String, dynamic>?)?['all'] ?? 0,
      sunrise: DateTime.fromMillisecondsSinceEpoch(sys['sunrise'] * 1000),
      sunset: DateTime.fromMillisecondsSinceEpoch(sys['sunset'] * 1000),
      cityName: json['name'],
      country: sys['country'],
      latitude: (coord['lat'] as num).toDouble(),
      longitude: (coord['lon'] as num).toDouble(),
      timestamp: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
      'temperature': temperature,
      'feelsLike': feelsLike,
      'humidity': humidity,
      'pressure': pressure,
      'windSpeed': windSpeed,
      'windDirection': windDirection,
      'visibility': visibility,
      'cloudiness': cloudiness,
      'sunrise': sunrise.millisecondsSinceEpoch,
      'sunset': sunset.millisecondsSinceEpoch,
      'cityName': cityName,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }
}
