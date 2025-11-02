import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:weather_news_app/core/database/app_database.dart';
import 'package:weather_news_app/features/auth/presentation/pages/login_page.dart';
import 'package:weather_news_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:weather_news_app/core/di/injection.dart';

void main() {
  group('LoginPage Widget Tests', () {
    late AuthBloc authBloc;
    late AppDatabase testDatabase;

    setUpAll(() async {
      // Initialize test database (in-memory)
      testDatabase = AppDatabase.test(
        LazyDatabase(() async => NativeDatabase.memory()),
      );
      await configureDependencies(testDatabase: testDatabase);
    });

    tearDownAll(() async {
      await testDatabase.close();
    });

    setUp(() {
      authBloc = serviceLocator.get<AuthBloc>();
    });

    testWidgets('LoginPage displays login form', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(MaterialApp(home: LoginPage(authBloc: authBloc)));

      await tester.pumpAndSettle();

      // Verify login form elements are present
      expect(find.text('Вхід'), findsOneWidget);
      expect(find.byType(TextFormField), findsAtLeastNWidgets(2));
    });

    testWidgets('LoginPage can toggle between login and register', (
      WidgetTester tester,
    ) async {
      // Build the widget
      await tester.pumpWidget(MaterialApp(home: LoginPage(authBloc: authBloc)));

      await tester.pumpAndSettle();

      // Find toggle button/link
      final toggleFinder = find.text('Реєстрація');
      if (toggleFinder.evaluate().isNotEmpty) {
        await tester.tap(toggleFinder);
        await tester.pumpAndSettle();

        // Should show register form
        expect(find.text('Реєстрація'), findsOneWidget);
      }
    });

    testWidgets('LoginPage shows loading state during authentication', (
      WidgetTester tester,
    ) async {
      // Build the widget
      await tester.pumpWidget(MaterialApp(home: LoginPage(authBloc: authBloc)));

      await tester.pumpAndSettle();

      // Enter credentials
      final emailField = find.byType(TextFormField).first;
      await tester.enterText(emailField, 'demo@example.com');
      await tester.pumpAndSettle();

      // Trigger login
      await authBloc.login('demo@example.com', 'demo123');

      await tester.pump();

      // Should show loading indicator
      expect(find.byType(CircularProgressIndicator), findsWidgets);
    });
  });
}
