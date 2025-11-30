import 'package:flutter/foundation.dart';
import '../../domain/entities/weather.dart';
import '../../domain/entities/forecast.dart';
import '../../domain/entities/location.dart';
import '../../domain/entities/hourly_forecast.dart';
import '../../domain/entities/ukraine_city.dart';
import '../../domain/usecases/get_current_weather.dart';
import '../../domain/usecases/get_weather_forecast.dart';
import '../../domain/usecases/search_cities.dart';
import '../../domain/usecases/get_current_location.dart';
import '../../domain/usecases/save_city.dart';
import '../../domain/usecases/get_one_call_weather.dart';
import '../../domain/usecases/get_one_call_raw_data.dart';
import '../../data/datasources/weather_mock_data_source.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends ChangeNotifier {
  final GetCurrentWeather getCurrentWeather;
  final GetWeatherForecast getWeatherForecast;
  final SearchCities searchCities;
  final GetCurrentLocation getCurrentLocation;
  final SaveCity saveCity;
  final GetOneCallWeather getOneCallWeather;
  final GetOneCallDailyForecast getOneCallDailyForecast;
  final GetOneCallHourlyForecast getOneCallHourlyForecast;
  final GetOneCallRawData getOneCallRawData;

  WeatherBloc({
    required this.getCurrentWeather,
    required this.getWeatherForecast,
    required this.searchCities,
    required this.getCurrentLocation,
    required this.saveCity,
    required this.getOneCallWeather,
    required this.getOneCallDailyForecast,
    required this.getOneCallHourlyForecast,
    required this.getOneCallRawData,
  });

  WeatherState _state = WeatherInitial();
  WeatherState get state => _state;

  List<Forecast> _forecasts = [];
  List<HourlyForecast> _hourlyForecasts = [];

  bool _disposed = false;

  void _emit(WeatherState newState) {
    if (_disposed) return;
    _state = newState;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  Future<void> getWeather({
    double? latitude,
    double? longitude,
    String? cityName,
  }) async {
    _emit(WeatherLoading());

    try {
      final weather = await getCurrentWeather(
        latitude: latitude,
        longitude: longitude,
        cityName: cityName,
      );
      _emit(WeatherLoaded(weather, forecasts: _forecasts));
    } catch (e) {
      _emit(WeatherError(e.toString()));
    }
  }

  Future<void> getForecast({
    double? latitude,
    double? longitude,
    String? cityName,
  }) async {
    _emit(ForecastLoading());

    try {
      // Використовуємо мокові дані для демонстрації
      final forecast = WeatherMockDataSource.generateMockForecast();
      _forecasts = forecast;

      if (kDebugMode) {
        print('🌤️ Generated ${forecast.length} forecast days');
        for (int i = 0; i < forecast.length; i++) {
          print(
            '🌤️ Day ${i + 1}: ${forecast[i].date.day}/${forecast[i].date.month} - ${forecast[i].maxTemperature}°C/${forecast[i].minTemperature}°C',
          );
        }
      }

      // Оновлюємо поточний стан погоди з прогнозами, якщо він існує
      if (_state is WeatherLoaded) {
        final currentState = _state as WeatherLoaded;
        _emit(WeatherLoaded(currentState.weather, forecasts: _forecasts));
        if (kDebugMode) {
          print(
            '🌤️ Updated WeatherLoaded with ${_forecasts.length} forecasts',
          );
        }
      } else {
        _emit(ForecastLoaded(forecast));
        if (kDebugMode) {
          print('🌤️ Emitted ForecastLoaded with ${forecast.length} forecasts');
        }
      }
    } catch (e) {
      _emit(ForecastError(e.toString()));
    }
  }

  Future<void> searchCitiesQuery(String query) async {
    _emit(CitiesSearchLoading());

    try {
      final cities = await searchCities(query);
      _emit(CitiesSearchLoaded(cities));
    } catch (e) {
      _emit(CitiesSearchError(e.toString()));
    }
  }

  Future<void> getCurrentLocationData() async {
    _emit(LocationLoading());

    try {
      final location = await getCurrentLocation();
      _emit(LocationLoaded(location));
    } catch (e) {
      _emit(LocationError(e.toString()));
    }
  }

  Future<void> saveCityData(Location city) async {
    try {
      await saveCity(city);
      _emit(CitySaved());
    } catch (e) {
      _emit(WeatherError(e.toString()));
    }
  }

  // Новий метод для One Call API
  Future<void> getOneCallWeatherData({
    required double latitude,
    required double longitude,
  }) async {
    _emit(WeatherLoading());

    try {
      // Робимо один запит One Call API, щоб отримати всі дані
      final oneCallData = await getOneCallRawData(
        latitude: latitude,
        longitude: longitude,
      );

      // Витягуємо погоду, прогнози та погодинні прогнози з однієї відповіді
      final weather = oneCallData.toEntity();
      _forecasts = oneCallData.toForecastEntities();
      _hourlyForecasts = oneCallData.toHourlyForecastEntities();

      if (kDebugMode) {
        print('🌤️ One Call Weather: ${weather.cityName}');
        print('🌤️ Daily forecasts: ${_forecasts.length}');
        print('🌤️ Hourly forecasts: ${_hourlyForecasts.length}');
      }

      _emit(
        WeatherLoaded(
          weather,
          forecasts: _forecasts,
          hourlyForecasts: _hourlyForecasts,
        ),
      );
    } catch (e) {
      _emit(WeatherError(e.toString()));
    }
  }

  // Метод для українських міст
  Future<void> getWeatherForUkrainianCity(UkraineCity city) async {
    _emit(WeatherLoading());

    try {
      // Робимо один запит One Call API, щоб отримати всі дані
      final oneCallData = await getOneCallRawData(
        latitude: city.latitude,
        longitude: city.longitude,
      );

      // Витягуємо погоду, прогнози та погодинні прогнози з однієї відповіді
      final weather = oneCallData.toEntity();
      _forecasts = oneCallData.toForecastEntities();
      _hourlyForecasts = oneCallData.toHourlyForecastEntities();

      // Оновлюємо погоду з назвою міста
      final updatedWeather = Weather(
        id: weather.id,
        main: weather.main,
        description: weather.description,
        icon: weather.icon,
        temperature: weather.temperature,
        feelsLike: weather.feelsLike,
        humidity: weather.humidity,
        pressure: weather.pressure,
        windSpeed: weather.windSpeed,
        windDirection: weather.windDirection,
        visibility: weather.visibility,
        cloudiness: weather.cloudiness,
        sunrise: weather.sunrise,
        sunset: weather.sunset,
        cityName: city.name,
        country: 'UA',
        latitude: city.latitude,
        longitude: city.longitude,
        timestamp: weather.timestamp,
      );

      if (kDebugMode) {
        print('🌤️ Ukrainian City Weather: ${city.name}');
        print('🌤️ Daily forecasts: ${_forecasts.length}');
        print('🌤️ Hourly forecasts: ${_hourlyForecasts.length}');
      }

      _emit(
        WeatherLoaded(
          updatedWeather,
          forecasts: _forecasts,
          hourlyForecasts: _hourlyForecasts,
        ),
      );
    } catch (e) {
      _emit(WeatherError(e.toString()));
    }
  }
}
