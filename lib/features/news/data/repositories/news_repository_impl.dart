import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_local_data_source.dart';
import '../datasources/news_remote_data_source.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NewsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<Article>> getTopHeadlines({
    String? country,
    String? category,
    String? sources,
    String? query,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final articleModels = await remoteDataSource.getTopHeadlines(
          country: country,
          category: category,
          sources: sources,
          query: query,
        );
        return articleModels;
      } catch (e) {
        throw ServerFailure(e.toString());
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
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
    if (await networkInfo.isConnected) {
      try {
        final articleModels = await remoteDataSource.getEverything(
          query: query,
          sources: sources,
          domains: domains,
          from: from,
          to: to,
          language: language,
          sortBy: sortBy,
        );
        return articleModels;
      } catch (e) {
        throw ServerFailure(e.toString());
      }
    } else {
      throw const NetworkFailure('No internet connection');
    }
  }

  @override
  Future<List<Article>> getArticlesByCategory(String category) async {
    return getTopHeadlines(category: category);
  }

  @override
  Future<List<Article>> searchArticles(String query) async {
    return getEverything(query: query);
  }

  @override
  Future<List<Article>> getSavedArticles() async {
    try {
      return await localDataSource.getSavedArticles();
    } catch (e) {
      throw CacheFailure(e.toString());
    }
  }

  @override
  Future<void> saveArticle(Article article) async {
    try {
      await localDataSource.saveArticle(article as dynamic);
    } catch (e) {
      throw CacheFailure(e.toString());
    }
  }

  @override
  Future<void> removeArticle(Article article) async {
    try {
      await localDataSource.removeArticle(article as dynamic);
    } catch (e) {
      throw CacheFailure(e.toString());
    }
  }

  @override
  Future<bool> isArticleSaved(Article article) async {
    try {
      return await localDataSource.isArticleSaved(article as dynamic);
    } catch (e) {
      throw CacheFailure(e.toString());
    }
  }
}
