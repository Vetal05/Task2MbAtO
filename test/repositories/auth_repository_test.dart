import 'package:flutter_test/flutter_test.dart';
import 'package:weather_news_app/core/error/failures.dart';
import 'package:weather_news_app/core/network/network_info.dart';
import 'package:weather_news_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:weather_news_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:weather_news_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:weather_news_app/features/auth/domain/entities/user.dart';
import 'package:weather_news_app/features/auth/domain/entities/user_settings.dart';

class MockAuthRemoteDataSource implements AuthRemoteDataSource {
  bool shouldThrowError = false;

  @override
  Future<User> login(String email, String password) async {
    if (shouldThrowError) {
      throw Exception('Network error');
    }
    return User(
      id: '1',
      email: email,
      name: 'Test User',
      settings: UserSettings(
        isCelsius: true,
        themeMode: 'light',
        defaultCity: null,
      ),
    );
  }

  @override
  Future<User> register(String email, String password, String name) async {
    if (shouldThrowError) {
      throw Exception('Network error');
    }
    return User(
      id: '1',
      email: email,
      name: name,
      settings: UserSettings(
        isCelsius: true,
        themeMode: 'light',
        defaultCity: null,
      ),
    );
  }

  @override
  Future<void> saveUserSettings(String userId, UserSettings settings) async {}

  @override
  Future<UserSettings> getUserSettings(String userId) async {
    return UserSettings(isCelsius: true, themeMode: 'light', defaultCity: null);
  }
}

class MockAuthLocalDataSource implements AuthLocalDataSource {
  User? cachedUser;

  @override
  Future<User?> getCachedUser() async {
    return cachedUser;
  }

  @override
  Future<void> saveUser(User user) async {
    cachedUser = user;
  }

  @override
  Future<void> clearUser() async {
    cachedUser = null;
  }
}

class MockNetworkInfo implements NetworkInfo {
  final bool isConnectedValue;

  MockNetworkInfo(this.isConnectedValue);

  @override
  Future<bool> get isConnected async => isConnectedValue;
}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockAuthLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalDataSource = MockAuthLocalDataSource();
    mockNetworkInfo = MockNetworkInfo(true);
    repository = AuthRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('login', () {
    test('should return User when login succeeds', () async {
      // Act
      final result = await repository.login('test@example.com', 'password');

      // Assert
      expect(result, isA<User>());
      expect(result.email, 'test@example.com');
    });

    test('should cache user after successful login', () async {
      // Act
      await repository.login('test@example.com', 'password');

      // Assert
      expect(mockLocalDataSource.cachedUser, isNotNull);
      expect(mockLocalDataSource.cachedUser?.email, 'test@example.com');
    });

    test('should throw ServerFailure when remote fails', () async {
      // Arrange
      mockRemoteDataSource.shouldThrowError = true;

      // Act & Assert
      expect(
        () => repository.login('test@example.com', 'password'),
        throwsA(isA<ServerFailure>()),
      );
    });

    test('should return cached user when offline and email matches', () async {
      // Arrange
      mockNetworkInfo = MockNetworkInfo(false);
      mockLocalDataSource.cachedUser = User(
        id: '1',
        email: 'test@example.com',
        name: 'Cached User',
        settings: UserSettings(
          isCelsius: true,
          themeMode: 'light',
          defaultCity: null,
        ),
      );
      repository = AuthRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo,
      );

      // Act
      final result = await repository.login('test@example.com', 'password');

      // Assert
      expect(result.email, 'test@example.com');
      expect(result.name, 'Cached User');
    });

    test(
      'should throw NetworkFailure when offline and email does not match',
      () async {
        // Arrange
        mockNetworkInfo = MockNetworkInfo(false);
        mockLocalDataSource.cachedUser = User(
          id: '1',
          email: 'other@example.com',
          name: 'Cached User',
          settings: UserSettings(
            isCelsius: true,
            themeMode: 'light',
            defaultCity: null,
          ),
        );
        repository = AuthRepositoryImpl(
          remoteDataSource: mockRemoteDataSource,
          localDataSource: mockLocalDataSource,
          networkInfo: mockNetworkInfo,
        );

        // Act & Assert
        expect(
          () => repository.login('test@example.com', 'password'),
          throwsA(isA<NetworkFailure>()),
        );
      },
    );
  });

  group('register', () {
    test('should return User when registration succeeds', () async {
      // Act
      final result = await repository.register(
        'test@example.com',
        'password',
        'Test User',
      );

      // Assert
      expect(result, isA<User>());
      expect(result.email, 'test@example.com');
      expect(result.name, 'Test User');
    });

    test('should cache user after successful registration', () async {
      // Act
      await repository.register('test@example.com', 'password', 'Test User');

      // Assert
      expect(mockLocalDataSource.cachedUser, isNotNull);
      expect(mockLocalDataSource.cachedUser?.email, 'test@example.com');
    });
  });
}
