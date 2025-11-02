import '../../domain/entities/weather.dart';
import '../../domain/entities/forecast.dart';
import '../../domain/entities/hourly_forecast.dart';

class OneCallWeatherModel {
  final double lat;
  final double lon;
  final String timezone;
  final int timezoneOffset;
  final CurrentWeatherModel current;
  final List<HourlyWeatherModel> hourly;
  final List<DailyWeatherModel> daily;
  final List<WeatherAlertModel>? alerts;

  OneCallWeatherModel({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    required this.hourly,
    required this.daily,
    this.alerts,
  });

  factory OneCallWeatherModel.fromJson(Map<String, dynamic> json) {
    return OneCallWeatherModel(
      lat: json['lat']?.toDouble() ?? 0.0,
      lon: json['lon']?.toDouble() ?? 0.0,
      timezone: json['timezone'] ?? '',
      timezoneOffset: json['timezone_offset'] ?? 0,
      current: CurrentWeatherModel.fromJson(json['current']),
      hourly:
          (json['hourly'] as List<dynamic>?)
              ?.map((item) => HourlyWeatherModel.fromJson(item))
              .toList() ??
          [],
      daily:
          (json['daily'] as List<dynamic>?)
              ?.map((item) => DailyWeatherModel.fromJson(item))
              .toList() ??
          [],
      alerts:
          (json['alerts'] as List<dynamic>?)
              ?.map((item) => WeatherAlertModel.fromJson(item))
              .toList(),
    );
  }

  Weather toEntity() {
    return Weather(
      id: current.weather.first.id,
      main: current.weather.first.main,
      description: current.weather.first.description,
      icon: current.weather.first.icon,
      temperature: current.temp,
      feelsLike: current.feelsLike,
      humidity: current.humidity,
      pressure: current.pressure,
      windSpeed: current.windSpeed,
      windDirection: current.windDeg,
      visibility: current.visibility,
      cloudiness: current.clouds,
      sunrise: DateTime.fromMillisecondsSinceEpoch(current.sunrise * 1000),
      sunset: DateTime.fromMillisecondsSinceEpoch(current.sunset * 1000),
      cityName: 'Current Location', // Will be updated with actual city name
      country: '',
      latitude: lat,
      longitude: lon,
      timestamp: DateTime.fromMillisecondsSinceEpoch(current.dt * 1000),
    );
  }

  List<Forecast> toForecastEntities() {
    return daily.map((dailyModel) => dailyModel.toEntity()).toList();
  }

  List<HourlyForecast> toHourlyForecastEntities() {
    return hourly.map((hourlyModel) => hourlyModel.toEntity()).toList();
  }
}

class CurrentWeatherModel {
  final int dt;
  final int sunrise;
  final int sunset;
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double uvi;
  final int clouds;
  final int visibility;
  final double windSpeed;
  final int windDeg;
  final double? windGust;
  final List<WeatherConditionModel> weather;

