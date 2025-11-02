import '../../../../core/error/failures.dart';
import '../entities/location.dart';
import '../repositories/weather_repository.dart';

class SearchCities {
  final WeatherRepository repository;

  SearchCities(this.repository);

  Future<List<Location>> call(String query) async {
    if (query.isEmpty) {
      throw ValidationFailure('Search query cannot be empty');
    }

    try {
      return await repository.searchCities(query);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
