import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_constants.dart';

class ApiKeyService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // Keys for secure storage
  static const String _openWeatherApiKeyKey = 'openweather_api_key';
  static const String _newsApiKeyKey = 'news_api_key';

  // Fallback to constants if secure storage fails
  static String _defaultOpenWeatherApiKey = AppConstants.openWeatherApiKey;
  static String _defaultNewsApiKey = AppConstants.newsApiKey;

  /// Initialize API keys from environment variables and secure storage
  static Future<void> init() async {
    try {
      // Try to load from .env file first (for development)
      await dotenv.load(fileName: '.env');
    } catch (e) {
      // .env file might not exist, that's okay
      print('⚠️ .env file not found, using defaults or secure storage');
    }

    // Try to load from environment variables
    final envOpenWeatherKey = dotenv.env['OPENWEATHER_API_KEY'];
    final envNewsKey = dotenv.env['NEWS_API_KEY'];

    if (envOpenWeatherKey != null && envOpenWeatherKey.isNotEmpty) {
      _defaultOpenWeatherApiKey = envOpenWeatherKey;
      // Save to secure storage
      await _storage.write(
        key: _openWeatherApiKeyKey,
        value: envOpenWeatherKey,
      );
    }

    if (envNewsKey != null && envNewsKey.isNotEmpty) {
      _defaultNewsApiKey = envNewsKey;
      // Save to secure storage
      await _storage.write(key: _newsApiKeyKey, value: envNewsKey);
    }
  }

  /// Get OpenWeatherMap API key
  /// Priority: Secure Storage > Environment Variables > Constants
  static Future<String> getOpenWeatherApiKey() async {
    try {
      // First try secure storage
      final storedKey = await _storage.read(key: _openWeatherApiKeyKey);
      if (storedKey != null && storedKey.isNotEmpty) {
        return storedKey;
      }

      // Then try environment variables
      final envKey = dotenv.env['OPENWEATHER_API_KEY'];
      if (envKey != null && envKey.isNotEmpty) {
        // Save to secure storage for next time
        await _storage.write(key: _openWeatherApiKeyKey, value: envKey);
        return envKey;
      }

      // Fallback to constants
      return _defaultOpenWeatherApiKey;
    } catch (e) {
      print('⚠️ Error getting OpenWeather API key: $e');
      return _defaultOpenWeatherApiKey;
    }
  }

  /// Get News API key
  /// Priority: Secure Storage > Environment Variables > Constants
  static Future<String> getNewsApiKey() async {
    try {
      // First try secure storage
      final storedKey = await _storage.read(key: _newsApiKeyKey);
      if (storedKey != null && storedKey.isNotEmpty) {
        return storedKey;
      }

      // Then try environment variables
      final envKey = dotenv.env['NEWS_API_KEY'];
      if (envKey != null && envKey.isNotEmpty) {
        // Save to secure storage for next time
        await _storage.write(key: _newsApiKeyKey, value: envKey);
        return envKey;
      }

      // Fallback to constants
      return _defaultNewsApiKey;
    } catch (e) {
      print('⚠️ Error getting News API key: $e');
      return _defaultNewsApiKey;
    }
  }

  /// Save API keys to secure storage
  static Future<void> saveOpenWeatherApiKey(String key) async {
    try {
      await _storage.write(key: _openWeatherApiKeyKey, value: key);
      _defaultOpenWeatherApiKey = key;
    } catch (e) {
      print('⚠️ Error saving OpenWeather API key: $e');
    }
  }

  /// Save News API key to secure storage
  static Future<void> saveNewsApiKey(String key) async {
    try {
      await _storage.write(key: _newsApiKeyKey, value: key);
      _defaultNewsApiKey = key;
    } catch (e) {
      print('⚠️ Error saving News API key: $e');
    }
  }

  /// Clear all stored API keys (for logout/security)
  static Future<void> clearApiKeys() async {
    try {
      await _storage.delete(key: _openWeatherApiKeyKey);
      await _storage.delete(key: _newsApiKeyKey);
    } catch (e) {
      print('⚠️ Error clearing API keys: $e');
    }
  }
}
