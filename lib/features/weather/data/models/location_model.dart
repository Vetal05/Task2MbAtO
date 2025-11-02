import '../../domain/entities/location.dart';

class LocationModel extends Location {
  const LocationModel({
    required super.name,
    required super.country,
    required super.latitude,
    required super.longitude,
    super.state,
    super.isCurrentLocation,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'],
      country: json['country'],
      latitude: (json['lat'] as num).toDouble(),
      longitude: (json['lon'] as num).toDouble(),
      state: json['state'],
      isCurrentLocation: json['isCurrentLocation'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'state': state,
      'isCurrentLocation': isCurrentLocation,
    };
  }
}
