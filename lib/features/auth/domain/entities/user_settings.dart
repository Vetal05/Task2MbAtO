import '../../../weather/domain/entities/ukraine_city.dart';

class UserSettings {
  final bool isCelsius;
  final String themeMode; // 'light', 'dark', 'system'
  final UkraineCity? defaultCity;

  const UserSettings({
    this.isCelsius = true,
    this.themeMode = 'dark',
    this.defaultCity,
  });

  UserSettings copyWith({
    bool? isCelsius,
    String? themeMode,
    UkraineCity? defaultCity,
  }) {
    return UserSettings(
      isCelsius: isCelsius ?? this.isCelsius,
      themeMode: themeMode ?? this.themeMode,
      defaultCity: defaultCity ?? this.defaultCity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isCelsius': isCelsius,
      'themeMode': themeMode,
      'defaultCity': defaultCity?.toJson(),
    };
  }

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      isCelsius: json['isCelsius'] as bool? ?? true,
      themeMode: json['themeMode'] as String? ?? 'dark',
      defaultCity:
          json['defaultCity'] != null
              ? UkraineCity.fromJson(
                json['defaultCity'] as Map<String, dynamic>,
              )
              : null,
    );
  }
}
