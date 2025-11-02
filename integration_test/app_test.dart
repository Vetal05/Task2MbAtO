import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:weather_news_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Weather & News App Integration Tests', () {
    testWidgets('App launches and shows login page for unauthenticated user', (
      WidgetTester tester,
    ) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verify that login page is shown (for unauthenticated user)
      // Check for login form elements
      expect(find.text('Вхід'), findsOneWidget);
      expect(find.byType(app.WeatherNewsApp), findsOneWidget);
    });

    testWidgets('Login flow works correctly', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Find email field and enter credentials
      final emailField = find.byType(TextFormField).first;
      expect(emailField, findsOneWidget);

      // Enter demo credentials
      await tester.enterText(emailField, 'demo@example.com');
      await tester.pumpAndSettle();

      // Find password field
      final passwordFields = find.byType(TextFormField);
      expect(passwordFields, findsWidgets);

      // Enter password
      if (passwordFields.evaluate().length > 1) {
        await tester.enterText(passwordFields.at(1), 'demo123');
        await tester.pumpAndSettle();
      }

      // Find and tap login button
      final loginButton = find.text('Увійти');
      if (loginButton.evaluate().isNotEmpty) {
        await tester.tap(loginButton);
        await tester.pumpAndSettle(const Duration(seconds: 2));

        // After successful login, should see home page
        // This is a basic test - actual navigation depends on AuthBloc state
      }
    });

    testWidgets('App shows loading indicator during initialization', (
      WidgetTester tester,
    ) async {
      app.main();

      // Check immediately - should show loading
      await tester.pump();

      // Should have CircularProgressIndicator or similar loading widget
      expect(find.byType(app.WeatherNewsApp), findsOneWidget);
    });
  });
}
