import 'package:http/http.dart' as http;

import '../network/network_info.dart';
import '../network/dio_client.dart';
import '../database/app_database.dart';
import '../storage/hive_service.dart';

// Погода
import '../../features/weather/data/datasources/weather_remote_data_source.dart';
import '../../features/weather/data/datasources/weather_local_data_source.dart';
import '../../features/weather/data/repositories/weather_repository_impl.dart';
import '../../features/weather/domain/repositories/weather_repository.dart';
import '../../features/weather/domain/usecases/get_current_weather.dart';
import '../../features/weather/domain/usecases/get_weather_forecast.dart';
import '../../features/weather/domain/usecases/search_cities.dart';
import '../../features/weather/domain/usecases/get_current_location.dart';
import '../../features/weather/domain/usecases/save_city.dart';
import '../../features/weather/domain/usecases/get_one_call_weather.dart';
import '../../features/weather/domain/usecases/get_one_call_raw_data.dart';
import '../../features/weather/presentation/bloc/weather_bloc.dart';

// Новини
import '../../features/news/data/datasources/news_remote_data_source.dart';
import '../../features/news/data/datasources/news_local_data_source.dart';
import '../../features/news/data/repositories/news_repository_impl.dart';
import '../../features/news/domain/repositories/news_repository.dart';
import '../../features/news/domain/usecases/get_top_headlines.dart';
import '../../features/news/domain/usecases/get_articles_by_category.dart';
import '../../features/news/domain/usecases/search_articles.dart';
import '../../features/news/domain/usecases/save_article.dart';
import '../../features/news/domain/usecases/get_saved_articles.dart';
import '../../features/news/presentation/bloc/news_bloc.dart';

// Автентифікація
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/datasources/auth_local_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_user.dart';
import '../../features/auth/domain/usecases/register_user.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

// Простий контейнер залежностей
class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  final Map<Type, dynamic> _services = {};

  void register<T>(T service) {
    _services[T] = service;
  }

  T get<T>() {
    final service = _services[T];
    if (service == null) {
      throw Exception(
        'Service of type $T not found. Make sure it is registered.',
      );
    }
    return service as T;
  }
}

final serviceLocator = ServiceLocator();

