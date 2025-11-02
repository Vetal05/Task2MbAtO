class Article {
  const Article({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
    required this.source,
    required this.author,
    required this.category,
  });

  final String id;
  final String title;
  final String description;
  final String content;
  final String url;
  final String? imageUrl;
  final DateTime publishedAt;
  final String source;
  final String? author;
  final String category;
}
