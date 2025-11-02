import 'package:hive_flutter/hive_flutter.dart';

/// Hive service for user preferences storage
class HiveService {
  static const String _preferencesBoxName = 'user_preferences';
  static const String _themeModeKey = 'theme_mode';
  static const String _isCelsiusKey = 'is_celsius';
  static const String _defaultCityKey = 'default_city';
  static const String _languageKey = 'language';

  static Box? _preferencesBox;

  /// Initialize Hive and open boxes
  static Future<void> init() async {
    await Hive.initFlutter();
    _preferencesBox = await Hive.openBox(_preferencesBoxName);
  }

  /// Get theme mode from Hive
  static String? getThemeMode() {
    return _preferencesBox?.get(_themeModeKey) as String?;
  }

  /// Save theme mode to Hive
  static Future<void> setThemeMode(String themeMode) async {
    await _preferencesBox?.put(_themeModeKey, themeMode);
  }

  /// Get temperature unit preference (true = Celsius, false = Fahrenheit)
  static bool? getIsCelsius() {
    return _preferencesBox?.get(_isCelsiusKey) as bool?;
  }

  /// Save temperature unit preference
  static Future<void> setIsCelsius(bool isCelsius) async {
    await _preferencesBox?.put(_isCelsiusKey, isCelsius);
  }

  /// Get default city from Hive
  static String? getDefaultCity() {
    return _preferencesBox?.get(_defaultCityKey) as String?;
  }

  /// Save default city to Hive
  static Future<void> setDefaultCity(String? city) async {
    if (city == null) {
      await _preferencesBox?.delete(_defaultCityKey);
    } else {
      await _preferencesBox?.put(_defaultCityKey, city);
    }
  }

  /// Get language preference
  static String? getLanguage() {
    return _preferencesBox?.get(_languageKey) as String?;
  }

  /// Save language preference
  static Future<void> setLanguage(String language) async {
    await _preferencesBox?.put(_languageKey, language);
  }

  /// Clear all preferences
  static Future<void> clearAll() async {
    await _preferencesBox?.clear();
  }

  /// Close boxes (usually on app close)
  static Future<void> close() async {
    await _preferencesBox?.close();
  }
}
