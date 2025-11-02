import '../entities/user.dart';
import '../entities/user_settings.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> register(String email, String password, String name);
  Future<void> logout();
  Future<User?> getCurrentUser();
  Future<bool> isAuthenticated();
  Future<void> saveUserSettings(UserSettings settings);
  Future<UserSettings> getUserSettings();
}