Future<void> configureDependencies({
  AppDatabase? testDatabase,
  bool skipHiveInit = false,
}) async {
  // Ініціалізуємо Hive спочатку (має бути зроблено перед відкриттям boxes)
  // Пропускаємо в тестовому середовищі, якщо потрібно
  if (!skipHiveInit) {
    await HiveService.init();
  } else {
    // Ініціалізуємо Hive для тестування (без path_provider)
    await HiveService.init(forTesting: true);
  }

  // Ініціалізуємо базу даних (використовуємо тестову БД, якщо надано)
  final database = testDatabase ?? AppDatabase();
  serviceLocator.register<AppDatabase>(database);

  // Реєструємо основні залежності
  serviceLocator.register<NetworkInfo>(NetworkInfoImpl());

  // Реєструємо HTTP клієнти (залишаємо http для зворотної сумісності)
  serviceLocator.register<http.Client>(http.Client());

  // Реєструємо Dio клієнт з interceptors
  serviceLocator.register<DioClient>(DioClient());

  // Реєструємо джерела даних для автентифікації
  serviceLocator.register<AuthRemoteDataSource>(AuthRemoteDataSourceImpl());
  serviceLocator.register<AuthLocalDataSource>(AuthLocalDataSourceImpl());

  // Реєструємо джерела даних для погоди
  serviceLocator.register<WeatherRemoteDataSource>(
    WeatherRemoteDataSourceImpl(dioClient: serviceLocator.get<DioClient>()),
  );
  serviceLocator.register<WeatherLocalDataSource>(
    WeatherLocalDataSourceImpl(database: serviceLocator.get<AppDatabase>()),
  );

  // Реєструємо джерела даних для новин
  serviceLocator.register<NewsRemoteDataSource>(
    NewsRemoteDataSourceImpl(dioClient: serviceLocator.get<DioClient>()),
  );
  serviceLocator.register<NewsLocalDataSource>(
    NewsLocalDataSourceImpl(database: serviceLocator.get<AppDatabase>()),
  );

  // Реєструємо репозиторії
  serviceLocator.register<WeatherRepository>(
    WeatherRepositoryImpl(
      remoteDataSource: serviceLocator.get<WeatherRemoteDataSource>(),
      localDataSource: serviceLocator.get<WeatherLocalDataSource>(),
      networkInfo: serviceLocator.get<NetworkInfo>(),
    ),
  );

  serviceLocator.register<NewsRepository>(
    NewsRepositoryImpl(
      remoteDataSource: serviceLocator.get<NewsRemoteDataSource>(),
      localDataSource: serviceLocator.get<NewsLocalDataSource>(),
      networkInfo: serviceLocator.get<NetworkInfo>(),
    ),
  );

  // Реєструємо use cases
  serviceLocator.register<GetCurrentWeather>(
    GetCurrentWeather(serviceLocator.get<WeatherRepository>()),
  );
  serviceLocator.register<GetWeatherForecast>(
    GetWeatherForecast(serviceLocator.get<WeatherRepository>()),
  );
  serviceLocator.register<SearchCities>(
    SearchCities(serviceLocator.get<WeatherRepository>()),
  );
  serviceLocator.register<GetCurrentLocation>(
    GetCurrentLocation(serviceLocator.get<WeatherRepository>()),
  );
  serviceLocator.register<SaveCity>(
    SaveCity(serviceLocator.get<WeatherRepository>()),
  );

  serviceLocator.register<GetOneCallWeather>(
    GetOneCallWeather(serviceLocator.get<WeatherRepository>()),
  );
  serviceLocator.register<GetOneCallDailyForecast>(
    GetOneCallDailyForecast(serviceLocator.get<WeatherRepository>()),
  );
  serviceLocator.register<GetOneCallHourlyForecast>(
    GetOneCallHourlyForecast(serviceLocator.get<WeatherRepository>()),
  );
  serviceLocator.register<GetOneCallRawData>(
    GetOneCallRawData(serviceLocator.get<WeatherRepository>()),
  );

  serviceLocator.register<GetTopHeadlines>(
    GetTopHeadlines(serviceLocator.get<NewsRepository>()),
  );
  serviceLocator.register<GetArticlesByCategory>(
    GetArticlesByCategory(serviceLocator.get<NewsRepository>()),
  );
  serviceLocator.register<SearchArticles>(
    SearchArticles(serviceLocator.get<NewsRepository>()),
  );
  serviceLocator.register<SaveArticle>(
    SaveArticle(serviceLocator.get<NewsRepository>()),
  );
  serviceLocator.register<GetSavedArticles>(
    GetSavedArticles(serviceLocator.get<NewsRepository>()),
  );

  // Реєструємо репозиторій автентифікації
  serviceLocator.register<AuthRepository>(
    AuthRepositoryImpl(
      remoteDataSource: serviceLocator.get<AuthRemoteDataSource>(),
      localDataSource: serviceLocator.get<AuthLocalDataSource>(),
      networkInfo: serviceLocator.get<NetworkInfo>(),
    ),
  );

  // Реєструємо use cases для автентифікації
  serviceLocator.register<LoginUser>(
    LoginUser(serviceLocator.get<AuthRepository>()),
  );
  serviceLocator.register<RegisterUser>(
    RegisterUser(serviceLocator.get<AuthRepository>()),
  );

  // Реєструємо BLoC'и
  serviceLocator.register<WeatherBloc>(
    WeatherBloc(
      getCurrentWeather: serviceLocator.get<GetCurrentWeather>(),
      getWeatherForecast: serviceLocator.get<GetWeatherForecast>(),
      searchCities: serviceLocator.get<SearchCities>(),
      getCurrentLocation: serviceLocator.get<GetCurrentLocation>(),
      saveCity: serviceLocator.get<SaveCity>(),
      getOneCallWeather: serviceLocator.get<GetOneCallWeather>(),
      getOneCallDailyForecast: serviceLocator.get<GetOneCallDailyForecast>(),
      getOneCallHourlyForecast: serviceLocator.get<GetOneCallHourlyForecast>(),
      getOneCallRawData: serviceLocator.get<GetOneCallRawData>(),
    ),
  );

  serviceLocator.register<NewsBloc>(
    NewsBloc(
      getTopHeadlines: serviceLocator.get<GetTopHeadlines>(),
      getArticlesByCategory: serviceLocator.get<GetArticlesByCategory>(),
      searchArticles: serviceLocator.get<SearchArticles>(),
      saveArticle: serviceLocator.get<SaveArticle>(),
      getSavedArticles: serviceLocator.get<GetSavedArticles>(),
    ),
  );

  serviceLocator.register<AuthBloc>(
    AuthBloc(
      loginUser: serviceLocator.get<LoginUser>(),
      registerUser: serviceLocator.get<RegisterUser>(),
      authRepository: serviceLocator.get<AuthRepository>(),
    ),
  );
}
