class UkraineCity {
  final String name;
  final String region;
  final double latitude;
  final double longitude;
  final int population;

  const UkraineCity({
    required this.name,
    required this.region,
    required this.latitude,
    required this.longitude,
    required this.population,
  });

  @override
  String toString() => '$name, $region';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UkraineCity &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          region == other.region;

  @override
  int get hashCode => name.hashCode ^ region.hashCode;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'region': region,
      'latitude': latitude,
      'longitude': longitude,
      'population': population,
    };
  }

  factory UkraineCity.fromJson(Map<String, dynamic> json) {
    return UkraineCity(
      name: json['name'] as String,
      region: json['region'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      population: json['population'] as int,
    );
  }
}
