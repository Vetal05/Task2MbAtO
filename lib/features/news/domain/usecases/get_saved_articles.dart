import '../../../../core/error/failures.dart';
import '../entities/article.dart';
import '../repositories/news_repository.dart';

class GetSavedArticles {
  final NewsRepository repository;

  GetSavedArticles(this.repository);

  Future<List<Article>> call() async {
    try {
      return await repository.getSavedArticles();
    } catch (e) {
      throw CacheFailure(e.toString());
    }
  }
}
