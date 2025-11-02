import '../entities/weather.dart';
import '../entities/forecast.dart';
import '../entities/location.dart';
import '../entities/hourly_forecast.dart';
import '../../data/models/one_call_weather_model.dart';

abstract class WeatherRepository {
  Future<Weather> getCurrentWeather({
    double? latitude,
    double? longitude,
    String? cityName,
  });

  Future<List<Forecast>> getWeatherForecast({
    double? latitude,
    double? longitude,
    String? cityName,
  });

  Future<List<Location>> searchCities(String query);

  Future<List<Location>> getSavedCities();

  Future<void> saveCity(Location city);

  Future<void> removeCity(Location city);

  Future<Location?> getCurrentLocation();

  Future<void> setCurrentLocation(Location location);

  // New One Call API methods
  Future<Weather> getOneCallCurrentWeather({
    required double latitude,
    required double longitude,
  });

  Future<List<Forecast>> getOneCallDailyForecast({
    required double latitude,
    required double longitude,
  });

  Future<List<HourlyForecast>> getOneCallHourlyForecast({
    required double latitude,
    required double longitude,
  });

  Future<OneCallWeatherModel> getOneCallRawData({
    required double latitude,
    required double longitude,
  });
}
