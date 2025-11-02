import '../entities/weather.dart';
import '../entities/forecast.dart';
import '../entities/hourly_forecast.dart';
import '../repositories/weather_repository.dart';

class GetOneCallWeather {
  final WeatherRepository repository;

  GetOneCallWeather(this.repository);

  Future<Weather> call({
    required double latitude,
    required double longitude,
  }) async {
    return await repository.getOneCallCurrentWeather(
      latitude: latitude,
      longitude: longitude,
    );
  }
}

class GetOneCallDailyForecast {
  final WeatherRepository repository;

  GetOneCallDailyForecast(this.repository);

  Future<List<Forecast>> call({
    required double latitude,
    required double longitude,
  }) async {
    return await repository.getOneCallDailyForecast(
      latitude: latitude,
      longitude: longitude,
    );
  }
}

class GetOneCallHourlyForecast {
  final WeatherRepository repository;

  GetOneCallHourlyForecast(this.repository);

  Future<List<HourlyForecast>> call({
    required double latitude,
    required double longitude,
  }) async {
    return await repository.getOneCallHourlyForecast(
      latitude: latitude,
      longitude: longitude,
    );
  }
}
