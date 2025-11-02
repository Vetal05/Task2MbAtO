import 'package:flutter_test/flutter_test.dart';
import 'package:weather_news_app/core/error/failures.dart';
import 'package:weather_news_app/features/weather/domain/usecases/get_current_weather.dart';
import 'package:weather_news_app/features/weather/domain/usecases/get_weather_forecast.dart';
import 'package:weather_news_app/features/weather/domain/usecases/search_cities.dart';
import 'package:weather_news_app/features/weather/domain/usecases/get_current_location.dart';
import 'package:weather_news_app/features/weather/domain/usecases/save_city.dart';
import 'package:weather_news_app/features/weather/domain/usecases/get_one_call_weather.dart';
import 'package:weather_news_app/features/weather/domain/entities/weather.dart';
import 'package:weather_news_app/features/weather/domain/entities/forecast.dart';
import 'package:weather_news_app/features/weather/domain/entities/location.dart';
import 'package:weather_news_app/features/weather/domain/entities/hourly_forecast.dart';
import 'package:weather_news_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_news_app/features/weather/data/models/one_call_weather_model.dart';

class MockWeatherRepository implements WeatherRepository {
  @override
  Future<Weather> getCurrentWeather({
    double? latitude,
    double? longitude,
    String? cityName,
  }) async {
    return Weather(
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
  Future<List<Forecast>> getWeatherForecast({
    double? latitude,
    double? longitude,
    String? cityName,
  }) async {
    return [
      Forecast(
        date: DateTime.now().add(const Duration(days: 1)),
        weather: Weather(
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
        minTemperature: 20.0,
        maxTemperature: 30.0,
        humidity: 60,
        pressure: 1013,
        windSpeed: 5.0,
        windDeg: 180,
        precipitation: 0.0,
        precipitationProbability: 0.0,
      ),
    ];
  }

  @override
  Future<List<Location>> searchCities(String query) async {
    if (query == 'error') {
      throw Exception('Search error');
    }
    return [
      Location(
        name: 'Kyiv',
        country: 'UA',
        latitude: 50.4501,
        longitude: 30.5234,
      ),
    ];
  }

  @override
  Future<Weather> getOneCallCurrentWeather({
    required double latitude,
    required double longitude,
  }) async {
    return Weather(
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
      cityName: 'Current Location',
      country: 'UA',
      latitude: latitude,
      longitude: longitude,
      timestamp: DateTime.now(),
    );
  }

  @override
  Future<List<Forecast>> getOneCallDailyForecast({
    required double latitude,
    required double longitude,
  }) async {
    return [
      Forecast(
        date: DateTime.now().add(const Duration(days: 1)),
        weather: Weather(
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
          cityName: 'Current Location',
          country: 'UA',
          latitude: latitude,
          longitude: longitude,
          timestamp: DateTime.now(),
        ),
        minTemperature: 20.0,
        maxTemperature: 30.0,
        humidity: 60,
        pressure: 1013,
        windSpeed: 5.0,
        windDeg: 180,
        precipitation: 0.0,
        precipitationProbability: 0.0,
      ),
    ];
  }

  @override
  Future<List<HourlyForecast>> getOneCallHourlyForecast({
    required double latitude,
    required double longitude,
  }) async {
    return [
      HourlyForecast(
        dateTime: DateTime.now().add(const Duration(hours: 1)),
        temperature: 25.0,
        feelsLike: 27.0,
        humidity: 60,
        pressure: 1013,
        windSpeed: 5.0,
        windDirection: 180,
        precipitationProbability: 0.0,
        weather: Weather(
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
          cityName: 'Current Location',
          country: 'UA',
          latitude: latitude,
          longitude: longitude,
          timestamp: DateTime.now(),
        ),
      ),
    ];
  }

  @override
  Future<OneCallWeatherModel> getOneCallRawData({
    required double latitude,
    required double longitude,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<List<Location>> getSavedCities() async {
    return [];
  }

  @override
  Future<void> saveCity(Location city) async {}

  @override
  Future<void> removeCity(Location city) async {}

  @override
  Future<Location?> getCurrentLocation() async {
    return Location(
      name: 'Kyiv',
      country: 'UA',
      latitude: 50.4501,
      longitude: 30.5234,
    );
  }

  @override
  Future<void> setCurrentLocation(Location location) async {}
}

void main() {
  late MockWeatherRepository mockRepository;
  late GetCurrentWeather getCurrentWeather;
  late GetWeatherForecast getWeatherForecast;
  late SearchCities searchCities;
  late GetCurrentLocation getCurrentLocation;
  late SaveCity saveCity;
  late GetOneCallWeather getOneCallWeather;

  setUp(() {
    mockRepository = MockWeatherRepository();
    getCurrentWeather = GetCurrentWeather(mockRepository);
    getWeatherForecast = GetWeatherForecast(mockRepository);
    searchCities = SearchCities(mockRepository);
    getCurrentLocation = GetCurrentLocation(mockRepository);
    saveCity = SaveCity(mockRepository);
    getOneCallWeather = GetOneCallWeather(mockRepository);
  });

  group('GetCurrentWeather', () {
    test('should return Weather when called with city name', () async {
      // Act
      final result = await getCurrentWeather(cityName: 'Kyiv');

      // Assert
      expect(result, isA<Weather>());
      expect(result.cityName, 'Kyiv');
      expect(result.temperature, 25.0);
    });

    test('should return Weather when called with coordinates', () async {
      // Act
      final result = await getCurrentWeather(
        latitude: 50.4501,
        longitude: 30.5234,
      );

      // Assert
      expect(result, isA<Weather>());
      expect(result.latitude, 50.4501);
      expect(result.longitude, 30.5234);
    });

    test('should throw ServerFailure on repository error', () async {
      // Arrange
      final errorRepository = _ErrorWeatherRepository();
      final useCase = GetCurrentWeather(errorRepository);

      // Act & Assert
      expect(() => useCase(cityName: 'Kyiv'), throwsA(isA<ServerFailure>()));
    });
  });

  group('GetWeatherForecast', () {
    test('should return list of Forecast', () async {
      // Act
      final result = await getWeatherForecast(cityName: 'Kyiv');

      // Assert
      expect(result, isA<List<Forecast>>());
      expect(result.length, 1);
      expect(result.first, isA<Forecast>());
    });

    test('should throw ServerFailure on repository error', () async {
      // Arrange
      final errorRepository = _ErrorWeatherRepository();
      final useCase = GetWeatherForecast(errorRepository);

      // Act & Assert
      expect(() => useCase(cityName: 'Kyiv'), throwsA(isA<ServerFailure>()));
    });
  });

  group('SearchCities', () {
    test('should return list of Location', () async {
      // Act
      final result = await searchCities('Kyiv');

      // Assert
      expect(result, isA<List<Location>>());
      expect(result.length, 1);
      expect(result.first.name, 'Kyiv');
    });

    test('should throw ValidationFailure on empty query', () async {
      // Act & Assert
      expect(() => searchCities(''), throwsA(isA<ValidationFailure>()));
    });

    test('should throw ServerFailure on repository error', () async {
      // Act & Assert
      expect(() => searchCities('error'), throwsA(isA<ServerFailure>()));
    });
  });

  group('GetOneCallWeather', () {
    test('should return Weather', () async {
      // Act
      final result = await getOneCallWeather(
        latitude: 50.4501,
        longitude: 30.5234,
      );

      // Assert
      expect(result, isA<Weather>());
      expect(result.latitude, 50.4501);
      expect(result.longitude, 30.5234);
    });
  });

  group('GetCurrentLocation', () {
    test('should return Location', () async {
      // Act
      final result = await getCurrentLocation();

      // Assert
      expect(result, isA<Location>());
      expect(result.name, 'Kyiv');
    });

    test('should throw LocationFailure when location is null', () async {
      // Arrange
      final nullRepository = _NullLocationWeatherRepository();
      final useCase = GetCurrentLocation(nullRepository);

      // Act & Assert
      expect(() => useCase(), throwsA(isA<LocationFailure>()));
    });
  });

  group('SaveCity', () {
    test('should save city successfully', () async {
      // Arrange
      final city = Location(
        name: 'Kyiv',
        country: 'UA',
        latitude: 50.4501,
        longitude: 30.5234,
      );

      // Act & Assert
      expect(() => saveCity(city), returnsNormally);
    });

    test('should throw CacheFailure on error', () async {
      // Arrange
      final errorRepository = _ErrorWeatherRepository();
      final useCase = SaveCity(errorRepository);
      final city = Location(
        name: 'Kyiv',
        country: 'UA',
        latitude: 50.4501,
        longitude: 30.5234,
      );

      // Act & Assert
      expect(() => useCase(city), throwsA(isA<CacheFailure>()));
    });
  });
}

class _ErrorWeatherRepository implements WeatherRepository {
  @override
  Future<Weather> getCurrentWeather({
    double? latitude,
    double? longitude,
    String? cityName,
  }) async {
    throw Exception('Network error');
  }

  @override
  Future<List<Forecast>> getWeatherForecast({
    double? latitude,
    double? longitude,
    String? cityName,
  }) async {
    throw Exception('Network error');
  }

  @override
  Future<List<Location>> searchCities(String query) async {
    throw Exception('Network error');
  }

  @override
  Future<Weather> getOneCallCurrentWeather({
    required double latitude,
    required double longitude,
  }) async {
    throw Exception('Network error');
  }

  @override
  Future<List<Forecast>> getOneCallDailyForecast({
    required double latitude,
    required double longitude,
  }) async {
    throw Exception('Network error');
  }

  @override
  Future<List<HourlyForecast>> getOneCallHourlyForecast({
    required double latitude,
    required double longitude,
  }) async {
    throw Exception('Network error');
  }

  @override
  Future<OneCallWeatherModel> getOneCallRawData({
    required double latitude,
    required double longitude,
  }) async {
    throw Exception('Network error');
  }

  @override
  Future<List<Location>> getSavedCities() async {
    throw Exception('Error');
  }

  @override
  Future<void> saveCity(Location city) async {
    throw Exception('Error');
  }

  @override
  Future<void> removeCity(Location city) async {
    throw Exception('Error');
  }

  @override
  Future<Location?> getCurrentLocation() async {
    throw Exception('Error');
  }

  @override
  Future<void> setCurrentLocation(Location location) async {
    throw Exception('Error');
  }
}

class _NullLocationWeatherRepository implements WeatherRepository {
  @override
  Future<Location?> getCurrentLocation() async {
    return null;
  }

  @override
  Future<Weather> getCurrentWeather({
    double? latitude,
    double? longitude,
    String? cityName,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<List<Forecast>> getWeatherForecast({
    double? latitude,
    double? longitude,
    String? cityName,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<List<Location>> searchCities(String query) async {
    throw UnimplementedError();
  }

  @override
  Future<List<Location>> getSavedCities() async {
    throw UnimplementedError();
  }

  @override
  Future<void> saveCity(Location city) async {
    throw UnimplementedError();
  }

  @override
  Future<void> removeCity(Location city) async {
    throw UnimplementedError();
  }

  @override
  Future<void> setCurrentLocation(Location location) async {
    throw UnimplementedError();
  }

  @override
  Future<Weather> getOneCallCurrentWeather({
    required double latitude,
    required double longitude,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<List<Forecast>> getOneCallDailyForecast({
    required double latitude,
    required double longitude,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<List<HourlyForecast>> getOneCallHourlyForecast({
    required double latitude,
    required double longitude,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<OneCallWeatherModel> getOneCallRawData({
    required double latitude,
    required double longitude,
  }) async {
    throw UnimplementedError();
  }
}
