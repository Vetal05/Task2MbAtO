import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/user_settings.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<User> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.login(email, password);
        await localDataSource.saveUser(user);
        return user;
      } catch (e) {
        throw ServerFailure(e.toString());
      }
    } else {
      // Намагаємося використати закешованого користувача, якщо офлайн
      final cachedUser = await localDataSource.getCachedUser();
      if (cachedUser != null && cachedUser.email == email) {
        return cachedUser;
      }
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<User> register(String email, String password, String name) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.register(email, password, name);
        await localDataSource.saveUser(user);
        return user;
      } catch (e) {
        throw ServerFailure(e.toString());
      }
    } else {
      throw const NetworkFailure(
        'No internet connection required for registration',
      );
    }
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearUser();
  }

  @override
  Future<User?> getCurrentUser() async {
    return await localDataSource.getCachedUser();
  }

  @override
  Future<bool> isAuthenticated() async {
    final user = await localDataSource.getCachedUser();
    return user != null;
  }

  @override
  Future<void> saveUserSettings(UserSettings settings) async {
    final user = await getCurrentUser();
    if (user == null) {
      throw Exception('User not authenticated');
    }

    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.saveUserSettings(user.id, settings);
        // Оновлюємо закешованого користувача з новими налаштуваннями
        final updatedUser = user.copyWith(settings: settings);
        await localDataSource.saveUser(updatedUser);
      } catch (e) {
        throw ServerFailure(e.toString());
      }
    } else {
      // Зберігаємо в локальний кеш, якщо офлайн (синхронізується, коли буде онлайн)
      final updatedUser = user.copyWith(settings: settings);
      await localDataSource.saveUser(updatedUser);
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<UserSettings> getUserSettings() async {
    final user = await getCurrentUser();
    if (user == null) {
      return const UserSettings();
    }

    if (await networkInfo.isConnected) {
      try {
        final settings = await remoteDataSource.getUserSettings(user.id);
        // Оновлюємо закешованого користувача з останніми налаштуваннями
        final updatedUser = user.copyWith(settings: settings);
        await localDataSource.saveUser(updatedUser);
        return settings;
      } catch (e) {
        // Резервний варіант до закешованих налаштувань
        return user.settings;
      }
    } else {
      // Повертаємо закешовані налаштування, якщо офлайн
      return user.settings;
    }
  }
}
