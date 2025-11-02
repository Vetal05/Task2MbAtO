import 'dart:convert';
import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../models/weather_model.dart';
import '../models/location_model.dart';

abstract class WeatherLocalDataSource {
  Future<WeatherModel?> getCachedWeather();
  Future<void> cacheWeather(WeatherModel weather);

  Future<List<LocationModel>> getSavedCities();
  Future<void> saveCity(LocationModel city);
  Future<void> removeCity(LocationModel city);

  Future<LocationModel?> getCurrentLocation();
  Future<void> setCurrentLocation(LocationModel location);
}

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final AppDatabase _database;

  WeatherLocalDataSourceImpl({required AppDatabase database})
    : _database = database;

  @override
  Future<WeatherModel?> getCachedWeather() async {
    try {
      final cached =
          await (_database.select(_database.weatherCache)
                ..orderBy([(t) => OrderingTerm.desc(t.timestampMs)])
                ..limit(1))
              .getSingleOrNull();

      if (cached == null) return null;

      // Parse from JSON for easy conversion
      try {
        final jsonMap = json.decode(cached.weatherJson) as Map<String, dynamic>;
        return WeatherModel.fromJson(jsonMap);
      } catch (e) {
        // Fallback: construct from database fields
        return WeatherModel(
          id: cached.weatherId,
          main: cached.main,
          description: cached.description,
          icon: cached.icon,
          temperature: cached.temperature,
          feelsLike: cached.feelsLike,
          humidity: cached.humidity,
          pressure: cached.pressure,
          windSpeed: cached.windSpeed,
          windDirection: cached.windDirection,
          visibility: cached.visibility,
          cloudiness: cached.cloudiness,
          sunrise: DateTime.fromMillisecondsSinceEpoch(cached.sunriseMs),
          sunset: DateTime.fromMillisecondsSinceEpoch(cached.sunsetMs),
          cityName: cached.cityName,
          country: cached.country,
          latitude: cached.latitude,
          longitude: cached.longitude,
          timestamp: DateTime.fromMillisecondsSinceEpoch(cached.timestampMs),
        );
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheWeather(WeatherModel weather) async {
    try {
      // Delete old cache (keep only latest)
      await _database.delete(_database.weatherCache).go();

      // Insert new cache
      final weatherJson = json.encode(weather.toJson());
      await _database
          .into(_database.weatherCache)
          .insert(
            WeatherCacheCompanion(
              cityName: Value(weather.cityName),
              country: Value(weather.country),
              latitude: Value(weather.latitude),
              longitude: Value(weather.longitude),
              weatherId: Value(weather.id),
              main: Value(weather.main),
              description: Value(weather.description),
              icon: Value(weather.icon),
              temperature: Value(weather.temperature),
              feelsLike: Value(weather.feelsLike),
              humidity: Value(weather.humidity),
              pressure: Value(weather.pressure),
              windSpeed: Value(weather.windSpeed),
              windDirection: Value(weather.windDirection),
              visibility: Value(weather.visibility),
              cloudiness: Value(weather.cloudiness),
              sunriseMs: Value(weather.sunrise.millisecondsSinceEpoch),
              sunsetMs: Value(weather.sunset.millisecondsSinceEpoch),
              timestampMs: Value(weather.timestamp.millisecondsSinceEpoch),
              weatherJson: Value(weatherJson),
            ),
          );
    } catch (e) {
      // Handle error silently or log
      print('Error caching weather: $e');
    }
  }

  @override
  Future<List<LocationModel>> getSavedCities() async {
    try {
      final cities =
          await (_database.select(_database.citiesCache)
            ..where((t) => t.isCurrentLocation.equals(false))).get();

      return cities
          .map(
            (c) => LocationModel(
              name: c.name,
              country: c.country,
              latitude: c.latitude,
              longitude: c.longitude,
              state: c.state,
              isCurrentLocation: false,
            ),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> saveCity(LocationModel city) async {
    try {
      // Check if city already exists
      final existing =
          await (_database.select(_database.citiesCache)..where(
            (t) => t.name.equals(city.name) & t.country.equals(city.country),
          )).getSingleOrNull();

      if (existing == null) {
        await _database
            .into(_database.citiesCache)
            .insert(
              CitiesCacheCompanion(
                name: Value(city.name),
                country: Value(city.country),
                latitude: Value(city.latitude),
                longitude: Value(city.longitude),
                state: Value(city.state),
                isCurrentLocation: const Value(false),
              ),
            );
      }
    } catch (e) {
      print('Error saving city: $e');
    }
  }

  @override
  Future<void> removeCity(LocationModel city) async {
    try {
      await (_database.delete(_database.citiesCache)..where(
        (t) => t.name.equals(city.name) & t.country.equals(city.country),
      )).go();
    } catch (e) {
      print('Error removing city: $e');
    }
  }

  @override
  Future<LocationModel?> getCurrentLocation() async {
    try {
      final location =
          await (_database.select(_database.citiesCache)
                ..where((t) => t.isCurrentLocation.equals(true))
                ..limit(1))
              .getSingleOrNull();

      if (location == null) return null;

      return LocationModel(
        name: location.name,
        country: location.country,
        latitude: location.latitude,
        longitude: location.longitude,
        state: location.state,
        isCurrentLocation: true,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> setCurrentLocation(LocationModel location) async {
    try {
      // Remove old current location
      await (_database.update(_database.citiesCache)..where(
        (t) => t.isCurrentLocation.equals(true),
      )).write(const CitiesCacheCompanion(isCurrentLocation: Value(false)));

      // Check if location already exists
      final existing =
          await (_database.select(_database.citiesCache)..where(
            (t) =>
                t.name.equals(location.name) &
                t.country.equals(location.country),
          )).getSingleOrNull();

      if (existing != null) {
        // Update existing
        await (_database.update(_database.citiesCache)..where(
          (t) => t.id.equals(existing.id),
        )).write(CitiesCacheCompanion(isCurrentLocation: const Value(true)));
      } else {
        // Insert new
        await _database
            .into(_database.citiesCache)
            .insert(
              CitiesCacheCompanion(
                name: Value(location.name),
                country: Value(location.country),
                latitude: Value(location.latitude),
                longitude: Value(location.longitude),
                state: Value(location.state),
                isCurrentLocation: const Value(true),
              ),
            );
      }
    } catch (e) {
      print('Error setting current location: $e');
    }
  }
}
