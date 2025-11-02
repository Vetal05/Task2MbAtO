import '../../domain/entities/article.dart';

class ArticleModel extends Article {
  const ArticleModel({
    required super.id,
    required super.title,
    required super.description,
    required super.content,
    required super.url,
    super.imageUrl,
    required super.publishedAt,
    required super.source,
    super.author,
    required super.category,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    // Handle source object structure from NewsAPI
    String sourceName = '';
    if (json['source'] != null) {
      if (json['source'] is Map<String, dynamic>) {
        sourceName = json['source']['name'] ?? '';
      } else if (json['source'] is String) {
        sourceName = json['source'];
      }
    }

    // Handle publishedAt date parsing
    DateTime publishedAt;
    try {
      publishedAt = DateTime.parse(json['publishedAt'] ?? '');
    } catch (e) {
      publishedAt = DateTime.now();
    }

    return ArticleModel(
      id: json['url'] ?? '', // Use URL as ID if no ID provided
      title: json['title'] ?? 'No title',
      description: json['description'] ?? 'No description',
      content: json['content'] ?? '',
      url: json['url'] ?? '',
      imageUrl: json['urlToImage'],
      publishedAt: publishedAt,
      source: sourceName,
      author: json['author'],
      category: json['category'] ?? 'general',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'content': content,
      'url': url,
      'imageUrl': imageUrl,
      'publishedAt': publishedAt.toIso8601String(),
      'source': source,
      'author': author,
      'category': category,
    };
  }
}
