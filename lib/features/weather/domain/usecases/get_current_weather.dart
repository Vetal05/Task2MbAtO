import '../../../../core/error/failures.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetCurrentWeather {
  final WeatherRepository repository;

  GetCurrentWeather(this.repository);

  Future<Weather> call({
    double? latitude,
    double? longitude,
    String? cityName,
  }) async {
    try {
      return await repository.getCurrentWeather(
        latitude: latitude,
        longitude: longitude,
        cityName: cityName,
      );
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
