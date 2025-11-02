import '../../../../core/error/failures.dart';
import '../entities/article.dart';
import '../repositories/news_repository.dart';

class SearchArticles {
  final NewsRepository repository;

  SearchArticles(this.repository);

  Future<List<Article>> call(String query) async {
    if (query.isEmpty) {
      throw ValidationFailure('Search query cannot be empty');
    }

    try {
      return await repository.searchArticles(query);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
