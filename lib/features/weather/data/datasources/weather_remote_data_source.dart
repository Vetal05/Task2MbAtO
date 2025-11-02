import 'package:dio/dio.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../models/weather_model.dart';
import '../models/location_model.dart';
import '../models/one_call_weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather({
    double? latitude,
    double? longitude,
    String? cityName,
  });

  Future<List<WeatherModel>> getWeatherForecast({
    double? latitude,
    double? longitude,
    String? cityName,
  });

  Future<List<LocationModel>> searchCities(String query);

  // New One Call API methods
  Future<OneCallWeatherModel> getOneCallWeather({
    required double latitude,
    required double longitude,
    String? exclude,
    String? units,
    String? lang,
  });
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final DioClient dioClient;

  WeatherRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<WeatherModel> getCurrentWeather({
    double? latitude,
    double? longitude,
    String? cityName,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'appid': AppConstants.openWeatherApiKey,
        'units': 'metric',
      };

      if (cityName != null) {
        queryParams['q'] = cityName;
      } else if (latitude != null && longitude != null) {
        queryParams['lat'] = latitude;
        queryParams['lon'] = longitude;
      } else {
        throw const ValidationException(
          'Either city name or coordinates must be provided',
        );
      }

      final dio = dioClient.getOpenWeatherDio();
      final response = await dio.get(
        '${AppConstants.openWeatherBaseUrl}/weather',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException(
          'Failed to get weather data: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw ServerException(
          'Failed to get weather data: ${e.response?.statusCode}',
        );
      } else {
        throw NetworkException('Network error: ${e.message}');
      }
    } catch (e) {
      if (e is ServerException || e is ValidationException) {
        rethrow;
      }
      throw NetworkException('Network error: $e');
    }
  }

  @override
  Future<List<WeatherModel>> getWeatherForecast({
    double? latitude,
    double? longitude,
    String? cityName,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'appid': AppConstants.openWeatherApiKey,
        'units': 'metric',
      };

      if (cityName != null) {
        queryParams['q'] = cityName;
      } else if (latitude != null && longitude != null) {
        queryParams['lat'] = latitude;
        queryParams['lon'] = longitude;
      } else {
        throw const ValidationException(
          'Either city name or coordinates must be provided',
        );
      }

      final dio = dioClient.getOpenWeatherDio();
      final response = await dio.get(
        '${AppConstants.openWeatherBaseUrl}/forecast',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final jsonData = response.data as Map<String, dynamic>;
        final List<dynamic> forecastList = jsonData['list'];
        return forecastList
            .map((json) => WeatherModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          'Failed to get forecast data: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw ServerException(
          'Failed to get forecast data: ${e.response?.statusCode}',
        );
      } else {
        throw NetworkException('Network error: ${e.message}');
      }
    } catch (e) {
      if (e is ServerException || e is ValidationException) {
        rethrow;
      }
      throw NetworkException('Network error: $e');
    }
  }

  @override
  Future<List<LocationModel>> searchCities(String query) async {
    try {
      final dio = dioClient.getOpenWeatherDio();
      final response = await dio.get(
        '${AppConstants.openWeatherBaseUrl}/find',
        queryParameters: {
          'q': query,
          'appid': AppConstants.openWeatherApiKey,
          'type': 'like',
          'sort': 'population',
          'cnt': 10,
        },
      );

      if (response.statusCode == 200) {
        final jsonData = response.data as Map<String, dynamic>;
        final List<dynamic> citiesList = jsonData['list'];
        return citiesList
            .map((json) => LocationModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          'Failed to search cities: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw ServerException(
          'Failed to search cities: ${e.response?.statusCode}',
        );
      } else {
        throw NetworkException('Network error: ${e.message}');
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw NetworkException('Network error: $e');
    }
  }

  @override
  Future<OneCallWeatherModel> getOneCallWeather({
    required double latitude,
    required double longitude,
    String? exclude,
    String? units,
    String? lang,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'lat': latitude,
        'lon': longitude,
        'appid': AppConstants.openWeatherApiKey,
      };

      if (exclude != null) queryParams['exclude'] = exclude;
      if (units != null) queryParams['units'] = units;
      if (lang != null) queryParams['lang'] = lang;

      final dio = dioClient.getOpenWeatherDio();
      final response = await dio.get(
        AppConstants.openWeatherOneCallBaseUrl,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return OneCallWeatherModel.fromJson(
          response.data as Map<String, dynamic>,
        );
      } else {
        throw ServerException(
          'Failed to get one call weather data: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw ServerException(
          'Failed to get one call weather data: ${e.response?.statusCode}',
        );
      } else {
        throw NetworkException('Network error: ${e.message}');
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw NetworkException('Network error: $e');
    }
  }
}
