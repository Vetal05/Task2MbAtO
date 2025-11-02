import '../repositories/weather_repository.dart';
import '../../data/models/one_call_weather_model.dart';

class GetOneCallRawData {
  final WeatherRepository repository;

  GetOneCallRawData(this.repository);

  Future<OneCallWeatherModel> call({
    required double latitude,
    required double longitude,
  }) async {
    return await repository.getOneCallRawData(
      latitude: latitude,
      longitude: longitude,
    );
  }
}

