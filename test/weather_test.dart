import 'package:flutter_test/flutter_test.dart';
import 'package:weather_news_app/core/error/failures.dart';
import 'package:weather_news_app/features/weather/domain/entities/weather.dart';

void main() {
  group('Weather Entity Tests', () {
    test('should create weather entity with all required fields', () {
      // Arrange
      final weather = Weather(
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

      // Assert
      expect(weather.id, 800);
      expect(weather.main, 'Clear');
      expect(weather.description, 'clear sky');
      expect(weather.temperature, 25.0);
      expect(weather.cityName, 'Kyiv');
      expect(weather.country, 'UA');
    });
  });

  group('Failure Tests', () {
    test('should create ServerFailure with message', () {
      // Arrange
      const failure = ServerFailure('Server error occurred');

      // Assert
      expect(failure.message, 'Server error occurred');
    });

    test('should create NetworkFailure with message', () {
      // Arrange
      const failure = NetworkFailure('No internet connection');

      // Assert
      expect(failure.message, 'No internet connection');
    });

    test('should create ValidationFailure with message', () {
      // Arrange
      const failure = ValidationFailure('Invalid input');

      // Assert
      expect(failure.message, 'Invalid input');
    });
  });
}
