class UkraineArea {
  final int id;
  final String title;
  final double? square;
  final int? population;
  final int? localCommunityCount;
  final double? percentCommunitiesFromArea;
  final double? sumCommunitiesSquare;

  const UkraineArea({
    required this.id,
    required this.title,
    this.square,
    this.population,
    this.localCommunityCount,
    this.percentCommunitiesFromArea,
    this.sumCommunitiesSquare,
  });

  @override
  String toString() => title;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UkraineArea &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