  CurrentWeatherModel({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    this.windGust,
    required this.weather,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherModel(
      dt: json['dt'] ?? 0,
      sunrise: json['sunrise'] ?? 0,
      sunset: json['sunset'] ?? 0,
      temp: json['temp']?.toDouble() ?? 0.0,
      feelsLike: json['feels_like']?.toDouble() ?? 0.0,
      pressure: json['pressure'] ?? 0,
      humidity: json['humidity'] ?? 0,
      dewPoint: json['dew_point']?.toDouble() ?? 0.0,
      uvi: json['uvi']?.toDouble() ?? 0.0,
      clouds: json['clouds'] ?? 0,
      visibility: json['visibility'] ?? 0,
      windSpeed: json['wind_speed']?.toDouble() ?? 0.0,
      windDeg: json['wind_deg'] ?? 0,
      windGust: json['wind_gust']?.toDouble(),
      weather:
          (json['weather'] as List<dynamic>?)
              ?.map((item) => WeatherConditionModel.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class HourlyWeatherModel {
  final int dt;
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double uvi;
  final int clouds;
  final int visibility;
  final double windSpeed;
  final int windDeg;
  final double? windGust;
  final double pop; // Probability of precipitation
  final List<WeatherConditionModel> weather;
  final RainModel? rain;
  final SnowModel? snow;

  HourlyWeatherModel({
    required this.dt,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    this.windGust,
    required this.pop,
    required this.weather,
    this.rain,
    this.snow,
  });

  factory HourlyWeatherModel.fromJson(Map<String, dynamic> json) {
    return HourlyWeatherModel(
      dt: json['dt'] ?? 0,
      temp: json['temp']?.toDouble() ?? 0.0,
      feelsLike: json['feels_like']?.toDouble() ?? 0.0,
      pressure: json['pressure'] ?? 0,
      humidity: json['humidity'] ?? 0,
      dewPoint: json['dew_point']?.toDouble() ?? 0.0,
      uvi: json['uvi']?.toDouble() ?? 0.0,
      clouds: json['clouds'] ?? 0,
      visibility: json['visibility'] ?? 0,
      windSpeed: json['wind_speed']?.toDouble() ?? 0.0,
      windDeg: json['wind_deg'] ?? 0,
      windGust: json['wind_gust']?.toDouble(),
      pop: json['pop']?.toDouble() ?? 0.0,
      weather:
          (json['weather'] as List<dynamic>?)
              ?.map((item) => WeatherConditionModel.fromJson(item))
              .toList() ??
          [],
      rain: json['rain'] != null ? RainModel.fromJson(json['rain']) : null,
      snow: json['snow'] != null ? SnowModel.fromJson(json['snow']) : null,
    );
  }

  HourlyForecast toEntity() {
    return HourlyForecast(
      dateTime: DateTime.fromMillisecondsSinceEpoch(dt * 1000),
      temperature: temp,
      feelsLike: feelsLike,
      humidity: humidity,
      pressure: pressure,
      windSpeed: windSpeed,
      windDirection: windDeg,
      precipitationProbability: pop,
      weather: Weather(
        id: weather.first.id,
        main: weather.first.main,
        description: weather.first.description,
        icon: weather.first.icon,
        temperature: temp,
        feelsLike: feelsLike,
        humidity: humidity,
        pressure: pressure,
        windSpeed: windSpeed,
        windDirection: windDeg,
        visibility: visibility,
        cloudiness: clouds,
        sunrise: DateTime.now(),
        sunset: DateTime.now(),
        cityName: '',
        country: '',
        latitude: 0.0,
        longitude: 0.0,
        timestamp: DateTime.fromMillisecondsSinceEpoch(dt * 1000),
      ),
    );
  }
}

class DailyWeatherModel {
  final int dt;
  final int sunrise;
  final int sunset;
  final int moonrise;
  final int moonset;
  final double moonPhase;
  final String? summary;
  final DailyTemperatureModel temp;
  final DailyFeelsLikeModel feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double windSpeed;
  final int windDeg;
  final double? windGust;
  final int clouds;
  final double uvi;
  final double pop;
  final double? rain;
  final double? snow;
  final List<WeatherConditionModel> weather;

  DailyWeatherModel({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    this.summary,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.windSpeed,
    required this.windDeg,
    this.windGust,
    required this.clouds,
    required this.uvi,
    required this.pop,
    this.rain,
    this.snow,
    required this.weather,
  });

  factory DailyWeatherModel.fromJson(Map<String, dynamic> json) {
    return DailyWeatherModel(
      dt: json['dt'] ?? 0,
      sunrise: json['sunrise'] ?? 0,
      sunset: json['sunset'] ?? 0,
      moonrise: json['moonrise'] ?? 0,
      moonset: json['moonset'] ?? 0,
      moonPhase: json['moon_phase']?.toDouble() ?? 0.0,
      summary: json['summary'],
      temp: DailyTemperatureModel.fromJson(json['temp']),
      feelsLike: DailyFeelsLikeModel.fromJson(json['feels_like']),
      pressure: json['pressure'] ?? 0,
      humidity: json['humidity'] ?? 0,
      dewPoint: json['dew_point']?.toDouble() ?? 0.0,
      windSpeed: json['wind_speed']?.toDouble() ?? 0.0,
      windDeg: json['wind_deg'] ?? 0,
      windGust: json['wind_gust']?.toDouble(),
      clouds: json['clouds'] ?? 0,
      uvi: json['uvi']?.toDouble() ?? 0.0,
      pop: json['pop']?.toDouble() ?? 0.0,
      rain: json['rain']?.toDouble(),
      snow: json['snow']?.toDouble(),
      weather:
          (json['weather'] as List<dynamic>?)
              ?.map((item) => WeatherConditionModel.fromJson(item))
              .toList() ??
          [],
    );
  }

  Forecast toEntity() {
    return Forecast(
      date: DateTime.fromMillisecondsSinceEpoch(dt * 1000),
      maxTemperature: temp.max,
      minTemperature: temp.min,
      humidity: humidity,
      pressure: pressure,
      windSpeed: windSpeed,
      windDeg: windDeg,
      precipitation: rain ?? snow ?? 0.0,
      precipitationProbability: pop,
      weather: Weather(
        id: weather.first.id,
        main: weather.first.main,
        description: weather.first.description,
        icon: weather.first.icon,
        temperature: temp.day,
        feelsLike: feelsLike.day,
        humidity: humidity,
        pressure: pressure,
        windSpeed: windSpeed,
        windDirection: windDeg,
        visibility: 10000,
        cloudiness: clouds,
        sunrise: DateTime.fromMillisecondsSinceEpoch(sunrise * 1000),
        sunset: DateTime.fromMillisecondsSinceEpoch(sunset * 1000),
        cityName: '',
        country: '',
        latitude: 0.0,
        longitude: 0.0,
        timestamp: DateTime.fromMillisecondsSinceEpoch(dt * 1000),
      ),
    );
  }
}

class DailyTemperatureModel {
  final double day;
  final double min;
  final double max;
  final double night;
  final double eve;
  final double morn;

  DailyTemperatureModel({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  factory DailyTemperatureModel.fromJson(Map<String, dynamic> json) {
    return DailyTemperatureModel(
      day: json['day']?.toDouble() ?? 0.0,
      min: json['min']?.toDouble() ?? 0.0,
      max: json['max']?.toDouble() ?? 0.0,
      night: json['night']?.toDouble() ?? 0.0,
      eve: json['eve']?.toDouble() ?? 0.0,
      morn: json['morn']?.toDouble() ?? 0.0,
    );
  }
}

class DailyFeelsLikeModel {
  final double day;
  final double night;
  final double eve;
  final double morn;

  DailyFeelsLikeModel({
    required this.day,
    required this.night,
    required this.eve,
    required this.morn,
  });

  factory DailyFeelsLikeModel.fromJson(Map<String, dynamic> json) {
    return DailyFeelsLikeModel(
      day: json['day']?.toDouble() ?? 0.0,
      night: json['night']?.toDouble() ?? 0.0,
      eve: json['eve']?.toDouble() ?? 0.0,
      morn: json['morn']?.toDouble() ?? 0.0,
    );
  }
}

class WeatherConditionModel {
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherConditionModel({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherConditionModel.fromJson(Map<String, dynamic> json) {
    return WeatherConditionModel(
      id: json['id'] ?? 0,
      main: json['main'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'] ?? '',
    );
  }
}

class RainModel {
  final double? oneHour;

  RainModel({this.oneHour});

  factory RainModel.fromJson(Map<String, dynamic> json) {
    return RainModel(oneHour: json['1h']?.toDouble());
  }
}

class SnowModel {
  final double? oneHour;

  SnowModel({this.oneHour});

  factory SnowModel.fromJson(Map<String, dynamic> json) {
    return SnowModel(oneHour: json['1h']?.toDouble());
  }
}

class WeatherAlertModel {
  final String senderName;
  final String event;
  final int start;
  final int end;
  final String description;
  final List<String> tags;

  WeatherAlertModel({
    required this.senderName,
    required this.event,
    required this.start,
    required this.end,
    required this.description,
    required this.tags,
  });

  factory WeatherAlertModel.fromJson(Map<String, dynamic> json) {
    return WeatherAlertModel(
      senderName: json['sender_name'] ?? '',
      event: json['event'] ?? '',
      start: json['start'] ?? 0,
      end: json['end'] ?? 0,
      description: json['description'] ?? '',
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }
}
