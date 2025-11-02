import 'package:flutter_test/flutter_test.dart';
import 'package:weather_news_app/core/services/api_key_service.dart';
import 'package:weather_news_app/core/constants/app_constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ApiKeyService Tests', () {
    test(
      'getOpenWeatherApiKey should return default key if no env or storage',
      () async {
        // Test that fallback works
        final key = await ApiKeyService.getOpenWeatherApiKey();
        expect(key, isNotEmpty);
        expect(key, AppConstants.openWeatherApiKey);
      },
    );

    test(
      'getNewsApiKey should return default key if no env or storage',
      () async {
        // Test that fallback works
        final key = await ApiKeyService.getNewsApiKey();
        expect(key, isNotEmpty);
        expect(key, AppConstants.newsApiKey);
      },
    );

    test('initializeApiKeys should load keys without errors', () async {
      // This test verifies that initialization doesn't crash
      expect(() => ApiKeyService.init(), returnsNormally);
    });
  });
}
