import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:weather_news_app/core/database/app_database.dart';
import 'package:weather_news_app/core/di/injection.dart';
import 'package:weather_news_app/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_news_app/features/news/presentation/bloc/news_bloc.dart';

void main() {
  group('Dependency Injection Tests', () {
    late AppDatabase testDatabase;

    setUp(() async {
      // Initialize test database (in-memory)
      testDatabase = AppDatabase.test(
        LazyDatabase(() async => NativeDatabase.memory()),
      );
      await configureDependencies(testDatabase: testDatabase);
    });

    tearDown(() async {
      await testDatabase.close();
    });

    test('should register and retrieve WeatherBloc', () {
      // Act
      final weatherBloc = serviceLocator.get<WeatherBloc>();

      // Assert
      expect(weatherBloc, isA<WeatherBloc>());
      expect(weatherBloc.state, isA<WeatherState>());
    });

    test('should register and retrieve NewsBloc', () {
      // Act
      final newsBloc = serviceLocator.get<NewsBloc>();

      // Assert
      expect(newsBloc, isA<NewsBloc>());
      expect(newsBloc.state, isA<NewsState>());
    });

    test('should throw exception for unregistered service', () {
      // Assert
      expect(() => serviceLocator.get<String>(), throwsA(isA<Exception>()));
    });
  });
}
