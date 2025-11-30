import 'package:flutter/foundation.dart';
import '../../domain/entities/article.dart';
import '../../domain/usecases/get_top_headlines.dart';
import '../../domain/usecases/get_articles_by_category.dart';
import '../../domain/usecases/search_articles.dart';
import '../../domain/usecases/save_article.dart';
import '../../domain/usecases/get_saved_articles.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends ChangeNotifier {
  final GetTopHeadlines getTopHeadlines;
  final GetArticlesByCategory getArticlesByCategory;
  final SearchArticles searchArticles;
  final SaveArticle saveArticle;
  final GetSavedArticles getSavedArticles;

  NewsBloc({
    required this.getTopHeadlines,
    required this.getArticlesByCategory,
    required this.searchArticles,
    required this.saveArticle,
    required this.getSavedArticles,
  });

  NewsState _state = NewsInitial();
  NewsState get state => _state;

  bool _disposed = false;

  void _emit(NewsState newState) {
    if (_disposed) return;
    _state = newState;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  Future<void> getTopHeadlinesData({
    String? country,
    String? category,
    String? sources,
    String? query,
  }) async {
    _emit(NewsLoading());

    try {
      // Використовуємо параметри за замовчуванням, якщо не надано
      final articles = await this.getTopHeadlines(
        country: country ?? 'us', // За замовчуванням новини США
        category: category,
        sources: sources,
        query: query,
      );

      if (kDebugMode) {
        print('📰 NewsBloc: Received ${articles.length} articles');
        for (int i = 0; i < articles.length && i < 3; i++) {
          print('📰 Article ${i + 1}: ${articles[i].title}');
        }
      }

      _emit(NewsLoaded(articles));
    } catch (e) {
      _emit(NewsError(e.toString()));
    }
  }

  Future<void> getArticlesByCategoryData(String category) async {
    _emit(NewsLoading());

    try {
      final articles = await this.getArticlesByCategory(category);
      _emit(NewsLoaded(articles));
    } catch (e) {
      _emit(NewsError(e.toString()));
    }
  }

  Future<void> searchArticlesQuery(String query) async {
    _emit(NewsLoading());

    try {
      final articles = await this.searchArticles(query);
      _emit(NewsLoaded(articles));
    } catch (e) {
      _emit(NewsError(e.toString()));
    }
  }

  Future<void> saveArticleData(Article article) async {
    try {
      await this.saveArticle(article);
      _emit(ArticleSaved());
    } catch (e) {
      _emit(NewsError(e.toString()));
    }
  }

  Future<void> getSavedArticlesData() async {
    _emit(NewsLoading());

    try {
      final articles = await this.getSavedArticles();
      _emit(NewsLoaded(articles));
    } catch (e) {
      _emit(NewsError(e.toString()));
    }
  }
}
