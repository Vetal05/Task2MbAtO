import '../../../../core/error/failures.dart';
import '../entities/article.dart';
import '../repositories/news_repository.dart';

class SaveArticle {
  final NewsRepository repository;

  SaveArticle(this.repository);

  Future<void> call(Article article) async {
    try {
      await repository.saveArticle(article);
    } catch (e) {
      throw CacheFailure(e.toString());
    }
  }
}
