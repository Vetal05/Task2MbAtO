import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:weather_news_app/core/database/app_database.dart';
import 'package:weather_news_app/core/di/injection.dart';
import 'package:weather_news_app/features/auth/presentation/bloc/auth_bloc.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AuthBloc Tests', () {
    late AuthBloc authBloc;
    late AppDatabase testDatabase;

    setUpAll(() async {
      // Initialize test database (in-memory)
      testDatabase = AppDatabase.test(
        LazyDatabase(() async => NativeDatabase.memory()),
      );
      // Initialize dependencies for testing with test database
      // Skip Hive initialization to avoid plugin issues
      await configureDependencies(testDatabase: testDatabase, skipHiveInit: true);
    });

    tearDownAll(() async {
      await testDatabase.close();
    });

    setUp(() {
      authBloc = serviceLocator.get<AuthBloc>();
    });

    tearDown(() {
      // Don't dispose singleton bloc
    });

    test('initial state should be AuthInitial', () {
      expect(authBloc.state, isA<AuthInitial>());
    });

    test(
      'login with valid credentials should emit AuthAuthenticated',
      () async {
        // Arrange
        const email = 'demo@example.com';
        const password = 'demo123';

        // Act
        await authBloc.login(email, password);

        // Wait for async operation
        await Future.delayed(const Duration(milliseconds: 600));

        // Assert
        expect(authBloc.state, isA<AuthAuthenticated>());
        if (authBloc.state is AuthAuthenticated) {
          final authenticatedState = authBloc.state as AuthAuthenticated;
          expect(authenticatedState.user.email, email);
        }
      },
    );

    test('login with invalid credentials should emit AuthError', () async {
      // Arrange
      const email = 'invalid@example.com';
      const password = 'wrongpassword';

      // Act
      await authBloc.login(email, password);

      // Wait for async operation
      await Future.delayed(const Duration(milliseconds: 600));

      // Assert
      expect(authBloc.state, isA<AuthError>());
    });

    test(
      'register should create new user and emit AuthAuthenticated',
      () async {
        // Arrange
        final email =
            'test${DateTime.now().millisecondsSinceEpoch}@example.com';
        const password = 'test123';
        const name = 'Test User';

        // Act
        await authBloc.register(email, password, name);

        // Wait for async operation
        await Future.delayed(const Duration(milliseconds: 600));

        // Assert
        expect(authBloc.state, isA<AuthAuthenticated>());
        if (authBloc.state is AuthAuthenticated) {
          final authenticatedState = authBloc.state as AuthAuthenticated;
          expect(authenticatedState.user.email, email);
          expect(authenticatedState.user.name, name);
        }
      },
    );

    test('checkAuthStatus should check if user is authenticated', () async {
      // Act
      await authBloc.checkAuthStatus();

      // Wait for async operation
      await Future.delayed(const Duration(milliseconds: 600));

      // Assert - should emit either authenticated or unauthenticated
      expect(
        authBloc.state,
        anyOf(isA<AuthAuthenticated>(), isA<AuthUnauthenticated>()),
      );
    });
  });
}
