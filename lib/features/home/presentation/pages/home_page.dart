import 'package:flutter/material.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/services/settings_service.dart';
import '../../../weather/presentation/bloc/weather_bloc.dart';
import '../../../news/presentation/bloc/news_bloc.dart';
import '../../../weather/presentation/widgets/advanced_weather_card.dart';
import '../../../weather/presentation/widgets/city_search_widget.dart';
import '../../../news/presentation/widgets/news_list.dart';
import '../../../settings/presentation/widgets/settings_page.dart';
import '../../../weather/domain/entities/ukraine_city.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  WeatherBloc? _weatherBloc;
  NewsBloc? _newsBloc;
  UkraineCity? _selectedCity;
  late TabController _tabController;
  bool _isCelsius = true; // true for Celsius, false for Fahrenheit

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Update UI when tab changes
    });
    _initializeBlocs();
  }

  Future<void> _initializeBlocs() async {
    try {
      // Ініціалізуємо сервіс налаштувань
      await SettingsService.init();

      _weatherBloc = serviceLocator.get<WeatherBloc>();
      _newsBloc = serviceLocator.get<NewsBloc>();

      // Завантажуємо налаштування з облікового запису користувача
      _isCelsius = await SettingsService.getIsCelsius();

      // Встановлюємо місто за замовчуванням з налаштувань користувача або резервний варіант - Київ
      final defaultCityName = await SettingsService.getDefaultCityName();
      final defaultCityLat = await SettingsService.getDefaultCityLat();
      final defaultCityLon = await SettingsService.getDefaultCityLon();
      final defaultCityRegion = await SettingsService.getDefaultCityRegion();
      final defaultCityPopulation =
          await SettingsService.getDefaultCityPopulation();

      if (defaultCityName != null &&
          defaultCityLat != null &&
          defaultCityLon != null &&
          defaultCityRegion != null &&
          defaultCityPopulation != null) {
        _selectedCity = UkraineCity(
          name: defaultCityName,
          latitude: defaultCityLat,
          longitude: defaultCityLon,
          region: defaultCityRegion,
          population: defaultCityPopulation,
        );
      } else {
        // Завжди використовуємо Київ за замовчуванням, щоб запобігти множинним API викликам
        _selectedCity = UkraineCity(
          name: 'Київ',
          region: 'Київська область',
          latitude: 50.4501,
          longitude: 30.5234,
          population: 2967360,
        );
      }

      // Завантажуємо початкові дані, використовуючи One Call API
      _weatherBloc?.getWeatherForUkrainianCity(_selectedCity!);
      _newsBloc?.getTopHeadlinesData(country: 'us', category: 'technology');

      setState(() {}); // Оновлюємо UI після ініціалізації
    } catch (e) {
      print('Error initializing blocs: $e');
    }
  }

  void _onCitySelected(UkraineCity city) {
    // Оновлюємо тільки якщо місто дійсно змінилося
    if (_selectedCity?.name != city.name ||
        _selectedCity?.latitude != city.latitude ||
        _selectedCity?.longitude != city.longitude) {
      setState(() {
        _selectedCity = city;
      });
      _weatherBloc?.getWeatherForUkrainianCity(city);
    }
  }

  void _onTemperatureUnitChanged(bool isCelsius) {
    setState(() {
      _isCelsius = isCelsius;
    });
  }

  void _onDefaultCityChanged(UkraineCity? city) {
    // Оновлюємо тільки якщо місто дійсно змінилося
    if (city == null) {
      // Якщо немає міста за замовчуванням, використовуємо Київ
      if (_selectedCity?.name != 'Київ') {
        setState(() {
          _selectedCity = UkraineCity(
            name: 'Київ',
            region: 'Київська область',
            latitude: 50.4501,
            longitude: 30.5234,
            population: 2967360,
          );
        });
        _weatherBloc?.getWeatherForUkrainianCity(_selectedCity!);
      }
    } else if (_selectedCity?.name != city.name ||
        _selectedCity?.latitude != city.latitude ||
        _selectedCity?.longitude != city.longitude) {
      setState(() {
        _selectedCity = city;
      });
      _weatherBloc?.getWeatherForUkrainianCity(city);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    // Не видаляємо BLoC'и - вони є синглтонами, керованими serviceLocator
    // _weatherBloc?.dispose();
    // _newsBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Weather & News'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.wb_sunny), text: 'Погода'),
            Tab(icon: Icon(Icons.newspaper), text: 'Новини'),
            Tab(icon: Icon(Icons.settings), text: 'Налаштування'),
          ],
        ),
        actions: [
          // Кнопка перемикання температури
          if (_tabController.index == 0)
            IconButton(
              icon: Text(
                _isCelsius ? '°C' : '°F',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                ),
              ),
              onPressed: () {
                setState(() {
                  _isCelsius = !_isCelsius;
                });
              },
            ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Оновлюємо дані залежно від поточної вкладки
              if (_tabController.index == 0) {
                // Вкладка погоди
                if (_selectedCity != null) {
                  _weatherBloc?.getWeatherForUkrainianCity(_selectedCity!);
                } else {
                  _weatherBloc?.getOneCallWeatherData(
                    latitude: 50.4501,
                    longitude: 30.5234,
                  );
                }
              } else {
                // Вкладка новин
                _newsBloc?.getTopHeadlinesData();
              }
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildWeatherTab(), _buildNewsTab(), _buildSettingsTab()],
      ),
    );
  }

  Widget _buildWeatherTab() {
    final theme = Theme.of(context);
    return Container(
      color: theme.scaffoldBackgroundColor,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Погода в Україні',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: Theme.of(context).brightness == Brightness.light
                          ? FontWeight.w700
                          : FontWeight.bold,
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.location_on, color: Colors.yellow),
                  onPressed: () {
                    // Показуємо діалог пошуку міста
                    showDialog(
                      context: context,
                      builder:
                          (context) => Dialog(
                            backgroundColor: Theme.of(context).cardColor,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.7,
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Оберіть місто',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed:
                                            () => Navigator.of(context).pop(),
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Expanded(
                                    child: CitySearchWidget(
                                      onCitySelected: (city) {
                                        Navigator.of(context).pop();
                                        _onCitySelected(city);
                                      },
                                      selectedCity: _selectedCity,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            _weatherBloc != null
                ? AdvancedWeatherCard(
                  weatherBloc: _weatherBloc!,
                  isCelsius: _isCelsius,
                )
                : const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsTab() {
    final theme = Theme.of(context);
    return Container(
      color: theme.scaffoldBackgroundColor,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Останні новини',
              style: TextStyle(
                fontSize: 24,
                fontWeight: Theme.of(context).brightness == Brightness.light
                    ? FontWeight.w700
                    : FontWeight.bold,
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            _newsBloc != null
                ? NewsList(newsBloc: _newsBloc!)
                : const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SettingsPage(
      onTemperatureUnitChanged: _onTemperatureUnitChanged,
      onDefaultCityChanged: _onDefaultCityChanged,
    );
  }
}
