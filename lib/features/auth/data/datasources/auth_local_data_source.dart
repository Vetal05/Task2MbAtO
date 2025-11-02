import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/user_settings.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUser(User user);
  Future<User?> getCachedUser();
  Future<void> clearUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String _userBoxName = 'auth_user';
  static const String _userKey = 'current_user';

  Box? _userBox;

  AuthLocalDataSourceImpl() {
    _initBox();
  }

  Future<void> _initBox() async {
    if (!Hive.isBoxOpen(_userBoxName)) {
      _userBox = await Hive.openBox(_userBoxName);
    } else {
      _userBox = Hive.box(_userBoxName);
    }
  }

  Future<Box> get _box async {
    if (_userBox == null) {
      await _initBox();
    }
    return _userBox!;
  }

  @override
  Future<void> saveUser(User user) async {
    try {
      final box = await _box;
      final userMap = {
        'id': user.id,
        'email': user.email,
        'name': user.name,
        'avatarUrl': user.avatarUrl,
        'settings': user.settings.toJson(),
      };
      await box.put(_userKey, userMap);
    } catch (e) {
      print('Error saving user to Hive: $e');
      rethrow;
    }
  }

  @override
  Future<User?> getCachedUser() async {
    try {
      final box = await _box;
      final userMap = box.get(_userKey) as Map<dynamic, dynamic>?;

      if (userMap == null) return null;

      // Convert dynamic map to typed map
      final Map<String, dynamic> typedMap = {
        'id': userMap['id'] as String,
        'email': userMap['email'] as String,
        'name': userMap['name'] as String,
        'avatarUrl': userMap['avatarUrl'] as String?,
        'settings': userMap['settings'] as Map<String, dynamic>?,
      };

      final settingsJson = typedMap['settings'] as Map<String, dynamic>?;
      final settings =
          settingsJson != null
              ? UserSettings.fromJson(settingsJson)
              : const UserSettings();

      return User(
        id: typedMap['id'],
        email: typedMap['email'],
        name: typedMap['name'],
        avatarUrl: typedMap['avatarUrl'],
        settings: settings,
      );
    } catch (e) {
      print('Error getting cached user from Hive: $e');
      return null;
    }
  }

  @override
  Future<void> clearUser() async {
    try {
      final box = await _box;
      await box.delete(_userKey);
    } catch (e) {
      print('Error clearing user from Hive: $e');
    }
  }
}
