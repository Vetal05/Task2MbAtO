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
  testWidgets('App starts correctly', (WidgetTester tester) async {
    // Initialize test database (in-memory)
    final testDatabase = AppDatabase.test(
      LazyDatabase(() async => NativeDatabase.memory()),
    );
    // Initialize dependencies
    await configureDependencies(testDatabase: testDatabase);

    // Build our app and trigger a frame.
    await tester.pumpWidget(const WeatherNewsApp());
    await tester.pumpAndSettle();

    // Verify that app is built (at minimum, MaterialApp should be present)
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
