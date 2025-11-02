import '../models/weather_model.dart';
import '../models/forecast_model.dart';

class WeatherMockDataSource {
  static List<ForecastModel> generateMockForecast() {
    final now = DateTime.now();
    return List.generate(7, (index) {
      final date = now.add(Duration(days: index + 1));
      return ForecastModel(
        date: date,
        weather: WeatherModel(
          id: 800 + index,
          main: 'Clear',
          description: _getDescription(index),
          icon: _getIcon(index),
          temperature: 20.0 + (index * 2),
          feelsLike: 22.0 + (index * 2),
          humidity: 60 + (index * 2),
          pressure: 1013 + index,
          windSpeed: 3.0 + (index * 0.5),
          windDirection: 180 + (index * 30),
          visibility: 10000,
          cloudiness: index * 10,
          sunrise: date.copyWith(hour: 6, minute: 0),
          sunset: date.copyWith(hour: 18, minute: 0),
          cityName: 'Kyiv',
          country: 'UA',
          latitude: 50.4501,
          longitude: 30.5234,
          timestamp: date,
        ),
        minTemperature: 15.0 + (index * 1.5),
        maxTemperature: 25.0 + (index * 2),
        humidity: 60 + (index * 2),
        pressure: 1013 + index,
        windSpeed: 3.0 + (index * 0.5),
        windDeg: 180 + (index * 30),
        precipitation: index % 3 == 0 ? 0.5 : 0.0,
        precipitationProbability: index % 3 == 0 ? 0.3 : 0.0,
      );
    });
  }

  static String _getDescription(int index) {
    final descriptions = [
      'Clear sky',
      'Partly cloudy',
      'Cloudy',
      'Light rain',
      'Clear sky',
      'Partly cloudy',
      'Sunny',
    ];
    return descriptions[index % descriptions.length];
  }

  static String _getIcon(int index) {
    final icons = [
      '01d', // clear sky
      '02d', // partly cloudy
      '03d', // cloudy
      '10d', // rain
      '01d', // clear sky
      '02d', // partly cloudy
      '01d', // sunny
    ];
    return icons[index % icons.length];
  }
}
