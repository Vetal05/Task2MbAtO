import 'package:flutter_test/flutter_test.dart';
import 'package:weather_news_app/core/error/failures.dart';

void main() {
  group('Failures Tests', () {
    test('ServerFailure should have correct message', () {
      // Arrange
      const failure = ServerFailure('Server error occurred');

      // Assert
      expect(failure.message, 'Server error occurred');
      expect(failure.toString(), contains('ServerFailure'));
    });

    test('NetworkFailure should have correct message', () {
      // Arrange
      const failure = NetworkFailure('No internet connection');

      // Assert
      expect(failure.message, 'No internet connection');
      expect(failure.toString(), contains('NetworkFailure'));
    });

    test('CacheFailure should have correct message', () {
      // Arrange
      const failure = CacheFailure('Cache error');

      // Assert
      expect(failure.message, 'Cache error');
      expect(failure.toString(), contains('CacheFailure'));
    });

    test('LocationFailure should have correct message', () {
      // Arrange
      const failure = LocationFailure('Location error');

      // Assert
      expect(failure.message, 'Location error');
      expect(failure.toString(), contains('LocationFailure'));
    });

    test('AuthFailure should have correct message', () {
      // Arrange
      const failure = AuthFailure('Authentication error');

      // Assert
      expect(failure.message, 'Authentication error');
      expect(failure.toString(), contains('AuthFailure'));
    });

    test('ValidationFailure should have correct message', () {
      // Arrange
      const failure = ValidationFailure('Invalid input');

      // Assert
      expect(failure.message, 'Invalid input');
      expect(failure.toString(), contains('ValidationFailure'));
    });
  });
}
