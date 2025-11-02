import 'package:flutter_test/flutter_test.dart';
import 'package:weather_news_app/features/weather/data/models/forecast_model.dart';
import 'package:weather_news_app/features/weather/data/models/weather_model.dart';
import 'package:weather_news_app/features/weather/domain/entities/forecast.dart';

void main() {
  group('ForecastModel', () {
    test('should be a subclass of Forecast entity', () {
      // Arrange
      final forecastModel = ForecastModel(
        date: DateTime(2024, 1, 1, 12, 0),
        weather: WeatherModel(
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
        ),
        minTemperature: 20.0,
        maxTemperature: 30.0,
        humidity: 60,
        pressure: 1013,
        windSpeed: 5.0,
        windDeg: 180,
        precipitation: 0.0,
        precipitationProbability: 0.0,
      );

      // Assert
      expect(forecastModel, isA<Forecast>());
    });

    test('fromJson should return valid ForecastModel', () {
      // Arrange
      final jsonMap = {
        'dt_txt': '2024-01-01 12:00:00',
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
          'temp_min': 20.0,
          'temp_max': 30.0,
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
        'rain': {'3h': 0.0},
        'pop': 0.0,
      };

      // Act
      final result = ForecastModel.fromJson(jsonMap);

      // Assert
      expect(result, isA<ForecastModel>());
      expect(result.date, DateTime(2024, 1, 1, 12, 0));
      expect(result.minTemperature, 20.0);
      expect(result.maxTemperature, 30.0);
      expect(result.humidity, 60);
      expect(result.precipitation, 0.0);
    });

    test('fromJson should handle missing precipitation fields', () {
      // Arrange
      final jsonMap = {
        'dt_txt': '2024-01-01 12:00:00',
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
          'temp_min': 20.0,
          'temp_max': 30.0,
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
      final result = ForecastModel.fromJson(jsonMap);

      // Assert
      expect(result.precipitation, 0.0);
      expect(result.precipitationProbability, 0.0);
    });

    test('fromJson should handle rain precipitation', () {
      // Arrange
      final jsonMap = {
        'dt_txt': '2024-01-01 12:00:00',
        'weather': [
          {
            'id': 500,
            'main': 'Rain',
            'description': 'light rain',
            'icon': '10d',
          },
        ],
        'main': {
          'temp': 15.0,
          'temp_min': 12.0,
          'temp_max': 18.0,
          'feels_like': 14.0,
          'humidity': 80,
          'pressure': 1000,
        },
        'wind': {'speed': 3.0, 'deg': 90},
        'sys': {'sunrise': 1704096000, 'sunset': 1704134400, 'country': 'UA'},
        'coord': {'lat': 50.4501, 'lon': 30.5234},
        'visibility': 8000,
        'clouds': {'all': 75},
        'name': 'Kyiv',
        'rain': {'3h': 2.5},
        'pop': 0.8,
      };

      // Act
      final result = ForecastModel.fromJson(jsonMap);

      // Assert
      expect(result.precipitation, 2.5);
      expect(result.precipitationProbability, 0.8);
    });
  });
}
