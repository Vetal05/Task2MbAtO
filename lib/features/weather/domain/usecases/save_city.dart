import '../../../../core/error/failures.dart';
import '../entities/location.dart';
import '../repositories/weather_repository.dart';

class SaveCity {
  final WeatherRepository repository;

  SaveCity(this.repository);

  Future<void> call(Location city) async {
    try {
      await repository.saveCity(city);
    } catch (e) {
      throw CacheFailure(e.toString());
    }
  }
}
