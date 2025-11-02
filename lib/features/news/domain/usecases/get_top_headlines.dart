import '../../../../core/error/failures.dart';
import '../entities/article.dart';
import '../repositories/news_repository.dart';

class GetTopHeadlines {
  final NewsRepository repository;

  GetTopHeadlines(this.repository);

  Future<List<Article>> call({
    String? country,
    String? category,
    String? sources,
    String? query,
  }) async {
    try {
      return await repository.getTopHeadlines(
        country: country,
        category: category,
        sources: sources,
        query: query,
      );
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
