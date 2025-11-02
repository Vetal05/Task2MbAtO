import '../entities/article.dart';

abstract class NewsRepository {
  Future<List<Article>> getTopHeadlines({
    String? country,
    String? category,
    String? sources,
    String? query,
  });

  Future<List<Article>> getEverything({
    String? query,
    String? sources,
    String? domains,
    String? from,
    String? to,
    String? language,
    String? sortBy,
  });

  Future<List<Article>> getArticlesByCategory(String category);

  Future<List<Article>> searchArticles(String query);

  Future<List<Article>> getSavedArticles();

  Future<void> saveArticle(Article article);

  Future<void> removeArticle(Article article);

  Future<bool> isArticleSaved(Article article);
}
