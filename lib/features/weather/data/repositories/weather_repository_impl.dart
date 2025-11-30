import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/weather.dart';
import '../../domain/entities/forecast.dart';
import '../../domain/entities/location.dart';
import '../../domain/entities/hourly_forecast.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_local_data_source.dart';
import '../datasources/weather_remote_data_source.dart';
import '../models/location_model.dart';
import '../models/one_call_weather_model.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Weather> getCurrentWeather({
    double? latitude,
    double? longitude,
    String? cityName,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final weatherModel = await remoteDataSource.getCurrentWeather(
          latitude: latitude,
          longitude: longitude,
          cityName: cityName,
        );
        await localDataSource.cacheWeather(weatherModel);
        return weatherModel;
      } catch (e) {
        // Намагаємося отримати закешовані дані, якщо мережа не працює
        final cachedWeather = await localDataSource.getCachedWeather();
        if (cachedWeather != null) {
          return cachedWeather;
        }
        rethrow;
      }
    } else {
      final cachedWeather = await localDataSource.getCachedWeather();
      if (cachedWeather != null) {
        return cachedWeather;
      }
      throw const NetworkFailure('No internet connection and no cached data');
    }
  }

  @override
  Future<List<Forecast>> getWeatherForecast({
    double? latitude,
    double? longitude,
    String? cityName,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final forecastModels = await remoteDataSource.getWeatherForecast(
          latitude: latitude,
          longitude: longitude,
          cityName: cityName,
        );
        // Конвертуємо WeatherModel в Forecast
        return forecastModels
            .map(
              (weather) => Forecast(
                date: weather.timestamp,
                weather: weather,
                minTemperature: weather.temperature - 5, // Simplified
                maxTemperature: weather.temperature + 5, // Simplified
                humidity: weather.humidity,
                pressure: weather.pressure,
                windSpeed: weather.windSpeed,
                windDeg: weather.windDirection,
                precipitation: 0, // Not available in current weather API
                precipitationProbability:
                    0.0, // Not available in current weather API
              ),
            )
            .toList();
      } catch (e) {
        throw ServerFailure(e.toString());
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<List<Location>> searchCities(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final locationModels = await remoteDataSource.searchCities(query);
        return locationModels;
      } catch (e) {
        throw ServerFailure(e.toString());
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<List<Location>> getSavedCities() async {
    try {
      final locationModels = await localDataSource.getSavedCities();
      return locationModels;
    } catch (e) {
      throw CacheFailure(e.toString());
    }
  }

  @override
  Future<void> saveCity(Location city) async {
    try {
      await localDataSource.saveCity(
        LocationModel(
          name: city.name,
          country: city.country,
          latitude: city.latitude,
          longitude: city.longitude,
          state: city.state,
          isCurrentLocation: city.isCurrentLocation,
        ),
      );
    } catch (e) {
      throw CacheFailure(e.toString());
    }
  }

  @override
  Future<void> removeCity(Location city) async {
    try {
      await localDataSource.removeCity(
        LocationModel(
          name: city.name,
          country: city.country,
          latitude: city.latitude,
          longitude: city.longitude,
          state: city.state,
          isCurrentLocation: city.isCurrentLocation,
        ),
      );
    } catch (e) {
      throw CacheFailure(e.toString());
    }
  }

  @override
  Future<Location?> getCurrentLocation() async {
    try {
      return await localDataSource.getCurrentLocation();
    } catch (e) {
      throw CacheFailure(e.toString());
    }
  }

  @override
  Future<void> setCurrentLocation(Location location) async {
    try {
      await localDataSource.setCurrentLocation(
        LocationModel(
          name: location.name,
          country: location.country,
          latitude: location.latitude,
          longitude: location.longitude,
          state: location.state,
          isCurrentLocation: location.isCurrentLocation,
        ),
      );
    } catch (e) {
      throw CacheFailure(e.toString());
    }
  }

  @override
  Future<Weather> getOneCallCurrentWeather({
    required double latitude,
    required double longitude,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final oneCallModel = await remoteDataSource.getOneCallWeather(
          latitude: latitude,
          longitude: longitude,
          units: 'metric',
          lang: 'uk', // Ukrainian language
        );
        return oneCallModel.toEntity();
      } catch (e) {
        throw ServerFailure(e.toString());
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<List<Forecast>> getOneCallDailyForecast({
    required double latitude,
    required double longitude,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final oneCallModel = await remoteDataSource.getOneCallWeather(
          latitude: latitude,
          longitude: longitude,
          units: 'metric',
          lang: 'uk',
        );
        return oneCallModel.toForecastEntities();
      } catch (e) {
        throw ServerFailure(e.toString());
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<List<HourlyForecast>> getOneCallHourlyForecast({
    required double latitude,
    required double longitude,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final oneCallModel = await remoteDataSource.getOneCallWeather(
          latitude: latitude,
          longitude: longitude,
          units: 'metric',
          lang: 'uk',
        );
        return oneCallModel.toHourlyForecastEntities();
      } catch (e) {
        throw ServerFailure(e.toString());
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<OneCallWeatherModel> getOneCallRawData({
    required double latitude,
    required double longitude,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final oneCallModel = await remoteDataSource.getOneCallWeather(
          latitude: latitude,
          longitude: longitude,
          units: 'metric',
          lang: 'uk', // Ukrainian language
        );
        return oneCallModel;
      } catch (e) {
        throw ServerFailure(e.toString());
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }
}
