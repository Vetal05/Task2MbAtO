import 'package:flutter_test/flutter_test.dart';
import 'package:weather_news_app/features/news/data/models/article_model.dart';

void main() {
  group('NewsAPI Integration Tests', () {
    test('should parse NewsAPI response correctly', () {
      // Sample NewsAPI response structure
      final jsonResponse = {
        'status': 'ok',
        'totalResults': 36,
        'articles': [
          {
            'source': {'id': 'the-verge', 'name': 'The Verge'},
            'author': 'David Pierce',
            'title': 'I need a life cool enough for the new GoPro',
            'description':
                'Hi, friends! Welcome to Installer No. 99, your guide to the best and Verge-iest stuff in the world.',
            'url':
                'https://www.theverge.com/tech/787032/gopro-max-chatgpt-pulse-silent-hill-installer',
            'urlToImage':
                'https://platform.theverge.com/wp-content/uploads/sites/2/2025/09/Installer-99.jpeg',
            'publishedAt': '2025-09-28T11:25:08Z',
            'content':
                'Plus, in this weeks Installer: ChatGPTs daily digest, a terrific iPhone review...',
          },
          {
            'source': {'id': null, 'name': 'Android Central'},
            'author': 'michael.hicks@futurenet.com (Michael L Hicks)',
            'title': 'Ray-Ban Meta (Gen 2) impressions: Fantastic battery life',
            'description':
                'I\'ve spent over a week with the Ray-Ban Meta (Gen 2) glasses...',
            'url':
                'https://www.androidcentral.com/wearables/ray-ban-meta-gen-2-hands-on-impressions',
            'urlToImage':
                'https://cdn.mos.cms.futurecdn.net/jeoNejAeVxk9e9s8Fm9bn.jpg',
            'publishedAt': '2025-09-28T16:01:06Z',
            'content':
                'Testing the Ray-Ban Meta Gen 2 glasses for the past week...',
          },
        ],
      };

      // Test parsing individual articles
      final articles = jsonResponse['articles'] as List<dynamic>;

      for (var articleJson in articles) {
        final article = ArticleModel.fromJson(
          articleJson as Map<String, dynamic>,
        );

        expect(article.title, isNotEmpty);
        expect(article.description, isNotEmpty);
        expect(article.url, isNotEmpty);
        expect(article.source, isNotEmpty);
        expect(article.publishedAt, isA<DateTime>());
      }
    });

    test('should handle missing fields gracefully', () {
      final jsonWithMissingFields = {
        'source': {'id': null, 'name': null},
        'author': null,
        'title': null,
        'description': null,
        'url': null,
        'urlToImage': null,
        'publishedAt': null,
        'content': null,
      };

      final article = ArticleModel.fromJson(jsonWithMissingFields);

      expect(article.title, equals('No title'));
      expect(article.description, equals('No description'));
      expect(article.url, equals(''));
      expect(article.source, equals(''));
      expect(article.publishedAt, isA<DateTime>());
    });

    test('should handle invalid date format', () {
      final jsonWithInvalidDate = {
        'source': {'name': 'Test Source'},
        'title': 'Test Article',
        'description': 'Test Description',
        'url': 'https://test.com',
        'publishedAt': 'invalid-date',
        'content': 'Test content',
      };

      final article = ArticleModel.fromJson(jsonWithInvalidDate);

      expect(article.title, equals('Test Article'));
      expect(article.publishedAt, isA<DateTime>());
      // Should default to current time when parsing fails
      expect(
        article.publishedAt.isBefore(DateTime.now().add(Duration(seconds: 1))),
        isTrue,
      );
    });

    test('should handle string source instead of object', () {
      final jsonWithStringSource = {
        'source': 'BBC News',
        'title': 'Test Article',
        'description': 'Test Description',
        'url': 'https://test.com',
        'publishedAt': '2025-09-28T11:25:08Z',
        'content': 'Test content',
      };

      final article = ArticleModel.fromJson(jsonWithStringSource);

      expect(article.source, equals('BBC News'));
    });
  });
}
