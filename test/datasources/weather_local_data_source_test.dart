import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:weather_news_app/core/database/app_database.dart';
import 'package:weather_news_app/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:weather_news_app/features/weather/data/models/weather_model.dart';
import 'package:weather_news_app/features/weather/data/models/location_model.dart';

void main() {
  late AppDatabase database;
  late WeatherLocalDataSourceImpl dataSource;

  setUp(() {
    // Create in-memory database for testing
    database = AppDatabase.test(
      LazyDatabase(() async => NativeDatabase.memory()),
    );
    dataSource = WeatherLocalDataSourceImpl(database: database);
  });

  tearDown(() async {
    await database.close();
  });

  group('cacheWeather', () {
    test('should cache weather model', () async {
      // Arrange
      final weather = WeatherModel(
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
        cityName: 'Kyiv',
        country: 'UA',
        latitude: 50.4501,
        longitude: 30.5234,
        timestamp: DateTime.now(),
      );

      // Act
      await dataSource.cacheWeather(weather);

      // Assert
      final cached = await dataSource.getCachedWeather();
      expect(cached, isNotNull);
      expect(cached?.cityName, 'Kyiv');
    });
  });

  group('getCachedWeather', () {
    test('should return null when no cached weather', () async {
      // Act
      final result = await dataSource.getCachedWeather();

      // Assert
      expect(result, isNull);
    });
  });

  group('saveCity', () {
    test('should save city', () async {
      // Arrange
      final city = LocationModel(
        name: 'Kyiv',
        country: 'UA',
        latitude: 50.4501,
        longitude: 30.5234,
      );

      // Act
      await dataSource.saveCity(city);

      // Assert
      final cities = await dataSource.getSavedCities();
      expect(cities.length, 1);
      expect(cities.first.name, 'Kyiv');
    });

    test('should not save duplicate city', () async {
      // Arrange
      final city = LocationModel(
        name: 'Kyiv',
        country: 'UA',
        latitude: 50.4501,
        longitude: 30.5234,
      );

      // Act
      await dataSource.saveCity(city);
      await dataSource.saveCity(city); // Try to save again

      // Assert
      final cities = await dataSource.getSavedCities();
      expect(cities.length, 1);
    });
  });

  group('removeCity', () {
    test('should remove city', () async {
      // Arrange
      final city = LocationModel(
        name: 'Kyiv',
        country: 'UA',
        latitude: 50.4501,
        longitude: 30.5234,
      );
      await dataSource.saveCity(city);

      // Act
      await dataSource.removeCity(city);

      // Assert
      final cities = await dataSource.getSavedCities();
      expect(cities.length, 0);
    });
  });

  group('getCurrentLocation', () {
    test('should return null when no current location set', () async {
      // Act
      final result = await dataSource.getCurrentLocation();

      // Assert
      expect(result, isNull);
    });

    test('should return set current location', () async {
      // Arrange
      final location = LocationModel(
        name: 'Kyiv',
        country: 'UA',
        latitude: 50.4501,
        longitude: 30.5234,
      );

      // Act
      await dataSource.setCurrentLocation(location);
      final result = await dataSource.getCurrentLocation();

      // Assert
      expect(result, isNotNull);
      expect(result?.name, 'Kyiv');
    });
  });
}
