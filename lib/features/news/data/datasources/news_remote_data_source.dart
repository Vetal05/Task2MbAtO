import 'package:dio/dio.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../models/article_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<ArticleModel>> getTopHeadlines({
    String? country,
    String? category,
    String? sources,
    String? query,
  });

  Future<List<ArticleModel>> getEverything({
    String? query,
    String? sources,
    String? domains,
    String? from,
    String? to,
    String? language,
    String? sortBy,
  });
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final DioClient dioClient;

  NewsRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<ArticleModel>> getTopHeadlines({
    String? country,
    String? category,
    String? sources,
    String? query,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'apiKey': AppConstants.newsApiKey,
        'pageSize': '20',
      };

      if (country != null) queryParams['country'] = country;
      if (category != null) queryParams['category'] = category;
      if (sources != null) queryParams['sources'] = sources;
      if (query != null) queryParams['q'] = query;

      final dio = dioClient.getNewsDio();
      final response = await dio.get(
        '${AppConstants.newsBaseUrl}/top-headlines',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final jsonData = response.data as Map<String, dynamic>;
        final List<dynamic> articlesList = jsonData['articles'];
        return articlesList
            .map((json) => ArticleModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          'Failed to get top headlines: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw ServerException(
          'Failed to get top headlines: ${e.response?.statusCode}',
        );
      } else {
        throw NetworkException('Network error: ${e.message}');
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw NetworkException('Network error: $e');
    }
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
    try {
      final queryParams = <String, dynamic>{
        'apiKey': AppConstants.newsApiKey,
        'pageSize': '20',
      };

      if (query != null) queryParams['q'] = query;
      if (sources != null) queryParams['sources'] = sources;
      if (domains != null) queryParams['domains'] = domains;
      if (from != null) queryParams['from'] = from;
      if (to != null) queryParams['to'] = to;
      if (language != null) queryParams['language'] = language;
      if (sortBy != null) queryParams['sortBy'] = sortBy;

      final dio = dioClient.getNewsDio();
      final response = await dio.get(
        '${AppConstants.newsBaseUrl}/everything',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final jsonData = response.data as Map<String, dynamic>;
        final List<dynamic> articlesList = jsonData['articles'];
        return articlesList
            .map((json) => ArticleModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException('Failed to get articles: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw ServerException(
          'Failed to get articles: ${e.response?.statusCode}',
        );
      } else {
        throw NetworkException('Network error: ${e.message}');
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw NetworkException('Network error: $e');
    }
  }
}
