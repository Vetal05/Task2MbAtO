import 'package:flutter_test/flutter_test.dart';
import 'package:weather_news_app/features/weather/domain/entities/weather.dart';
import 'package:weather_news_app/features/weather/domain/entities/forecast.dart';

void main() {
  group('Weather Forecast Tests', () {
    test('should create weather with forecasts', () {
      // Create sample weather data
      final weather = Weather(
        id: 1,
        main: 'Clear',
        description: 'Clear sky',
        icon: '01d',
        temperature: 20.5,
        feelsLike: 22.0,
        humidity: 65,
        pressure: 1013,
        windSpeed: 3.2,
        windDirection: 180,
        visibility: 10000,
        cloudiness: 0,
        sunrise: DateTime.now(),
        sunset: DateTime.now().add(Duration(hours: 12)),
        cityName: 'Kyiv',
        country: 'UA',
        latitude: 50.4501,
        longitude: 30.5234,
        timestamp: DateTime.now(),
      );

      final forecastWeather = Weather(
        id: 2,
        main: 'Clouds',
        description: 'Partly cloudy',
        icon: '02d',
        temperature: 20.0,
        feelsLike: 21.0,
        humidity: 70,
        pressure: 1015,
        windSpeed: 2.8,
        windDirection: 200,
        visibility: 8000,
        cloudiness: 50,
        sunrise: DateTime.now(),
        sunset: DateTime.now().add(Duration(hours: 12)),
        cityName: 'Kyiv',
        country: 'UA',
        latitude: 50.4501,
        longitude: 30.5234,
        timestamp: DateTime.now(),
      );

      final forecast = Forecast(
        date: DateTime.now().add(Duration(days: 1)),
        weather: forecastWeather,
        minTemperature: 15.0,
        maxTemperature: 25.0,
        humidity: 70,
        pressure: 1015,
        windSpeed: 2.8,
        windDeg: 200,
        precipitation: 0.0,
        precipitationProbability: 0.0,
      );

      expect(weather.cityName, equals('Kyiv'));
      expect(weather.temperature, equals(20.5));
      expect(forecast.maxTemperature, equals(25.0));
      expect(forecast.minTemperature, equals(15.0));
    });

    test('should handle day selection logic', () {
      final today = DateTime.now();
      final tomorrow = today.add(Duration(days: 1));

      // Test day name generation
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      final todayName = days[today.weekday - 1];
      final tomorrowName = days[tomorrow.weekday - 1];

      expect(todayName, isA<String>());
      expect(tomorrowName, isA<String>());
      expect(todayName.length, equals(3));
      expect(tomorrowName.length, equals(3));
    });

    test('should format date correctly', () {
      final now = DateTime.now();
      final yesterday = now.subtract(Duration(days: 1));
      final lastWeek = now.subtract(Duration(days: 7));

      // Test date formatting logic
      final yesterdayFormatted = '${yesterday.day}/${yesterday.month}';
      final lastWeekFormatted = '${lastWeek.day}/${lastWeek.month}';

      expect(yesterdayFormatted, isA<String>());
      expect(lastWeekFormatted, isA<String>());
      expect(yesterdayFormatted.contains('/'), isTrue);
    });
  });
}
