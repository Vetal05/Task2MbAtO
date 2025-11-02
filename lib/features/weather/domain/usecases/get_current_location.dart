import '../../../../core/error/failures.dart';
import '../entities/location.dart';
import '../repositories/weather_repository.dart';

class GetCurrentLocation {
  final WeatherRepository repository;

  GetCurrentLocation(this.repository);

  Future<Location> call() async {
    try {
      final location = await repository.getCurrentLocation();
      if (location == null) {
        throw LocationFailure('Current location not available');
      }
      return location;
    } catch (e) {
      throw LocationFailure(e.toString());
    }
  }
}
