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
      // Initialize settings service
      await SettingsService.init();

      _weatherBloc = serviceLocator.get<WeatherBloc>();
      _newsBloc = serviceLocator.get<NewsBloc>();

      // Load settings from user account
      _isCelsius = await SettingsService.getIsCelsius();

      // Set default city from user settings or fallback to Kyiv
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
        // Always use Kyiv as default to prevent multiple API calls
        _selectedCity = UkraineCity(
          name: 'Київ',
          region: 'Київська область',
          latitude: 50.4501,
          longitude: 30.5234,
          population: 2967360,
        );
      }

      // Load initial data using One Call API
      _weatherBloc?.getWeatherForUkrainianCity(_selectedCity!);
      _newsBloc?.getTopHeadlinesData(country: 'us', category: 'technology');

      setState(() {}); // Update UI after initialization
    } catch (e) {
      print('Error initializing blocs: $e');
    }
  }

  void _onCitySelected(UkraineCity city) {
    // Only update if city actually changed
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
    // Only update if city actually changed
    if (city == null) {
      // If no default city, use Kyiv
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
    // Don't dispose BLoCs - they are singletons managed by serviceLocator
    // _weatherBloc?.dispose();
    // _newsBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF121212)
              : Colors.white,
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
          // Temperature toggle button
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
              // Refresh data based on current tab
              if (_tabController.index == 0) {
                // Weather tab
                if (_selectedCity != null) {
                  _weatherBloc?.getWeatherForUkrainianCity(_selectedCity!);
                } else {
                  _weatherBloc?.getOneCallWeatherData(
                    latitude: 50.4501,
                    longitude: 30.5234,
                  );
                }
              } else {
                // News tab
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
    return Container(
      color:
          Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF121212)
              : Colors.white,
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
                      fontWeight: FontWeight.bold,
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
                    // Show city search dialog
                    showDialog(
                      context: context,
                      builder:
                          (context) => Dialog(
                            backgroundColor: const Color(0xFF1A1A1A),
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
    return Container(
      color:
          Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF121212)
              : Colors.white,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Останні новини',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
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
