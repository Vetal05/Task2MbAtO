class Weather {
  const Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.windDirection,
    required this.visibility,
    required this.cloudiness,
    required this.sunrise,
    required this.sunset,
    required this.cityName,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  final int id;
  final String main;
  final String description;
  final String icon;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final int pressure;
  final double windSpeed;
  final int windDirection;
  final int visibility;
  final int cloudiness;
  final DateTime sunrise;
  final DateTime sunset;
  final String cityName;
  final String country;
  final double latitude;
  final double longitude;
  final DateTime timestamp;
}
