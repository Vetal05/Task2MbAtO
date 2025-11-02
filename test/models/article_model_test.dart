import 'package:flutter_test/flutter_test.dart';
import 'package:weather_news_app/features/news/data/models/article_model.dart';
import 'package:weather_news_app/features/news/domain/entities/article.dart';

void main() {
  group('ArticleModel Tests', () {
    final tArticleModel = ArticleModel(
      id: 'test-id',
      title: 'Test Title',
      description: 'Test Description',
      content: 'Test Content',
      url: 'https://example.com/article',
      imageUrl: 'https://example.com/image.jpg',
      publishedAt: DateTime(2024, 1, 1, 12, 0),
      source: 'Test Source',
      author: 'Test Author',
      category: 'technology',
    );

    test('should be a subclass of Article entity', () {
      // Assert
      expect(tArticleModel, isA<Article>());
    });

    test('fromJson should return valid ArticleModel with source as Map', () {
      // Arrange
      final jsonMap = {
        'source': {'id': 'test-id', 'name': 'Test Source'},
        'author': 'Test Author',
        'title': 'Test Title',
        'description': 'Test Description',
        'url': 'https://example.com/article',
        'urlToImage': 'https://example.com/image.jpg',
        'publishedAt': '2024-01-01T12:00:00Z',
        'content': 'Test Content',
        'category': 'technology',
      };

      // Act
      final result = ArticleModel.fromJson(jsonMap);

      // Assert
      expect(result, isA<ArticleModel>());
      expect(result.source, 'Test Source');
      expect(result.author, 'Test Author');
      expect(result.title, 'Test Title');
    });

    test('fromJson should handle source as String', () {
      // Arrange
      final jsonMap = {
        'source': 'Test Source',
        'title': 'Test Title',
        'url': 'https://example.com/article',
        'publishedAt': '2024-01-01T12:00:00Z',
        'category': 'technology',
      };

      // Act
      final result = ArticleModel.fromJson(jsonMap);

      // Assert
      expect(result, isA<ArticleModel>());
      expect(result.source, 'Test Source');
    });

    test('fromJson should handle null values', () {
      // Arrange
      final jsonMap = {
        'source': {'id': null, 'name': 'Test Source'},
        'author': null,
        'title': 'Test Title',
        'description': null,
        'url': 'https://example.com/article',
        'urlToImage': null,
        'publishedAt': '2024-01-01T12:00:00Z',
        'content': null,
        'category': 'technology',
      };

      // Act
      final result = ArticleModel.fromJson(jsonMap);

      // Assert
      expect(result, isA<ArticleModel>());
      expect(result.author, isNull);
      expect(result.description, 'No description');
      expect(result.imageUrl, isNull);
      expect(result.content, '');
    });

    test('fromJson should handle invalid date', () {
      // Arrange
      final jsonMap = {
        'source': 'Test Source',
        'title': 'Test Title',
        'url': 'https://example.com/article',
        'publishedAt': 'invalid-date',
        'category': 'technology',
      };

      // Act
      final result = ArticleModel.fromJson(jsonMap);

      // Assert
      expect(result, isA<ArticleModel>());
      expect(result.publishedAt, isA<DateTime>());
    });

    test('toJson should return valid JSON map', () {
      // Act
      final result = tArticleModel.toJson();

      // Assert
      expect(result, isA<Map<String, dynamic>>());
      expect(result['title'], 'Test Title');
      expect(result['author'], 'Test Author');
      expect(result['source'], 'Test Source');
      expect(result['publishedAt'], isA<String>());
    });
  });
}
