import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Dio client with interceptors for logging and retry
class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: '', // Will be set per request
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors
    _dio.interceptors.add(_LoggingInterceptor());
    _dio.interceptors.add(_RetryInterceptor(_dio));
  }

  Dio get dio => _dio;

  /// Get Dio instance configured for OpenWeatherMap API
  Dio getOpenWeatherDio() {
    return _dio;
  }

  /// Get Dio instance configured for NewsAPI
  Dio getNewsDio() {
    return _dio;
  }
}

/// Logging interceptor - logs all requests and responses
class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print('🌐 Dio Request: ${options.method} ${options.uri}');
      if (options.data != null) {
        print('🌐 Request Body: ${options.data}');
      }
      if (options.queryParameters.isNotEmpty) {
        print('🌐 Query Params: ${options.queryParameters}');
      }
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print(
        '✅ Dio Response: ${response.statusCode} ${response.requestOptions.uri}',
      );
      if (response.data != null && response.data is Map) {
        // Log truncated response (first 500 chars)
        final dataStr = response.data.toString();
        if (dataStr.length > 500) {
          print('✅ Response Body: ${dataStr.substring(0, 500)}...');
        } else {
          print('✅ Response Body: $dataStr');
        }
      }
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print('❌ Dio Error: ${err.type} - ${err.message}');
      print('❌ Error URL: ${err.requestOptions.uri}');
      if (err.response != null) {
        print('❌ Error Status: ${err.response?.statusCode}');
        print('❌ Error Body: ${err.response?.data}');
      }
    }
    super.onError(err, handler);
  }
}

/// Retry interceptor - retries failed requests
class _RetryInterceptor extends Interceptor {
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);

  final Dio _dioInstance;

  _RetryInterceptor(this._dioInstance);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      final options = err.requestOptions;

      // Check retry count
      final retryCount = (options.extra['retryCount'] as int?) ?? 0;

      if (retryCount < maxRetries) {
        options.extra['retryCount'] = retryCount + 1;

        if (kDebugMode) {
          print(
            '🔄 Retrying request (${retryCount + 1}/$maxRetries): ${options.uri}',
          );
        }

        // Wait before retry
        await Future.delayed(retryDelay);

        try {
          // Retry the request using the same Dio instance
          final response = await _dioInstance.request(
            options.path,
            data: options.data,
            queryParameters: options.queryParameters,
            options: Options(
              method: options.method,
              headers: options.headers,
              extra: options.extra,
            ),
            cancelToken: options.cancelToken,
          );
          handler.resolve(response);
          return;
        } catch (e) {
          // If retry fails, continue with error
          if (kDebugMode) {
            print('❌ Retry failed: $e');
          }
        }
      }
    }

    super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    // Retry on network errors or server errors (5xx)
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError ||
        (err.response?.statusCode != null && err.response!.statusCode! >= 500);
  }
}
