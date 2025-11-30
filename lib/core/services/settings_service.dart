import '../di/injection.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/entities/user_settings.dart';
import '../../features/weather/domain/entities/ukraine_city.dart';

class SettingsService {
  static AuthRepository? _authRepository;

  static Future<void> init() async {
    // Отримуємо AuthRepository з service locator
    try {
      _authRepository = serviceLocator.get<AuthRepository>();
    } catch (e) {
      // Service locator може бути ще не ініціалізовано
      print('SettingsService: AuthRepository not available yet');
    }
  }

  static AuthRepository? get _authRepo {
    if (_authRepository == null) {
      try {
        _authRepository = serviceLocator.get<AuthRepository>();
      } catch (e) {
        return null;
      }
    }
    return _authRepository;
  }

  static Future<UserSettings?> _getUserSettings() async {
    final repo = _authRepo;
    if (repo == null) return null;

    try {
      return await repo.getUserSettings();
    } catch (e) {
      // Резервний варіант до налаштувань за замовчуванням при помилці
      return const UserSettings();
    }
  }

  static Future<void> _saveSettings(UserSettings settings) async {
    final repo = _authRepo;
    if (repo == null) return;

    try {
      await repo.saveUserSettings(settings);
    } catch (e) {
      print('SettingsService: Failed to save settings: $e');
      rethrow;
    }
  }

  // Налаштування одиниці температури
  static bool get isCelsius {
    // Це синхронний getter, тому не можемо викликати async метод
    // Повертаємо значення за замовчуванням - фактичне значення має завантажуватися з налаштувань користувача
    return true;
  }

  static Future<bool> getIsCelsius() async {
    final settings = await _getUserSettings();
    return settings?.isCelsius ?? true;
  }

  static Future<void> setTemperatureUnit(bool isCelsius) async {
    final settings = await _getUserSettings() ?? const UserSettings();
    final updatedSettings = settings.copyWith(isCelsius: isCelsius);
    await _saveSettings(updatedSettings);
  }

  // Налаштування теми
  static String get themeMode {
    // Це синхронний getter, тому не можемо викликати async метод
    // Повертаємо значення за замовчуванням - фактичне значення має завантажуватися з налаштувань користувача
    return 'dark';
  }

  static Future<String> getThemeMode() async {
    final settings = await _getUserSettings();
    return settings?.themeMode ?? 'dark';
  }

  static Future<void> setThemeMode(String mode) async {
    final settings = await _getUserSettings() ?? const UserSettings();
    final updatedSettings = settings.copyWith(themeMode: mode);
    await _saveSettings(updatedSettings);
  }

  // Налаштування міста за замовчуванням
  static String? get defaultCityName {
    // Синхронний getter - повертаємо null
    return null;
  }

  static Future<String?> getDefaultCityName() async {
    final settings = await _getUserSettings();
    return settings?.defaultCity?.name;
  }

  static double? get defaultCityLat {
    return null;
  }

  static Future<double?> getDefaultCityLat() async {
    final settings = await _getUserSettings();
    return settings?.defaultCity?.latitude;
  }

  static double? get defaultCityLon {
    return null;
  }

  static Future<double?> getDefaultCityLon() async {
    final settings = await _getUserSettings();
    return settings?.defaultCity?.longitude;
  }

  static String? get defaultCityRegion {
    return null;
  }

  static Future<String?> getDefaultCityRegion() async {
    final settings = await _getUserSettings();
    return settings?.defaultCity?.region;
  }

  static int? get defaultCityPopulation {
    return null;
  }

  static Future<int?> getDefaultCityPopulation() async {
    final settings = await _getUserSettings();
    return settings?.defaultCity?.population;
  }

  static Future<void> setDefaultCity({
    required String name,
    required double lat,
    required double lon,
    required String region,
    required int population,
  }) async {
    final city = UkraineCity(
      name: name,
      latitude: lat,
      longitude: lon,
      region: region,
      population: population,
    );

    final settings = await _getUserSettings() ?? const UserSettings();
    final updatedSettings = settings.copyWith(defaultCity: city);
    await _saveSettings(updatedSettings);
  }

  static Future<void> clearDefaultCity() async {
    final settings = await _getUserSettings() ?? const UserSettings();
    final updatedSettings = settings.copyWith(defaultCity: null);
    await _saveSettings(updatedSettings);
  }
}
