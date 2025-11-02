import '../../../../core/error/failures.dart';
import '../entities/forecast.dart';
import '../repositories/weather_repository.dart';

class GetWeatherForecast {
  final WeatherRepository repository;

  GetWeatherForecast(this.repository);

  Future<List<Forecast>> call({
    double? latitude,
    double? longitude,
    String? cityName,
  }) async {
    try {
      return await repository.getWeatherForecast(
        latitude: latitude,
        longitude: longitude,
        cityName: cityName,
      );
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
