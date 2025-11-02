import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:weather_news_app/core/network/dio_client.dart';

void main() {
  group('DioClient', () {
    late DioClient dioClient;

    setUp(() {
      dioClient = DioClient();
    });

    test('should create Dio instance', () {
      expect(dioClient.dio, isA<Dio>());
    });

    test('should return Dio instance for OpenWeather', () {
      final dio = dioClient.getOpenWeatherDio();
      expect(dio, isA<Dio>());
      expect(dio, equals(dioClient.dio));
    });

    test('should return Dio instance for News', () {
      final dio = dioClient.getNewsDio();
      expect(dio, isA<Dio>());
      expect(dio, equals(dioClient.dio));
    });

    test('should have interceptors configured', () {
      final dio = dioClient.dio;
      // Should have logging and retry interceptors
      expect(dio.interceptors.length, greaterThanOrEqualTo(2));
    });
  });
}
