part of 'news_bloc.dart';

abstract class NewsEvent {}

class GetTopHeadlinesEvent extends NewsEvent {
  final String? country;
  final String? category;
  final String? sources;
  final String? query;

  GetTopHeadlinesEvent({this.country, this.category, this.sources, this.query});
}

class GetArticlesByCategoryEvent extends NewsEvent {
  final String category;

  GetArticlesByCategoryEvent(this.category);
}

class SearchArticlesEvent extends NewsEvent {
  final String query;

  SearchArticlesEvent(this.query);
}

class SaveArticleEvent extends NewsEvent {
  final Article article;

  SaveArticleEvent(this.article);
}
