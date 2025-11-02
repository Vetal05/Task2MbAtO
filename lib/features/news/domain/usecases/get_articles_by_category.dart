import '../../../../core/error/failures.dart';
import '../entities/article.dart';
import '../repositories/news_repository.dart';

class GetArticlesByCategory {
  final NewsRepository repository;

  GetArticlesByCategory(this.repository);

  Future<List<Article>> call(String category) async {
    if (category.isEmpty) {
      throw ValidationFailure('Category cannot be empty');
    }

    try {
      return await repository.getArticlesByCategory(category);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
