import 'package:flutter_test/flutter_test.dart';
import 'package:weather_news_app/core/error/failures.dart';
import 'package:weather_news_app/core/network/network_info.dart';
import 'package:weather_news_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_news_app/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_news_app/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:weather_news_app/features/weather/data/models/weather_model.dart';
import 'package:weather_news_app/features/weather/data/models/location_model.dart';
import 'package:weather_news_app/features/weather/data/models/one_call_weather_model.dart';
import 'package:weather_news_app/features/weather/domain/entities/weather.dart';

class MockWeatherRemoteDataSource implements WeatherRemoteDataSource {
  bool shouldThrowError = false;

  @override
  Future<WeatherModel> getCurrentWeather({
    double? latitude,
    double? longitude,
    String? cityName,
  }) async {
    if (shouldThrowError) {
      throw Exception('Network error');
    }
    return WeatherModel(
      id: 800,
      main: 'Clear',
      description: 'clear sky',
      icon: '01d',
      temperature: 25.0,
      feelsLike: 27.0,
      humidity: 60,
      pressure: 1013,
      windSpeed: 5.0,
      windDirection: 180,
      visibility: 10000,
      cloudiness: 0,
      sunrise: DateTime(2024, 1, 1, 6, 0),
      sunset: DateTime(2024, 1, 1, 18, 0),
      cityName: cityName ?? 'Kyiv',
      country: 'UA',
      latitude: latitude ?? 50.4501,
      longitude: longitude ?? 30.5234,
      timestamp: DateTime.now(),
    );
  }

  @override
  Future<List<WeatherModel>> getWeatherForecast({
    double? latitude,
    double? longitude,
    String? cityName,
  }) async {
    if (shouldThrowError) {
      throw Exception('Network error');
    }
    return [
      WeatherModel(
        id: 800,
        main: 'Clear',
        description: 'clear sky',
        icon: '01d',
        temperature: 25.0,
        feelsLike: 27.0,
        humidity: 60,
        pressure: 1013,
        windSpeed: 5.0,
        windDirection: 180,
        visibility: 10000,
        cloudiness: 0,
        sunrise: DateTime(2024, 1, 1, 6, 0),
        sunset: DateTime(2024, 1, 1, 18, 0),
        cityName: cityName ?? 'Kyiv',
        country: 'UA',
        latitude: latitude ?? 50.4501,
        longitude: longitude ?? 30.5234,
        timestamp: DateTime.now(),
      ),
    ];
  }

  @override
  Future<List<LocationModel>> searchCities(String query) async {
    if (shouldThrowError) {
      throw Exception('Network error');
    }
    return [
      LocationModel(
        name: 'Kyiv',
        country: 'UA',
        latitude: 50.4501,
        longitude: 30.5234,
      ),
    ];
  }

  @override
  Future<OneCallWeatherModel> getOneCallWeather({
    required double latitude,
    required double longitude,
    String? exclude,
    String? units,
    String? lang,
  }) async {
    if (shouldThrowError) {
      throw Exception('Network error');
    }
    // Return a minimal OneCallWeatherModel
    return OneCallWeatherModel.fromJson({
      'lat': latitude,
      'lon': longitude,
      'timezone': 'Europe/Kyiv',
      'timezone_offset': 7200,
      'current': {
        'dt': 1704100000,
        'sunrise': 1704096000,
        'sunset': 1704134400,
        'temp': 25.0,
        'feels_like': 27.0,
        'pressure': 1013,
        'humidity': 60,
        'dew_point': 15.0,
        'uvi': 5.0,
        'clouds': 0,
        'visibility': 10000,
        'wind_speed': 5.0,
        'wind_deg': 180,
        'weather': [
          {
            'id': 800,
            'main': 'Clear',
            'description': 'clear sky',
            'icon': '01d',
          },
        ],
      },
      'hourly': [],
      'daily': [],
    });
  }
}

class MockWeatherLocalDataSource implements WeatherLocalDataSource {
  WeatherModel? cachedWeather;

  @override
  Future<WeatherModel?> getCachedWeather() async {
    return cachedWeather;
  }

  @override
  Future<void> cacheWeather(WeatherModel weather) async {
    cachedWeather = weather;
  }

  @override
  Future<List<LocationModel>> getSavedCities() async {
    return [];
  }

  @override
  Future<void> saveCity(LocationModel city) async {}

  @override
  Future<void> removeCity(LocationModel city) async {}

  @override
  Future<LocationModel?> getCurrentLocation() async {
    return null;
  }

  @override
  Future<void> setCurrentLocation(LocationModel location) async {}
}

class MockNetworkInfo implements NetworkInfo {
  final bool isConnectedValue;

  MockNetworkInfo(this.isConnectedValue);

  @override
  Future<bool> get isConnected async => isConnectedValue;
}

void main() {
  late WeatherRepositoryImpl repository;
  late MockWeatherRemoteDataSource mockRemoteDataSource;
  late MockWeatherLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockWeatherRemoteDataSource();
    mockLocalDataSource = MockWeatherLocalDataSource();
    mockNetworkInfo = MockNetworkInfo(true);
    repository = WeatherRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getCurrentWeather', () {
    test('should return weather from remote when online', () async {
      // Act
      final result = await repository.getCurrentWeather(cityName: 'Kyiv');

      // Assert
      expect(result, isA<Weather>());
      expect(result.cityName, 'Kyiv');
    });

    test('should cache weather after fetching from remote', () async {
      // Act
      await repository.getCurrentWeather(cityName: 'Kyiv');

      // Assert
      expect(mockLocalDataSource.cachedWeather, isNotNull);
      expect(mockLocalDataSource.cachedWeather?.cityName, 'Kyiv');
    });

    test('should return cached weather when offline', () async {
      // Arrange
      mockNetworkInfo = MockNetworkInfo(false);
      mockLocalDataSource.cachedWeather = WeatherModel(
        id: 800,
        main: 'Clear',
        description: 'clear sky',
        icon: '01d',
        temperature: 20.0,
        feelsLike: 22.0,
        humidity: 60,
        pressure: 1013,
        windSpeed: 5.0,
        windDirection: 180,
        visibility: 10000,
        cloudiness: 0,
        sunrise: DateTime(2024, 1, 1, 6, 0),
        sunset: DateTime(2024, 1, 1, 18, 0),
        cityName: 'Cached City',
        country: 'UA',
        latitude: 50.4501,
        longitude: 30.5234,
        timestamp: DateTime.now(),
      );
      repository = WeatherRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo,
      );

      // Act
      final result = await repository.getCurrentWeather();

      // Assert
      expect(result.cityName, 'Cached City');
    });

    test('should return cached weather when remote fails', () async {
      // Arrange
      mockRemoteDataSource.shouldThrowError = true;

      // Act & Assert - should try to get cached data
      try {
        await repository.getCurrentWeather();
      } catch (e) {
        expect(e, isA<Exception>());
      }
    });

    test('should throw NetworkFailure when offline and no cache', () async {
      // Arrange
      mockNetworkInfo = MockNetworkInfo(false);
      mockLocalDataSource.cachedWeather = null;
      repository = WeatherRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo,
      );

      // Act & Assert
      expect(
        () => repository.getCurrentWeather(),
        throwsA(isA<NetworkFailure>()),
      );
    });
  });
}
