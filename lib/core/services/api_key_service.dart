import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_constants.dart';

class ApiKeyService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // Ключі для безпечного сховища
  static const String _openWeatherApiKeyKey = 'openweather_api_key';
  static const String _newsApiKeyKey = 'news_api_key';

  // Резервний варіант до констант, якщо безпечне сховище не працює
  static String _defaultOpenWeatherApiKey = AppConstants.openWeatherApiKey;
  static String _defaultNewsApiKey = AppConstants.newsApiKey;

  /// Ініціалізує API ключі з змінних середовища та безпечного сховища
  static Future<void> init() async {
    try {
      // Спочатку намагаємося завантажити з .env файлу (для розробки)
      await dotenv.load(fileName: '.env');
    } catch (e) {
      // .env файл може не існувати, це нормально
      debugPrint('⚠️ .env file not found, using defaults or secure storage');
    }

    // Намагаємося завантажити з змінних середовища (тільки якщо dotenv ініціалізовано)
    String? envOpenWeatherKey;
    String? envNewsKey;

    try {
      if (dotenv.isInitialized) {
        envOpenWeatherKey = dotenv.env['OPENWEATHER_API_KEY'];
        envNewsKey = dotenv.env['NEWS_API_KEY'];
      }
    } catch (e) {
      // dotenv може бути не ініціалізовано, це нормально
      debugPrint('⚠️ dotenv not initialized, using defaults or secure storage');
    }

    if (envOpenWeatherKey != null && envOpenWeatherKey.isNotEmpty) {
      _defaultOpenWeatherApiKey = envOpenWeatherKey;
      // Зберігаємо в безпечне сховище
      await _storage.write(
        key: _openWeatherApiKeyKey,
        value: envOpenWeatherKey,
      );
    }

    if (envNewsKey != null && envNewsKey.isNotEmpty) {
      _defaultNewsApiKey = envNewsKey;
      // Зберігаємо в безпечне сховище
      await _storage.write(key: _newsApiKeyKey, value: envNewsKey);
    }
  }

  /// Отримує API ключ OpenWeatherMap
  /// Пріоритет: Безпечне сховище > Змінні середовища > Константи
  static Future<String> getOpenWeatherApiKey() async {
    try {
      // Спочатку намагаємося з безпечного сховища
      final storedKey = await _storage.read(key: _openWeatherApiKeyKey);
      if (storedKey != null && storedKey.isNotEmpty) {
        return storedKey;
      }

      // Потім намагаємося з змінних середовища (тільки якщо dotenv ініціалізовано)
      String? envKey;
      try {
        if (dotenv.isInitialized) {
          envKey = dotenv.env['OPENWEATHER_API_KEY'];
        }
      } catch (e) {
        // dotenv може бути не ініціалізовано, пропускаємо
      }
      if (envKey != null && envKey.isNotEmpty) {
        // Зберігаємо в безпечне сховище для наступного разу
        await _storage.write(key: _openWeatherApiKeyKey, value: envKey);
        return envKey;
      }

      // Резервний варіант до констант
      return _defaultOpenWeatherApiKey;
    } catch (e) {
      debugPrint('⚠️ Error getting OpenWeather API key: $e');
      return _defaultOpenWeatherApiKey;
    }
  }

  /// Отримує API ключ News
  /// Пріоритет: Безпечне сховище > Змінні середовища > Константи
  static Future<String> getNewsApiKey() async {
    try {
      // Спочатку намагаємося з безпечного сховища
      final storedKey = await _storage.read(key: _newsApiKeyKey);
      if (storedKey != null && storedKey.isNotEmpty) {
        return storedKey;
      }

      // Потім намагаємося з змінних середовища (тільки якщо dotenv ініціалізовано)
      String? envKey;
      try {
        if (dotenv.isInitialized) {
          envKey = dotenv.env['NEWS_API_KEY'];
        }
      } catch (e) {
        // dotenv може бути не ініціалізовано, пропускаємо
      }
      if (envKey != null && envKey.isNotEmpty) {
        // Зберігаємо в безпечне сховище для наступного разу
        await _storage.write(key: _newsApiKeyKey, value: envKey);
        return envKey;
      }

      // Резервний варіант до констант
      return _defaultNewsApiKey;
    } catch (e) {
      debugPrint('⚠️ Error getting News API key: $e');
      return _defaultNewsApiKey;
    }
  }

  /// Зберігає API ключі в безпечне сховище
  static Future<void> saveOpenWeatherApiKey(String key) async {
    try {
      await _storage.write(key: _openWeatherApiKeyKey, value: key);
      _defaultOpenWeatherApiKey = key;
    } catch (e) {
      debugPrint('⚠️ Error saving OpenWeather API key: $e');
    }
  }

  /// Зберігає API ключ News в безпечне сховище
  static Future<void> saveNewsApiKey(String key) async {
    try {
      await _storage.write(key: _newsApiKeyKey, value: key);
      _defaultNewsApiKey = key;
    } catch (e) {
      debugPrint('⚠️ Error saving News API key: $e');
    }
  }

  /// Очищає всі збережені API ключі (для виходу/безпеки)
  static Future<void> clearApiKeys() async {
    try {
      await _storage.delete(key: _openWeatherApiKeyKey);
      await _storage.delete(key: _newsApiKeyKey);
    } catch (e) {
      debugPrint('⚠️ Error clearing API keys: $e');
    }
  }
}
