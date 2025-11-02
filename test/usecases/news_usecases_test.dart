import 'package:flutter_test/flutter_test.dart';
import 'package:weather_news_app/core/error/failures.dart';
import 'package:weather_news_app/features/news/domain/usecases/search_articles.dart';
import 'package:weather_news_app/features/news/domain/usecases/save_article.dart';
import 'package:weather_news_app/features/news/domain/usecases/get_articles_by_category.dart';
import 'package:weather_news_app/features/news/domain/entities/article.dart';
import 'package:weather_news_app/features/news/domain/repositories/news_repository.dart';

class MockNewsRepository implements NewsRepository {
  @override
  Future<List<Article>> getTopHeadlines({
    String? country,
    String? category,
    String? sources,
    String? query,
  }) async {
    return [
      Article(
        id: '1',
        title: 'Test Article',
        description: 'Test Description',
        content: 'Test Content',
        url: 'https://example.com',
        imageUrl: null,
        publishedAt: DateTime.now(),
        source: 'Test Source',
        author: 'Test Author',
        category: category ?? 'general',
      ),
    ];
  }

  @override
  Future<List<Article>> getArticlesByCategory(String category) async {
    return [
      Article(
        id: '1',
        title: 'Test Article',
        description: 'Test Description',
        content: 'Test Content',
        url: 'https://example.com',
        imageUrl: null,
        publishedAt: DateTime.now(),
        source: 'Test Source',
        author: 'Test Author',
        category: category,
      ),
    ];
  }

  @override
  Future<List<Article>> searchArticles(String query) async {
    if (query == 'error') {
      throw Exception('Search error');
    }
    return [
      Article(
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
      ),
    ];
  }

  @override
  Future<void> saveArticle(Article article) async {}

  @override
  Future<List<Article>> getSavedArticles() async {
    return [];
  }

  @override
  Future<List<Article>> getEverything({
    String? query,
    String? sources,
    String? domains,
    String? from,
    String? to,
    String? language,
    String? sortBy,
  }) async {
    return [];
  }

  @override
  Future<bool> isArticleSaved(Article article) async {
    return false;
  }

  @override
  Future<void> removeArticle(Article article) async {}
}

void main() {
  late MockNewsRepository mockRepository;
  late SearchArticles searchArticles;
  late SaveArticle saveArticle;
  late GetArticlesByCategory getArticlesByCategory;

  setUp(() {
    mockRepository = MockNewsRepository();
    searchArticles = SearchArticles(mockRepository);
    saveArticle = SaveArticle(mockRepository);
    getArticlesByCategory = GetArticlesByCategory(mockRepository);
  });

  group('SearchArticles', () {
    test('should return list of Article', () async {
      // Act
      final result = await searchArticles('test');

      // Assert
      expect(result, isA<List<Article>>());
      expect(result.length, 1);
      expect(result.first.title, 'Test Article');
    });

    test('should throw ValidationFailure on empty query', () async {
      // Act & Assert
      expect(() => searchArticles(''), throwsA(isA<ValidationFailure>()));
    });

    test('should throw ServerFailure on repository error', () async {
      // Act & Assert
      expect(() => searchArticles('error'), throwsA(isA<ServerFailure>()));
    });
  });

  group('SaveArticle', () {
    test('should save article successfully', () async {
      // Arrange
      final article = Article(
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

      // Act & Assert
      expect(() => saveArticle(article), returnsNormally);
    });

    test('should throw CacheFailure on error', () async {
      // Arrange
      final errorRepository = _ErrorNewsRepository();
      final useCase = SaveArticle(errorRepository);
      final article = Article(
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

      // Act & Assert
      expect(() => useCase(article), throwsA(isA<CacheFailure>()));
    });
  });

  group('GetArticlesByCategory', () {
    test('should return list of Article for category', () async {
      // Act
      final result = await getArticlesByCategory('technology');

      // Assert
      expect(result, isA<List<Article>>());
      expect(result.length, 1);
      expect(result.first.category, 'technology');
    });
  });
}

class _ErrorNewsRepository implements NewsRepository {
  @override
  Future<List<Article>> getTopHeadlines({
    String? country,
    String? category,
    String? sources,
    String? query,
  }) async {
    throw Exception('Error');
  }

  @override
  Future<List<Article>> getArticlesByCategory(String category) async {
    throw Exception('Error');
  }

  @override
  Future<List<Article>> searchArticles(String query) async {
    throw Exception('Error');
  }

  @override
  Future<void> saveArticle(Article article) async {
    throw Exception('Error');
  }

  @override
  Future<List<Article>> getSavedArticles() async {
    throw Exception('Error');
  }

  @override
  Future<List<Article>> getEverything({
    String? query,
    String? sources,
    String? domains,
    String? from,
    String? to,
    String? language,
    String? sortBy,
  }) async {
    throw Exception('Error');
  }

  @override
  Future<bool> isArticleSaved(Article article) async {
    throw Exception('Error');
  }

  @override
  Future<void> removeArticle(Article article) async {
    throw Exception('Error');
  }
}
