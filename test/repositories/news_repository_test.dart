import 'package:flutter_test/flutter_test.dart';
import 'package:weather_news_app/core/error/failures.dart';
import 'package:weather_news_app/core/network/network_info.dart';
import 'package:weather_news_app/features/news/data/repositories/news_repository_impl.dart';
import 'package:weather_news_app/features/news/data/datasources/news_remote_data_source.dart';
import 'package:weather_news_app/features/news/data/datasources/news_local_data_source.dart';
import 'package:weather_news_app/features/news/data/models/article_model.dart';
import 'package:weather_news_app/features/news/domain/entities/article.dart';

class MockNewsRemoteDataSource implements NewsRemoteDataSource {
  bool shouldThrowError = false;

  @override
  Future<List<ArticleModel>> getTopHeadlines({
    String? country,
    String? category,
    String? sources,
    String? query,
  }) async {
    if (shouldThrowError) {
      throw Exception('Network error');
    }
    return [
      ArticleModel(
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
  Future<List<ArticleModel>> getEverything({
    String? query,
    String? sources,
    String? domains,
    String? from,
    String? to,
    String? language,
    String? sortBy,
  }) async {
    if (shouldThrowError) {
      throw Exception('Network error');
    }
    return [
      ArticleModel(
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
}

class MockNewsLocalDataSource implements NewsLocalDataSource {
  final List<ArticleModel> _savedArticles = [];

  @override
  Future<List<ArticleModel>> getSavedArticles() async {
    return List.from(_savedArticles);
  }

  @override
  Future<void> saveArticle(ArticleModel article) async {
    if (!_savedArticles.any((a) => a.id == article.id)) {
      _savedArticles.add(article);
    }
  }

  @override
  Future<void> removeArticle(ArticleModel article) async {
    _savedArticles.removeWhere((a) => a.id == article.id);
  }

  @override
  Future<bool> isArticleSaved(ArticleModel article) async {
    return _savedArticles.any((a) => a.id == article.id);
  }
}

class MockNetworkInfo implements NetworkInfo {
  final bool isConnectedValue;

  MockNetworkInfo(this.isConnectedValue);

  @override
  Future<bool> get isConnected async => isConnectedValue;
}

void main() {
  late NewsRepositoryImpl repository;
  late MockNewsRemoteDataSource mockRemoteDataSource;
  late MockNewsLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockNewsRemoteDataSource();
    mockLocalDataSource = MockNewsLocalDataSource();
    mockNetworkInfo = MockNetworkInfo(true);
    repository = NewsRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getTopHeadlines', () {
    test('should return articles from remote when online', () async {
      // Act
      final result = await repository.getTopHeadlines(
        country: 'us',
        category: 'technology',
      );

      // Assert
      expect(result, isA<List<Article>>());
      expect(result.length, 1);
      expect(result.first.title, 'Test Article');
    });

    test('should throw ServerFailure when remote fails', () async {
      // Arrange
      mockRemoteDataSource.shouldThrowError = true;

      // Act & Assert
      expect(
        () => repository.getTopHeadlines(category: 'technology'),
        throwsA(isA<ServerFailure>()),
      );
    });

    test('should throw NetworkFailure when offline', () async {
      // Arrange
      mockNetworkInfo = MockNetworkInfo(false);
      repository = NewsRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo,
      );

      // Act & Assert
      expect(
        () => repository.getTopHeadlines(category: 'technology'),
        throwsA(isA<NetworkFailure>()),
      );
    });
  });

  group('getArticlesByCategory', () {
    test('should return articles for category', () async {
      // Act
      final result = await repository.getArticlesByCategory('technology');

      // Assert
      expect(result, isA<List<Article>>());
      expect(result.length, 1);
      expect(result.first.category, 'technology');
    });
  });

  group('searchArticles', () {
    test('should return articles from search', () async {
      // Act
      final result = await repository.searchArticles('test');

      // Assert
      expect(result, isA<List<Article>>());
      expect(result.length, 1);
    });
  });

  group('getSavedArticles', () {
    test('should return saved articles', () async {
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
      await mockLocalDataSource.saveArticle(article);

      // Act
      final result = await repository.getSavedArticles();

      // Assert
      expect(result, isA<List<Article>>());
      expect(result.length, 1);
    });

    test('should throw CacheFailure on error', () async {
      // Arrange
      final errorLocalDataSource = _ErrorNewsLocalDataSource();
      repository = NewsRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: errorLocalDataSource,
        networkInfo: mockNetworkInfo,
      );

      // Act & Assert
      expect(() => repository.getSavedArticles(), throwsA(isA<CacheFailure>()));
    });
  });

  group('saveArticle', () {
    test('should save article successfully', () async {
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

      // Act & Assert
      await expectLater(repository.saveArticle(article), completes);
    });
  });
}

class _ErrorNewsLocalDataSource implements NewsLocalDataSource {
  @override
  Future<List<ArticleModel>> getSavedArticles() async {
    throw Exception('Error');
  }

  @override
  Future<void> saveArticle(ArticleModel article) async {
    throw Exception('Error');
  }

  @override
  Future<void> removeArticle(ArticleModel article) async {
    throw Exception('Error');
  }

  @override
  Future<bool> isArticleSaved(ArticleModel article) async {
    throw Exception('Error');
  }
}
