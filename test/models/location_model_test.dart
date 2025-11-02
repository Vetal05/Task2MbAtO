import 'package:flutter_test/flutter_test.dart';
import 'package:weather_news_app/features/weather/data/models/location_model.dart';
import 'package:weather_news_app/features/weather/domain/entities/location.dart';

void main() {
  group('LocationModel', () {
    test('should be a subclass of Location entity', () {
      // Arrange
      const locationModel = LocationModel(
        name: 'Kyiv',
        country: 'UA',
        latitude: 50.4501,
        longitude: 30.5234,
      );

      // Assert
      expect(locationModel, isA<Location>());
    });

    test('fromJson should return valid LocationModel', () {
      // Arrange
      final jsonMap = {
        'name': 'Kyiv',
        'country': 'UA',
        'lat': 50.4501,
        'lon': 30.5234,
        'state': 'Kyiv Oblast',
        'isCurrentLocation': true,
      };

      // Act
      final result = LocationModel.fromJson(jsonMap);

      // Assert
      expect(result, isA<LocationModel>());
      expect(result.name, 'Kyiv');
      expect(result.country, 'UA');
      expect(result.latitude, 50.4501);
      expect(result.longitude, 30.5234);
      expect(result.state, 'Kyiv Oblast');
      expect(result.isCurrentLocation, true);
    });

    test('fromJson should handle missing optional fields', () {
      // Arrange
      final jsonMap = {
        'name': 'Kyiv',
        'country': 'UA',
        'lat': 50.4501,
        'lon': 30.5234,
      };

      // Act
      final result = LocationModel.fromJson(jsonMap);

      // Assert
      expect(result.state, isNull);
      expect(result.isCurrentLocation, false);
    });

    test('toJson should return valid JSON map', () {
      // Arrange
      const locationModel = LocationModel(
        name: 'Kyiv',
        country: 'UA',
        latitude: 50.4501,
        longitude: 30.5234,
        state: 'Kyiv Oblast',
        isCurrentLocation: true,
      );

      // Act
      final result = locationModel.toJson();

      // Assert
      expect(result, isA<Map<String, dynamic>>());
      expect(result['name'], 'Kyiv');
      expect(result['country'], 'UA');
      expect(result['latitude'], 50.4501);
      expect(result['longitude'], 30.5234);
      expect(result['state'], 'Kyiv Oblast');
      expect(result['isCurrentLocation'], true);
    });
  });
}
