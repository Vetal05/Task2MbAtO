import 'dart:math';
import '../../domain/entities/user.dart';
import '../../domain/entities/user_settings.dart';

abstract class AuthRemoteDataSource {
  Future<User> login(String email, String password);
  Future<User> register(String email, String password, String name);
  Future<UserSettings> getUserSettings(String userId);
  Future<void> saveUserSettings(String userId, UserSettings settings);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // Mock users database for demo
  static final Map<String, Map<String, dynamic>> _users = {
    'demo@example.com': {
      'password': 'demo123',
      'name': 'Demo User',
      'id': '1',
      'settings': null,
    },
    'test@example.com': {
      'password': 'test123',
      'name': 'Test User',
      'id': '2',
      'settings': null,
    },
  };

  // Mock user settings storage
  static final Map<String, Map<String, dynamic>> _userSettings = {};

  @override
  Future<User> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    if (!_users.containsKey(email)) {
      throw Exception('User not found');
    }

    final userData = _users[email]!;
    if (userData['password'] != password) {
      throw Exception('Invalid password');
    }

    final userId = userData['id'] as String;

    // Load user settings from remote
    final settingsJson = _userSettings[userId];
    final settings =
        settingsJson != null
            ? UserSettings.fromJson(settingsJson)
            : const UserSettings();

    return User(
      id: userId,
      email: email,
      name: userData['name'] as String,
      settings: settings,
    );
  }

  @override
  Future<User> register(String email, String password, String name) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    if (_users.containsKey(email)) {
      throw Exception('User already exists');
    }

    final id = Random().nextInt(10000).toString();
    _users[email] = {
      'password': password,
      'name': name,
      'id': id,
      'settings': null,
    };

    // Initialize default settings for new user
    _userSettings[id] = const UserSettings().toJson();

    return User(id: id, email: email, name: name);
  }

  @override
  Future<UserSettings> getUserSettings(String userId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    final settingsJson = _userSettings[userId];
    if (settingsJson != null) {
      return UserSettings.fromJson(settingsJson);
    }

    // Return default settings if not found
    return const UserSettings();
  }

  @override
  Future<void> saveUserSettings(String userId, UserSettings settings) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    // Save settings to remote storage
    _userSettings[userId] = settings.toJson();
  }
}
