import 'package:flutter_test/flutter_test.dart';
import 'package:weather_news_app/features/weather/data/models/weather_model.dart';
import 'package:weather_news_app/features/weather/domain/entities/weather.dart';

void main() {
  group('WeatherModel', () {
    test('should be a subclass of Weather entity', () {
      // Arrange
      final weatherModel = WeatherModel(
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
      expect(weatherModel, isA<Weather>());
    });

    test('fromJson should return valid WeatherModel', () {
      // Arrange
      final jsonMap = {
        'weather': [
          {
            'id': 800,
            'main': 'Clear',
            'description': 'clear sky',
            'icon': '01d',
          },
        ],
        'main': {
          'temp': 25.0,
          'feels_like': 27.0,
          'humidity': 60,
          'pressure': 1013,
        },
        'wind': {'speed': 5.0, 'deg': 180},
        'sys': {'sunrise': 1704096000, 'sunset': 1704134400, 'country': 'UA'},
        'coord': {'lat': 50.4501, 'lon': 30.5234},
        'visibility': 10000,
        'clouds': {'all': 0},
        'name': 'Kyiv',
      };

      // Act
      final result = WeatherModel.fromJson(jsonMap);

      // Assert
      expect(result, isA<WeatherModel>());
      expect(result.id, 800);
      expect(result.main, 'Clear');
      expect(result.description, 'clear sky');
      expect(result.temperature, 25.0);
      expect(result.feelsLike, 27.0);
      expect(result.cityName, 'Kyiv');
      expect(result.country, 'UA');
    });

    test('fromJson should handle missing optional fields', () {
      // Arrange
      final jsonMap = {
        'weather': [
          {
            'id': 800,
            'main': 'Clear',
            'description': 'clear sky',
            'icon': '01d',
          },
        ],
        'main': {
          'temp': 25.0,
          'feels_like': 27.0,
          'humidity': 60,
          'pressure': 1013,
        },
        'wind': {'speed': 5.0},
        'sys': {'sunrise': 1704096000, 'sunset': 1704134400, 'country': 'UA'},
        'coord': {'lat': 50.4501, 'lon': 30.5234},
        'name': 'Kyiv',
      };

      // Act
      final result = WeatherModel.fromJson(jsonMap);

      // Assert
      expect(result.windDirection, 0);
      expect(result.visibility, 0);
      expect(result.cloudiness, 0);
    });

    test('toJson should return valid JSON map', () {
      // Arrange
      final weatherModel = WeatherModel(
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
      final result = weatherModel.toJson();

      // Assert
      expect(result, isA<Map<String, dynamic>>());
      expect(result['id'], 800);
      expect(result['main'], 'Clear');
      expect(result['temperature'], 25.0);
      expect(result['cityName'], 'Kyiv');
      expect(result['sunrise'], isA<int>());
      expect(result['sunset'], isA<int>());
    });
  });
}
