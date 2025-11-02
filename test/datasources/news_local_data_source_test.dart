import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:weather_news_app/core/database/app_database.dart';
import 'package:weather_news_app/features/news/data/datasources/news_local_data_source.dart';
import 'package:weather_news_app/features/news/data/models/article_model.dart';

void main() {
  late AppDatabase database;
  late NewsLocalDataSourceImpl dataSource;

  setUp(() {
    // Create in-memory database for testing
    database = AppDatabase.test(
      LazyDatabase(() async => NativeDatabase.memory()),
    );
    dataSource = NewsLocalDataSourceImpl(database: database);
  });

  tearDown(() async {
    await database.close();
  });

  group('saveArticle', () {
    test('should save article', () async {
      // Arrange
      final article = ArticleModel(
        id: '1',
        title: 'Test Article',
        description: 'Test Description',
        content: 'Test Content',
        url: 'https://example.com',
        imageUrl: null,
        publishedAt: DateTime.now(),
        source: 'Test Source',
        author: 'Test Author',
        category: 'general',
      );

      // Act
      await dataSource.saveArticle(article);

      // Assert
      final saved = await dataSource.getSavedArticles();
      expect(saved.length, 1);
      expect(saved.first.title, 'Test Article');
    });

    test('should not save duplicate article', () async {
      // Arrange
      final article = ArticleModel(
        id: '1',
        title: 'Test Article',
        description: 'Test Description',
        content: 'Test Content',
        url: 'https://example.com',
        imageUrl: null,
        publishedAt: DateTime.now(),
        source: 'Test Source',
        author: 'Test Author',
        category: 'general',
      );

      // Act
      await dataSource.saveArticle(article);
      await dataSource.saveArticle(article); // Try to save again

      // Assert
      final saved = await dataSource.getSavedArticles();
      expect(saved.length, 1);
    });
  });

  group('removeArticle', () {
    test('should remove article', () async {
      // Arrange
      final article = ArticleModel(
        id: '1',
        title: 'Test Article',
        description: 'Test Description',
        content: 'Test Content',
        url: 'https://example.com',
        imageUrl: null,
        publishedAt: DateTime.now(),
        source: 'Test Source',
        author: 'Test Author',
        category: 'general',
      );
      await dataSource.saveArticle(article);

      // Act
      await dataSource.removeArticle(article);

      // Assert
      final saved = await dataSource.getSavedArticles();
      expect(saved.length, 0);
    });
  });

  group('isArticleSaved', () {
    test('should return true when article is saved', () async {
      // Arrange
      final article = ArticleModel(
        id: '1',
        title: 'Test Article',
        description: 'Test Description',
        content: 'Test Content',
        url: 'https://example.com',
        imageUrl: null,
        publishedAt: DateTime.now(),
        source: 'Test Source',
        author: 'Test Author',
        category: 'general',
      );
      await dataSource.saveArticle(article);

      // Act
      final result = await dataSource.isArticleSaved(article);

      // Assert
      expect(result, true);
    });

    test('should return false when article is not saved', () async {
      // Arrange
      final article = ArticleModel(
        id: '1',
        title: 'Test Article',
        description: 'Test Description',
        content: 'Test Content',
        url: 'https://example.com',
        imageUrl: null,
        publishedAt: DateTime.now(),
        source: 'Test Source',
        author: 'Test Author',
        category: 'general',
      );

      // Act
      final result = await dataSource.isArticleSaved(article);

      // Assert
      expect(result, false);
    });
  });
}
