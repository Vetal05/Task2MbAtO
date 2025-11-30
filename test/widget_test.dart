// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:weather_news_app/core/database/app_database.dart';
import 'package:weather_news_app/main.dart';
import 'package:weather_news_app/core/di/injection.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App starts correctly', (WidgetTester tester) async {
    // Initialize test database (in-memory)
    final testDatabase = AppDatabase.test(
      LazyDatabase(() async => NativeDatabase.memory()),
    );
    // Initialize dependencies - skip Hive init to avoid plugin issues
    await configureDependencies(testDatabase: testDatabase, skipHiveInit: true);

    // Build our app and trigger a frame.
    await tester.pumpWidget(const WeatherNewsApp());
    
    // Just pump once to build the widget tree
    await tester.pump();

    // Verify that app is built (at minimum, MaterialApp should be present)
    // Don't wait for all async operations to complete
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
