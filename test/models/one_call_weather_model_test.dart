import 'package:flutter_test/flutter_test.dart';
import 'package:weather_news_app/features/weather/data/models/one_call_weather_model.dart';
import 'package:weather_news_app/features/weather/domain/entities/weather.dart';
import 'package:weather_news_app/features/weather/domain/entities/forecast.dart';
import 'package:weather_news_app/features/weather/domain/entities/hourly_forecast.dart';

void main() {
  group('OneCallWeatherModel', () {
    test('fromJson should return valid OneCallWeatherModel', () {
      // Arrange
      final jsonMap = {
        'lat': 50.4501,
        'lon': 30.5234,
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
          'wind_gust': 7.0,
          'weather': [
            {
              'id': 800,
              'main': 'Clear',
              'description': 'clear sky',
              'icon': '01d',
            },
          ],
        },
        'hourly': [
          {
            'dt': 1704100000,
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
            'pop': 0.0,
            'weather': [
              {
                'id': 800,
                'main': 'Clear',
                'description': 'clear sky',
                'icon': '01d',
              },
            ],
          },
        ],
        'daily': [
          {
            'dt': 1704100000,
            'sunrise': 1704096000,
            'sunset': 1704134400,
            'moonrise': 1704100000,
            'moonset': 1704100000,
            'moon_phase': 0.5,
            'temp': {
              'day': 25.0,
              'min': 20.0,
              'max': 30.0,
              'night': 18.0,
              'eve': 22.0,
              'morn': 19.0,
            },
            'feels_like': {
              'day': 27.0,
              'night': 16.0,
              'eve': 20.0,
              'morn': 17.0,
            },
            'pressure': 1013,
            'humidity': 60,
            'dew_point': 15.0,
            'wind_speed': 5.0,
            'wind_deg': 180,
            'clouds': 0,
            'uvi': 5.0,
            'pop': 0.0,
            'weather': [
              {
                'id': 800,
                'main': 'Clear',
                'description': 'clear sky',
                'icon': '01d',
              },
            ],
          },
        ],
      };

      // Act
      final result = OneCallWeatherModel.fromJson(jsonMap);

      // Assert
      expect(result, isA<OneCallWeatherModel>());
      expect(result.lat, 50.4501);
      expect(result.lon, 30.5234);
      expect(result.timezone, 'Europe/Kyiv');
      expect(result.current, isNotNull);
      expect(result.hourly, isNotEmpty);
      expect(result.daily, isNotEmpty);
    });

    test('fromJson should handle missing optional fields', () {
      // Arrange
      final jsonMap = {
        'lat': 50.4501,
        'lon': 30.5234,
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
      };

      // Act
      final result = OneCallWeatherModel.fromJson(jsonMap);

      // Assert
      expect(result.timezone, '');
      expect(result.timezoneOffset, 0);
      expect(result.hourly, isEmpty);
      expect(result.daily, isEmpty);
      expect(result.alerts, isNull);
    });

    test('toEntity should return valid Weather entity', () {
      // Arrange
      final jsonMap = {
        'lat': 50.4501,
        'lon': 30.5234,
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
      };
      final oneCallModel = OneCallWeatherModel.fromJson(jsonMap);

      // Act
      final result = oneCallModel.toEntity();

      // Assert
      expect(result, isA<Weather>());
      expect(result.temperature, 25.0);
      expect(result.feelsLike, 27.0);
      expect(result.latitude, 50.4501);
      expect(result.longitude, 30.5234);
    });

    test('toForecastEntities should return list of Forecast entities', () {
      // Arrange
      final jsonMap = {
        'lat': 50.4501,
        'lon': 30.5234,
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
        'daily': [
          {
            'dt': 1704100000,
            'sunrise': 1704096000,
            'sunset': 1704134400,
            'moonrise': 1704100000,
            'moonset': 1704100000,
            'moon_phase': 0.5,
            'temp': {
              'day': 25.0,
              'min': 20.0,
              'max': 30.0,
              'night': 18.0,
              'eve': 22.0,
              'morn': 19.0,
            },
            'feels_like': {
              'day': 27.0,
              'night': 16.0,
              'eve': 20.0,
              'morn': 17.0,
            },
            'pressure': 1013,
            'humidity': 60,
            'dew_point': 15.0,
            'wind_speed': 5.0,
            'wind_deg': 180,
            'clouds': 0,
            'uvi': 5.0,
            'pop': 0.0,
            'weather': [
              {
                'id': 800,
                'main': 'Clear',
                'description': 'clear sky',
                'icon': '01d',
              },
            ],
          },
        ],
      };
      final oneCallModel = OneCallWeatherModel.fromJson(jsonMap);

      // Act
      final result = oneCallModel.toForecastEntities();

      // Assert
      expect(result, isA<List<Forecast>>());
      expect(result.length, 1);
      expect(result.first, isA<Forecast>());
    });

    test(
      'toHourlyForecastEntities should return list of HourlyForecast entities',
      () {
        // Arrange
        final jsonMap = {
          'lat': 50.4501,
          'lon': 30.5234,
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
          'hourly': [
            {
              'dt': 1704100000,
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
              'pop': 0.0,
              'weather': [
                {
                  'id': 800,
                  'main': 'Clear',
                  'description': 'clear sky',
                  'icon': '01d',
                },
              ],
            },
          ],
          'daily': [],
        };
        final oneCallModel = OneCallWeatherModel.fromJson(jsonMap);

        // Act
        final result = oneCallModel.toHourlyForecastEntities();

        // Assert
        expect(result, isA<List<HourlyForecast>>());
        expect(result.length, 1);
        expect(result.first, isA<HourlyForecast>());
      },
    );
  });
}
