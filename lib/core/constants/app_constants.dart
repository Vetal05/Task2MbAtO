import '../services/api_key_service.dart';

class AppConstants {
  // API Configuration
  // Default fallback values - will be replaced by ApiKeyService.init()
  static String openWeatherApiKey = '0709d61beaae1c619a3929e0f7246156';
  static String newsApiKey = 'cc5063353b1049fda8302de34991a92f';

  /// Initialize API keys from secure storage or environment variables
  /// This should be called once at app startup
  static Future<void> initializeApiKeys() async {
    openWeatherApiKey = await ApiKeyService.getOpenWeatherApiKey();
    newsApiKey = await ApiKeyService.getNewsApiKey();
  }

  static const String openWeatherBaseUrl =
      'https://api.openweathermap.org/data/2.5';
  static const String openWeatherOneCallBaseUrl =
      'https://api.openweathermap.org/data/3.0/onecall';
  static const String newsBaseUrl = 'https://newsapi.org/v2';

  // App Configuration
  static const String appName = 'Weather & News App';
  static const String appVersion = '1.0.0';

  // Cache Configuration
  static const Duration cacheExpiration = Duration(hours: 1);
  static const int maxCacheSize = 100;

  // Location Configuration
  static const double defaultLatitude = 50.4501; // Kyiv
  static const double defaultLongitude = 30.5234;

  // Weather Configuration
  static const String defaultCity = 'Kyiv';
  static const String defaultCountry = 'UA';

  // News Configuration
  static const List<String> newsCategories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology',
  ];

  // Storage Keys
  static const String userPreferencesKey = 'user_preferences';
  static const String weatherCacheKey = 'weather_cache';
  static const String newsCacheKey = 'news_cache';
  static const String savedCitiesKey = 'saved_cities';
}
