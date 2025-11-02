class Location {
  const Location({
    required this.name,
    required this.country,
    required this.latitude,
    required this.longitude,
    this.state,
    this.isCurrentLocation = false,
  });

  final String name;
  final String country;
  final double latitude;
  final double longitude;
  final String? state;
  final bool isCurrentLocation;
}
