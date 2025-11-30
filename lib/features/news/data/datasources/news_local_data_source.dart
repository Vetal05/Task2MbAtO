import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../models/article_model.dart';

abstract class NewsLocalDataSource {
  Future<List<ArticleModel>> getSavedArticles();
  Future<void> saveArticle(ArticleModel article);
  Future<void> removeArticle(ArticleModel article);
  Future<bool> isArticleSaved(ArticleModel article);
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  final AppDatabase _database;

  NewsLocalDataSourceImpl({required AppDatabase database})
    : _database = database;

  @override
  Future<List<ArticleModel>> getSavedArticles() async {
    try {
      final articles =
          await (_database.select(_database.newsCache)
                ..where((t) => t.isSaved.equals(true))
                ..orderBy([(t) => OrderingTerm.desc(t.savedAtMs)]))
              .get();

      return articles.map((a) {
        try {
          final jsonMap = json.decode(a.articleJson) as Map<String, dynamic>;
          return ArticleModel.fromJson(jsonMap);
        } catch (e) {
          // Резервний варіант: конструюємо з полів бази даних
          return ArticleModel(
            id: a.id,
            title: a.title,
            description: a.description,
            content: a.content,
            url: a.url,
            imageUrl: a.imageUrl,
            publishedAt: DateTime.fromMillisecondsSinceEpoch(a.publishedAtMs),
            source: a.source,
            author: a.author,
            category: a.category,
          );
        }
      }).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> saveArticle(ArticleModel article) async {
    try {
      // Перевіряємо, чи стаття вже існує
      final existing =
          await (_database.select(_database.newsCache)
            ..where((t) => t.id.equals(article.id))).getSingleOrNull();

      final articleJson = json.encode(article.toJson());

      if (existing != null) {
        // Оновлюємо існуючу
        await (_database.update(_database.newsCache)
          ..where((t) => t.id.equals(article.id))).write(
          NewsCacheCompanion(
            isSaved: const Value(true),
            savedAtMs: Value(DateTime.now().millisecondsSinceEpoch),
            articleJson: Value(articleJson),
          ),
        );
      } else {
        // Вставляємо нову
        await _database
            .into(_database.newsCache)
            .insert(
              NewsCacheCompanion(
                id: Value(article.id),
                title: Value(article.title),
                description: Value(article.description),
                content: Value(article.content),
                url: Value(article.url),
                imageUrl: Value(article.imageUrl),
                publishedAtMs: Value(
                  article.publishedAt.millisecondsSinceEpoch,
                ),
                source: Value(article.source),
                author: Value(article.author),
                category: Value(article.category),
                articleJson: Value(articleJson),
                isSaved: const Value(true),
                savedAtMs: Value(DateTime.now().millisecondsSinceEpoch),
              ),
            );
      }
    } catch (e) {
      debugPrint('Error saving article: $e');
    }
  }

  @override
  Future<void> removeArticle(ArticleModel article) async {
    try {
      // Перевіряємо, чи стаття існує
      final existing =
          await (_database.select(_database.newsCache)
            ..where((t) => t.id.equals(article.id))).getSingleOrNull();

      if (existing != null) {
        // Якщо стаття була тільки збережена (не закешована), видаляємо її
        // Інакше просто позначаємо як не збережену
        await (_database.update(_database.newsCache)..where(
          (t) => t.id.equals(article.id),
        )).write(const NewsCacheCompanion(isSaved: Value(false)));
      }
    } catch (e) {
      debugPrint('Error removing article: $e');
    }
  }

  @override
  Future<bool> isArticleSaved(ArticleModel article) async {
    try {
      final existing =
          await (_database.select(_database.newsCache)..where(
            (t) => t.id.equals(article.id) & t.isSaved.equals(true),
          )).getSingleOrNull();

      return existing != null;
    } catch (e) {
      return false;
    }
  }
}
