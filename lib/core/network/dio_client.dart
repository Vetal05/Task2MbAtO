import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Dio клієнт з interceptors для логування та повторних спроб
class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: '', // Буде встановлено для кожного запиту
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Додаємо interceptors
    _dio.interceptors.add(_LoggingInterceptor());
    _dio.interceptors.add(_RetryInterceptor(_dio));
  }

  Dio get dio => _dio;

  /// Отримує екземпляр Dio, налаштований для OpenWeatherMap API
  Dio getOpenWeatherDio() {
    return _dio;
  }

  /// Отримує екземпляр Dio, налаштований для NewsAPI
  Dio getNewsDio() {
    return _dio;
  }
}

/// Interceptor для логування - логує всі запити та відповіді
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
        // Логуємо скорочену відповідь (перші 500 символів)
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

/// Interceptor для повторних спроб - повторює невдалі запити
class _RetryInterceptor extends Interceptor {
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);

  final Dio _dioInstance;

  _RetryInterceptor(this._dioInstance);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      final options = err.requestOptions;

      // Перевіряємо кількість повторних спроб
      final retryCount = (options.extra['retryCount'] as int?) ?? 0;

      if (retryCount < maxRetries) {
        options.extra['retryCount'] = retryCount + 1;

        if (kDebugMode) {
          print(
            '🔄 Retrying request (${retryCount + 1}/$maxRetries): ${options.uri}',
          );
        }

        // Чекаємо перед повторною спробою
        await Future.delayed(retryDelay);

        try {
          // Повторюємо запит, використовуючи той самий екземпляр Dio
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
          // Якщо повторна спроба не вдалася, продовжуємо з помилкою
          if (kDebugMode) {
            print('❌ Retry failed: $e');
          }
        }
      }
    }

    super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    // Повторюємо при помилках мережі або помилках сервера (5xx)
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError ||
        (err.response?.statusCode != null && err.response!.statusCode! >= 500);
  }
}
