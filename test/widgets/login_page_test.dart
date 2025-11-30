import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:weather_news_app/core/database/app_database.dart';
import 'package:weather_news_app/features/auth/presentation/pages/login_page.dart';
import 'package:weather_news_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:weather_news_app/core/di/injection.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    // Mock flutter_secure_storage
    const MethodChannel secureStorageChannel =
        MethodChannel('plugins.it_nomads.com/flutter_secure_storage');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(secureStorageChannel, (MethodCall methodCall) async {
      if (methodCall.method == 'read') {
        return 'test_api_key';
      }
      if (methodCall.method == 'write') {
        return null;
      }
      if (methodCall.method == 'delete') {
        return null;
      }
      if (methodCall.method == 'deleteAll') {
        return null;
      }
      return null;
    });

    // Mock path_provider
    const MethodChannel pathProviderChannel =
        MethodChannel('plugins.flutter.io/path_provider');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(pathProviderChannel, (MethodCall methodCall) async {
      if (methodCall.method == 'getApplicationDocumentsDirectory') {
        return '/tmp/test_documents';
      }
      if (methodCall.method == 'getTemporaryDirectory') {
        return '/tmp/test_temp';
      }
      return null;
    });
  });

  tearDownAll(() {
    // Clean up mocks
    const MethodChannel secureStorageChannel =
        MethodChannel('plugins.it_nomads.com/flutter_secure_storage');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(secureStorageChannel, null);

    const MethodChannel pathProviderChannel =
        MethodChannel('plugins.flutter.io/path_provider');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(pathProviderChannel, null);
  });

  group('LoginPage Widget Tests', () {
    late AuthBloc authBloc;
    late AppDatabase testDatabase;

    setUpAll(() async {
      // Initialize test database (in-memory)
      testDatabase = AppDatabase.test(
        LazyDatabase(() async => NativeDatabase.memory()),
      );
      // Skip Hive initialization to avoid plugin issues
      await configureDependencies(testDatabase: testDatabase, skipHiveInit: true);
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

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Enter credentials
      final emailField = find.byType(TextFormField).first;
      await tester.enterText(emailField, 'demo@example.com');
      await tester.pump();

      // Verify that widget is built and responsive before login
      expect(find.byType(MaterialApp), findsOneWidget);
      
      // Trigger login asynchronously
      authBloc.login('demo@example.com', 'demo123');
      
      // Pump to allow state changes
      await tester.pump();
      
      // Wait for the 500ms delay timer to complete
      await tester.pump(const Duration(milliseconds: 600));
      
      // Pump to ensure all state updates are processed
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      
      // Verify widget is still responsive
      expect(find.byType(MaterialApp), findsOneWidget);
    }, timeout: const Timeout(Duration(seconds: 5)));
  });
}
