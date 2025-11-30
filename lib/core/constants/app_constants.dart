import '../services/api_key_service.dart';

class AppConstants {
  // Конфігурація API
  // Значення за замовчуванням для резервного варіанту - будуть замінені ApiKeyService.init()
  static String openWeatherApiKey = '0709d61beaae1c619a3929e0f7246156';
  static String newsApiKey = 'cc5063353b1049fda8302de34991a92f';

  /// Ініціалізує API ключі з безпечного сховища або змінних середовища
  /// Має викликатися один раз при запуску додатку
  static Future<void> initializeApiKeys() async {
    openWeatherApiKey = await ApiKeyService.getOpenWeatherApiKey();
    newsApiKey = await ApiKeyService.getNewsApiKey();
  }

  static const String openWeatherBaseUrl =
      'https://api.openweathermap.org/data/2.5';
  static const String openWeatherOneCallBaseUrl =
      'https://api.openweathermap.org/data/3.0/onecall';
  static const String newsBaseUrl = 'https://newsapi.org/v2';

  // Конфігурація додатку
  static const String appName = 'Weather & News App';
  static const String appVersion = '1.0.0';

  // Конфігурація кешу
  static const Duration cacheExpiration = Duration(hours: 1);
  static const int maxCacheSize = 100;

  // Конфігурація локації
  static const double defaultLatitude = 50.4501; // Київ
  static const double defaultLongitude = 30.5234;

  // Конфігурація погоди
  static const String defaultCity = 'Kyiv';
  static const String defaultCountry = 'UA';

  // Конфігурація новин
  static const List<String> newsCategories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology',
  ];

  // Ключі сховища
  static const String userPreferencesKey = 'user_preferences';
  static const String weatherCacheKey = 'weather_cache';
  static const String newsCacheKey = 'news_cache';
  static const String savedCitiesKey = 'saved_cities';
}
