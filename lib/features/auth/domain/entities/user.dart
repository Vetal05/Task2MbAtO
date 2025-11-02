import 'user_settings.dart';

class User {
  final String id;
  final String email;
  final String name;
  final String? avatarUrl;
  final UserSettings settings;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.avatarUrl,
    UserSettings? settings,
  }) : settings = settings ?? const UserSettings();

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? avatarUrl,
    UserSettings? settings,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      settings: settings ?? this.settings,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email;

  @override
  int get hashCode => id.hashCode ^ email.hashCode;
}
