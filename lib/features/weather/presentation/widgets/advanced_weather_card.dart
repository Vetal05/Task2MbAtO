import 'package:flutter/material.dart';
import '../bloc/weather_bloc.dart';
import '../../domain/entities/hourly_forecast.dart';

class AdvancedWeatherCard extends StatefulWidget {
  final WeatherBloc weatherBloc;
  final bool isCelsius;

  const AdvancedWeatherCard({
    super.key,
    required this.weatherBloc,
    this.isCelsius = true,
  });

  @override
  State<AdvancedWeatherCard> createState() => _AdvancedWeatherCardState();
}

class _AdvancedWeatherCardState extends State<AdvancedWeatherCard>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedDayIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    widget.weatherBloc.addListener(_onWeatherStateChanged);
  }

  @override
  void dispose() {
    widget.weatherBloc.removeListener(_onWeatherStateChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onWeatherStateChanged() {
    setState(() {});
  }

  // Функції конвертації температури
  double _convertTemperature(double celsius) {
    if (widget.isCelsius) {
      return celsius;
    } else {
      return (celsius * 9 / 5) + 32;
    }
  }

  String _getTemperatureUnit() {
    return widget.isCelsius ? '°C' : '°F';
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.weatherBloc.state;

    if (state is WeatherLoading) {
      return _buildLoadingCard();
    }

    if (state is WeatherError) {
      return _buildErrorCard(state.message);
    }

    if (state is WeatherLoaded) {
      final weather = state.weather;
      final forecasts = state.forecasts;
      final hourlyForecasts = state.hourlyForecasts;

      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [const Color(0xFF1A1A1A), const Color(0xFF2D2D2D)],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(weather, forecasts),
              const SizedBox(height: 20),
              _buildSelectedDayWeather(weather, forecasts),
              const SizedBox(height: 20),
              _buildTabs(),
              const SizedBox(height: 20),
              _buildTabContent(hourlyForecasts, forecasts),
              const SizedBox(height: 20),
              _buildWeeklyForecast(forecasts),
            ],
          ),
        ),
      );
    }

    return _buildNoDataCard();
  }

  Widget _buildLoadingCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorCard(String message) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(
              'Error: $message',
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                widget.weatherBloc.getOneCallWeatherData(
                  latitude: 50.4501, // Kyiv coordinates
                  longitude: 30.5234,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoDataCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Text(
            'No weather data available',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(weather, forecasts) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              weather.cityName.isNotEmpty
                  ? weather.cityName
                  : 'Current Location',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _getSelectedDayDateTime(weather, forecasts),
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              '°C',
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              '°F',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCurrentWeather(weather) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${_convertTemperature(weather.temperature).toStringAsFixed(0)}${_getTemperatureUnit()}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.network(
                    'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
                    width: 60,
                    height: 60,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.wb_sunny,
                        size: 60,
                        color: Colors.yellow,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                weather.description,
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              _buildWeatherDetail('Опади', '0%', Icons.water_drop),
              const SizedBox(height: 8),
              _buildWeatherDetail(
                'Вологість',
                '${weather.humidity}%',
                Icons.water,
              ),
              const SizedBox(height: 8),
              _buildWeatherDetail(
                'Вітер',
                '${weather.windSpeed.toStringAsFixed(0)} км/год',
                Icons.air,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherDetail(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.yellow, size: 16),
        const SizedBox(width: 8),
        Text(
          '$label: $value',
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildSelectedDayWeather(weather, forecasts) {
    if (_selectedDayIndex == 0) {
      // Показуємо сьогоднішню погоду
      return _buildCurrentWeather(weather);
    } else {
      // Показуємо прогноз для вибраного дня
      final forecastIndex = _selectedDayIndex - 1;
      if (forecastIndex >= 0 && forecastIndex < forecasts.length) {
        return _buildForecastWeather(forecasts[forecastIndex]);
      }
      return _buildCurrentWeather(weather);
    }
  }

  Widget _buildForecastWeather(forecast) {
    if (forecast == null) {
      return const Center(
        child: Text(
          'No forecast data available',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${_convertTemperature(forecast.maxTemperature).toStringAsFixed(0)}${_getTemperatureUnit()}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.network(
                    'https://openweathermap.org/img/wn/${forecast.weather.icon}@2x.png',
                    width: 60,
                    height: 60,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.wb_sunny,
                        size: 60,
                        color: Colors.yellow,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Мін: ${_convertTemperature(forecast.minTemperature).toStringAsFixed(0)}${_getTemperatureUnit()}',
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                forecast.weather.description,
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              _buildWeatherDetail('Опади', '0%', Icons.water_drop),
              const SizedBox(height: 8),
              _buildWeatherDetail(
                'Вологість',
                '${forecast.humidity}%',
                Icons.water,
              ),
              const SizedBox(height: 8),
              _buildWeatherDetail(
                'Вітер',
                '${forecast.windSpeed.toStringAsFixed(0)} км/год',
                Icons.air,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.yellow,
        ),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.white,
        tabs: const [
          Tab(text: 'Температура'),
          Tab(text: 'Опади'),
          Tab(text: 'Вітер'),
        ],
      ),
    );
  }

  Widget _buildTabContent(hourlyForecasts, forecasts) {
    return SizedBox(
      height: 240, // Increased height to accommodate labels
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildTemperatureGraph(hourlyForecasts, forecasts),
          _buildPrecipitationGraph(hourlyForecasts, forecasts),
          _buildWindGraph(hourlyForecasts, forecasts),
        ],
      ),
    );
  }

  Widget _buildTemperatureGraph(hourlyForecasts, forecasts) {
    if (hourlyForecasts.isEmpty) {
      return const Center(
        child: Text(
          'No hourly data available',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    // Отримуємо дані для вибраного дня
    List graphData;
    if (_selectedDayIndex == 0) {
      // Сьогодні - використовуємо всі погодинні прогнози (до 48 годин)
      graphData = hourlyForecasts.toList();
    } else {
      // Вибраний день прогнозу - створюємо мокові погодинні дані з денного прогнозу
      final forecastIndex = _selectedDayIndex - 1;
      if (forecastIndex >= 0 && forecastIndex < forecasts.length) {
        final forecast = forecasts[forecastIndex];
        // Створюємо 24 погодинні точки даних для вибраного дня з плавною варіацією
        graphData = List.generate(24, (index) {
          // Створюємо плавну криву температури (вища вдень, нижча вночі)
          final hour = index % 24;
          final dayProgress = hour / 24.0;
          // Температура досягає піку близько полудня (0.5), нижча вночі
          final dayFactor = 0.5 + 0.5 * (1 - (dayProgress - 0.5).abs() * 2);
          final tempVariation =
              (forecast.maxTemperature - forecast.minTemperature) * dayFactor;
          final temperature = forecast.minTemperature + tempVariation;

          return HourlyForecast(
            dateTime: forecast.date.add(Duration(hours: hour)),
            temperature: temperature,
            feelsLike: temperature - 1.0,
            pressure: forecast.pressure,
            humidity: forecast.humidity,
            windSpeed: forecast.windSpeed,
            windDirection: forecast.windDeg,
            precipitationProbability: forecast.precipitationProbability,
            weather: forecast.weather,
          );
        });
      } else {
        graphData = hourlyForecasts.toList();
      }
    }

    if (graphData.isEmpty) {
      return const Center(
        child: Text(
          'No temperature data available',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    double minTemp = 0;
    double maxTemp = 0;
    double tempRange = 0;

    try {
      final temps =
          graphData.map((h) => _convertTemperature(h.temperature)).toList();
      minTemp = temps.reduce((a, b) => a < b ? a : b);
      maxTemp = temps.reduce((a, b) => a > b ? a : b);
      tempRange = maxTemp - minTemp;

      // Обробляємо випадок, коли всі температури однакові (tempRange = 0)
      if (tempRange == 0) {
        // Додаємо відступ, щоб створити видимий діапазон
        minTemp = minTemp - 5;
        maxTemp = maxTemp + 5;
        tempRange = 10;
      }
    } catch (e) {
      debugPrint('Error calculating temperature range: $e');
      return const Center(
        child: Text(
          'Error loading temperature data',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    // Обчислюємо ширину для прокручуваного графіка (120 пікселів на точку даних)
    final graphWidth = graphData.length * 120.0;
    final graphHeight = 240.0;

    return _InteractiveGraphWrapper(
      graphWidth: graphWidth,
      graphHeight: graphHeight,
      graphData: graphData,
      selectedDayIndex: _selectedDayIndex,
      child: SizedBox(
        width: graphWidth,
        height: graphHeight,
        child: CustomPaint(
          key: ValueKey('temp_$_selectedDayIndex'),
          painter: TemperatureGraphPainter(
            hourlyForecasts: graphData,
            minTemp: minTemp,
            maxTemp: maxTemp,
            tempRange: tempRange,
            convertTemperature: _convertTemperature,
          ),
        ),
      ),
      getDataPoint: (index) {
        if (index >= 0 && index < graphData.length) {
          final forecast = graphData[index];
          return GraphDataPoint(
            time: forecast.dateTime,
            value: _convertTemperature(forecast.temperature),
            unit: _getTemperatureUnit(),
            label: 'Температура',
          );
        }
        return null;
      },
    );
  }

  Widget _buildPrecipitationGraph(hourlyForecasts, forecasts) {
    if (hourlyForecasts.isEmpty) {
      return const Center(
        child: Text(
          'No hourly data available',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    // Get data for selected day
    List graphData;
    if (_selectedDayIndex == 0) {
      // Today - use all hourly forecasts
      graphData = hourlyForecasts.toList();
    } else {
      // Selected forecast day - create mock hourly data from daily forecast
      final forecastIndex = _selectedDayIndex - 1;
      if (forecastIndex >= 0 && forecastIndex < forecasts.length) {
        final forecast = forecasts[forecastIndex];
        // Create 24 hourly data points with smooth variation
        graphData = List.generate(24, (index) {
          final hour = index % 24;
          // Precipitation is higher during certain hours (morning/evening)
          final hourFactor = 1.0 - (hour - 12).abs() / 12.0;
          final precipitation = forecast.precipitationProbability * hourFactor;

          return HourlyForecast(
            dateTime: forecast.date.add(Duration(hours: hour)),
            temperature: forecast.maxTemperature - (hour * 0.3),
            feelsLike: forecast.maxTemperature - (hour * 0.3),
            pressure: forecast.pressure,
            humidity: forecast.humidity,
            windSpeed: forecast.windSpeed,
            windDirection: forecast.windDeg,
            precipitationProbability: precipitation.clamp(0.0, 1.0),
            weather: forecast.weather,
          );
        });
      } else {
        graphData = hourlyForecasts.toList();
      }
    }

    if (graphData.isEmpty) {
      return const Center(
        child: Text(
          'No precipitation data available',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    double maxPrecipitation = 0;
    try {
      final precipitations =
          graphData.map((h) => h.precipitationProbability).toList();
      maxPrecipitation = precipitations.reduce((a, b) => a > b ? a : b);

      // Handle case when all values are 0
      if (maxPrecipitation == 0) {
        maxPrecipitation = 1.0; // Set to 100% for visual representation
      }
    } catch (e) {
      debugPrint('Error calculating max precipitation: $e');
      return const Center(
        child: Text(
          'Error loading precipitation data',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    // Calculate width for scrollable graph
    final graphWidth = graphData.length * 120.0;
    final graphHeight = 240.0;

    return _InteractiveGraphWrapper(
      graphWidth: graphWidth,
      graphHeight: graphHeight,
      graphData: graphData,
      selectedDayIndex: _selectedDayIndex,
      child: SizedBox(
        width: graphWidth,
        height: graphHeight,
        child: CustomPaint(
          key: ValueKey('precip_$_selectedDayIndex'),
          painter: PrecipitationGraphPainter(
            hourlyForecasts: graphData,
            maxPrecipitation: maxPrecipitation,
          ),
        ),
      ),
      getDataPoint: (index) {
        if (index >= 0 && index < graphData.length) {
          final forecast = graphData[index];
          return GraphDataPoint(
            time: forecast.dateTime,
            value: forecast.precipitationProbability * 100,
            unit: '%',
            label: 'Опади',
          );
        }
        return null;
      },
    );
  }

  Widget _buildWindGraph(hourlyForecasts, forecasts) {
    if (hourlyForecasts.isEmpty) {
      return const Center(
        child: Text(
          'No hourly data available',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    // Get data for selected day
    List graphData;
    if (_selectedDayIndex == 0) {
      // Today - use all hourly forecasts
      graphData = hourlyForecasts.toList();
    } else {
      // Selected forecast day - create mock hourly data from daily forecast
      final forecastIndex = _selectedDayIndex - 1;
      if (forecastIndex >= 0 && forecastIndex < forecasts.length) {
        final forecast = forecasts[forecastIndex];
        // Create 24 hourly data points with smooth variation
        graphData = List.generate(24, (index) {
          final hour = index % 24;
          // Wind speed varies smoothly throughout the day
          final hourFactor = 0.7 + 0.3 * (1 - (hour - 12).abs() / 12.0);
          final windSpeed = forecast.windSpeed * hourFactor;

          return HourlyForecast(
            dateTime: forecast.date.add(Duration(hours: hour)),
            temperature: forecast.maxTemperature - (hour * 0.3),
            feelsLike: forecast.maxTemperature - (hour * 0.3),
            pressure: forecast.pressure,
            humidity: forecast.humidity,
            windSpeed: windSpeed,
            windDirection: forecast.windDeg,
            precipitationProbability: forecast.precipitationProbability,
            weather: forecast.weather,
          );
        });
      } else {
        graphData = hourlyForecasts.toList();
      }
    }

    if (graphData.isEmpty) {
      return const Center(
        child: Text(
          'No wind data available',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    double maxWindSpeed = 0;
    try {
      final windSpeeds = graphData.map((h) => h.windSpeed).toList();
      maxWindSpeed = windSpeeds.reduce((a, b) => a > b ? a : b);

      // Handle case when all values are 0
      if (maxWindSpeed == 0) {
        maxWindSpeed = 10.0; // Set default max for visual representation
      }
    } catch (e) {
      debugPrint('Error calculating max wind speed: $e');
      return const Center(
        child: Text(
          'Error loading wind data',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    // Calculate width for scrollable graph
    final graphWidth = graphData.length * 120.0;
    final graphHeight = 240.0;

    return _InteractiveGraphWrapper(
      graphWidth: graphWidth,
      graphHeight: graphHeight,
      graphData: graphData,
      selectedDayIndex: _selectedDayIndex,
      child: SizedBox(
        width: graphWidth,
        height: graphHeight,
        child: CustomPaint(
          key: ValueKey('wind_$_selectedDayIndex'),
          painter: WindGraphPainter(
            hourlyForecasts: graphData,
            maxWindSpeed: maxWindSpeed,
          ),
        ),
      ),
      getDataPoint: (index) {
        if (index >= 0 && index < graphData.length) {
          final forecast = graphData[index];
          return GraphDataPoint(
            time: forecast.dateTime,
            value: forecast.windSpeed,
            unit: ' м/с',
            label: 'Вітер',
          );
        }
        return null;
      },
    );
  }

  Widget _buildWeeklyForecast(forecasts) {
    if (forecasts.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '7-Day Forecast',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: forecasts.length,
            itemBuilder: (context, index) {
              final forecast = forecasts[index];
              final isSelected =
                  _selectedDayIndex == index + 1; // +1 because index 0 is today
              final dayName = _getDayName(forecast.date);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDayIndex =
                        index + 1; // +1 because index 0 is today
                  });
                },
                child: Container(
                  width: 90,
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.yellow : const Color(0xFF2D2D2D),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? Colors.yellow : Colors.grey,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        dayName,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.black : Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Image.network(
                        'https://openweathermap.org/img/wn/${forecast.weather.icon}@2x.png',
                        width: 20,
                        height: 20,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.wb_sunny,
                            size: 20,
                            color: isSelected ? Colors.black : Colors.yellow,
                          );
                        },
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${_convertTemperature(forecast.maxTemperature).toStringAsFixed(0)}° ${_convertTemperature(forecast.minTemperature).toStringAsFixed(0)}°',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.black : Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _getDayName(DateTime date) {
    const days = [
      'Неділя',
      'Понеділок',
      'Вівторок',
      'Середа',
      'Четвер',
      'П\'ятниця',
      'Субота',
    ];
    final dayName = days[date.weekday % 7];
    return '$dayName\n${date.day}/${date.month}';
  }

  String _getSelectedDayDateTime(weather, forecasts) {
    if (_selectedDayIndex == 0) {
      // Show today's date and time
      final now = DateTime.now();
      return 'Сьогодні ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    } else {
      // Show selected forecast day's date
      final forecastIndex = _selectedDayIndex - 1;
      if (forecastIndex >= 0 && forecastIndex < forecasts.length) {
        final forecast = forecasts[forecastIndex];
        const days = [
          'Неділя',
          'Понеділок',
          'Вівторок',
          'Середа',
          'Четвер',
          'П\'ятниця',
          'Субота',
        ];
        final dayName = days[forecast.date.weekday % 7];
        return '$dayName ${forecast.date.day}/${forecast.date.month}';
      }
      final now = DateTime.now();
      return 'Сьогодні ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    }
  }
}

// Data point structure for tooltip
class GraphDataPoint {
  final DateTime time;
  final double value;
  final String unit;
  final String label;

  GraphDataPoint({
    required this.time,
    required this.value,
    required this.unit,
    required this.label,
  });
}

// Interactive wrapper for graphs with hover/touch support
class _InteractiveGraphWrapper extends StatefulWidget {
  final double graphWidth;
  final double graphHeight;
  final List graphData;
  final int selectedDayIndex;
  final Widget child;
  final GraphDataPoint? Function(int index) getDataPoint;

  const _InteractiveGraphWrapper({
    required this.graphWidth,
    required this.graphHeight,
    required this.graphData,
    required this.selectedDayIndex,
    required this.child,
    required this.getDataPoint,
  });

  @override
  State<_InteractiveGraphWrapper> createState() =>
      _InteractiveGraphWrapperState();
}

class _InteractiveGraphWrapperState extends State<_InteractiveGraphWrapper> {
  int? _hoveredIndex;
  final ScrollController _scrollController = ScrollController();

  int _getIndexFromX(double x) {
    final stepX = 120.0;
    final index = (x / stepX).round();
    return index.clamp(0, widget.graphData.length - 1);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanUpdate: (details) {
          final scrollOffset =
              _scrollController.hasClients ? _scrollController.offset : 0.0;
          final adjustedX = details.localPosition.dx + scrollOffset;
          setState(() {
            _hoveredIndex = _getIndexFromX(adjustedX);
          });
        },
        onTapDown: (details) {
          final scrollOffset =
              _scrollController.hasClients ? _scrollController.offset : 0.0;
          final adjustedX = details.localPosition.dx + scrollOffset;
          setState(() {
            _hoveredIndex = _getIndexFromX(adjustedX);
          });
        },
        onPanEnd: (_) {
          setState(() {
            _hoveredIndex = null;
          });
        },
        onTapUp: (_) {
          // Keep showing tooltip for a moment after tap
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              setState(() {
                _hoveredIndex = null;
              });
            }
          });
        },
        child: SizedBox(
          width: widget.graphWidth,
          height: widget.graphHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              widget.child,
              if (_hoveredIndex != null) _buildTooltip(_hoveredIndex!),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTooltip(int index) {
    final dataPoint = widget.getDataPoint(index);
    if (dataPoint == null) return const SizedBox.shrink();

    final stepX = 120.0;
    final x = index * stepX;
    final scrollOffset =
        _scrollController.hasClients ? _scrollController.offset : 0.0;
    final adjustedX = (x - scrollOffset).clamp(0.0, widget.graphWidth - 140);

    final timeStr =
        '${dataPoint.time.hour.toString().padLeft(2, '0')}:${dataPoint.time.minute.toString().padLeft(2, '0')}';
    final valueStr = '${dataPoint.value.toStringAsFixed(1)}${dataPoint.unit}';

    return Positioned(
      left: adjustedX,
      top: 10,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
        color: Colors.black87,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dataPoint.label,
                style: const TextStyle(color: Colors.white70, fontSize: 11),
              ),
              const SizedBox(height: 4),
              Text(
                timeStr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                valueStr,
                style: const TextStyle(
                  color: Colors.yellow,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TemperatureGraphPainter extends CustomPainter {
  final List hourlyForecasts;
  final double minTemp;
  final double maxTemp;
  final double tempRange;
  final Function(double) convertTemperature;

  TemperatureGraphPainter({
    required this.hourlyForecasts,
    required this.minTemp,
    required this.maxTemp,
    required this.tempRange,
    required this.convertTemperature,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (hourlyForecasts.isEmpty) return;

    final paint =
        Paint()
          ..color = Colors.yellow
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;

    final fillPaint =
        Paint()
          ..color = Colors.yellow.withValues(alpha: 0.3)
          ..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();

    final height = size.height;
    final stepX = 120.0; // Fixed step for scrollable graph
    final labelBottom =
        height - 40; // Bottom of graph area (leaving space for labels)
    final graphTop =
        40; // Top of graph area (leaving space for temperature labels)
    final graphHeight = labelBottom - graphTop; // Available height for graph

    // Calculate all points first
    final points = <Offset>[];
    for (int i = 0; i < hourlyForecasts.length; i++) {
      final forecast = hourlyForecasts[i];
      final x = i * stepX;
      final convertedTemp = convertTemperature(forecast.temperature);
      // Normalize temperature: 0 = minTemp (bottom), 1 = maxTemp (top)
      final normalizedTemp = (convertedTemp - minTemp) / tempRange;
      // In Flutter, y increases downward, so:
      // - minTemp (normalizedTemp = 0) → y = labelBottom (bottom)
      // - maxTemp (normalizedTemp = 1) → y = graphTop (top)
      // Formula: start from bottom, subtract normalized portion of graph height
      final y = labelBottom - (normalizedTemp * graphHeight);
      points.add(Offset(x, y));
    }

    if (points.isEmpty) return;

    // Create smooth cubic bezier curve using improved algorithm
    path.moveTo(points[0].dx, points[0].dy);
    fillPath.moveTo(points[0].dx, labelBottom);
    fillPath.lineTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length - 1; i++) {
      final current = points[i];
      final next = points[i + 1];

      // Improved control points calculation for smoother curves
      double cp1x, cp1y, cp2x, cp2y;

      if (i == 0) {
        // First segment: use forward-looking control point
        final following = i + 1 < points.length ? points[i + 1] : next;
        final dx = (following.dx - current.dx) * 0.3;
        final dy = (following.dy - current.dy) * 0.3;
        cp1x = current.dx + dx;
        cp1y = current.dy + dy;
      } else {
        // Use previous point for smoother transition
        final previous = points[i - 1];
        final dx = (next.dx - previous.dx) * 0.15;
        final dy = (next.dy - previous.dy) * 0.15;
        cp1x = current.dx + dx;
        cp1y = current.dy + dy;
      }

      if (i == points.length - 2) {
        // Last segment: use backward-looking control point
        final previous = points[i];
        final dx = (next.dx - previous.dx) * 0.3;
        final dy = (next.dy - previous.dy) * 0.3;
        cp2x = next.dx - dx;
        cp2y = next.dy - dy;
      } else {
        // Use next point for smoother transition
        final following = points[i + 2];
        final dx = (following.dx - current.dx) * 0.15;
        final dy = (following.dy - current.dy) * 0.15;
        cp2x = next.dx - dx;
        cp2y = next.dy - dy;
      }

      // Use cubic bezier for smooth curves
      path.cubicTo(cp1x, cp1y, cp2x, cp2y, next.dx, next.dy);
      fillPath.cubicTo(cp1x, cp1y, cp2x, cp2y, next.dx, next.dy);
    }

    // Complete the fill path
    fillPath.lineTo(points.last.dx, labelBottom);
    fillPath.close();

    // Draw fill area
    canvas.drawPath(fillPath, fillPaint);

    // Draw temperature line
    canvas.drawPath(path, paint);

    // Draw temperature points and labels
    final pointPaint =
        Paint()
          ..color = Colors.yellow
          ..style = PaintingStyle.fill;

    for (int i = 0; i < hourlyForecasts.length; i++) {
      final forecast = hourlyForecasts[i];
      final x = i * stepX;
      final convertedTemp = convertTemperature(forecast.temperature);
      // Normalize: 0 = minTemp (bottom), 1 = maxTemp (top)
      final normalizedTemp = (convertedTemp - minTemp) / tempRange;
      // Higher temperature = smaller y (top), lower temperature = larger y (bottom)
      final y = labelBottom - (normalizedTemp * graphHeight);

      // Draw point
      canvas.drawCircle(Offset(x, y), 5, pointPaint);

      // Draw white border around point
      final borderPaint =
          Paint()
            ..color = Colors.white
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2;
      canvas.drawCircle(Offset(x, y), 5, borderPaint);

      // Draw temperature text above point (show every 3rd point to avoid clutter)
      if (i % 3 == 0 || i == 0 || i == hourlyForecasts.length - 1) {
        final textPainter = TextPainter(
          text: TextSpan(
            text:
                '${convertTemperature(forecast.temperature).toStringAsFixed(0)}°',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(x - textPainter.width / 2, y - 25));
      }

      // Draw time text (show every 3rd point)
      if (i % 3 == 0 || i == 0 || i == hourlyForecasts.length - 1) {
        final timeTextPainter = TextPainter(
          text: TextSpan(
            text:
                '${forecast.dateTime.hour.toString().padLeft(2, '0')}:${forecast.dateTime.minute.toString().padLeft(2, '0')}',
            style: const TextStyle(color: Colors.grey, fontSize: 10),
          ),
          textDirection: TextDirection.ltr,
        );
        timeTextPainter.layout();
        timeTextPainter.paint(
          canvas,
          Offset(x - timeTextPainter.width / 2, labelBottom + 5),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant TemperatureGraphPainter oldDelegate) {
    return hourlyForecasts != oldDelegate.hourlyForecasts ||
        minTemp != oldDelegate.minTemp ||
        maxTemp != oldDelegate.maxTemp ||
        tempRange != oldDelegate.tempRange;
  }
}

class PrecipitationGraphPainter extends CustomPainter {
  final List hourlyForecasts;
  final double maxPrecipitation;

  PrecipitationGraphPainter({
    required this.hourlyForecasts,
    required this.maxPrecipitation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (hourlyForecasts.isEmpty) return;

    final paint =
        Paint()
          ..color = Colors.blue
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;

    final fillPaint =
        Paint()
          ..color = Colors.blue.withValues(alpha: 0.3)
          ..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();

    final height = size.height;
    final stepX = 120.0; // Fixed step for scrollable graph
    final labelBottom = height - 40;
    final graphTop = 40;
    final graphHeight = labelBottom - graphTop;

    // Calculate all points first
    final points = <Offset>[];
    for (int i = 0; i < hourlyForecasts.length; i++) {
      final forecast = hourlyForecasts[i];
      final x = i * stepX;
      final normalizedPrecipitation =
          maxPrecipitation > 0
              ? forecast.precipitationProbability / maxPrecipitation
              : 0;
      // Higher precipitation = smaller y (top), lower = larger y (bottom)
      final y = labelBottom - (normalizedPrecipitation * graphHeight);
      points.add(Offset(x, y));
    }

    if (points.isEmpty) return;

    // Create smooth cubic bezier curve using improved algorithm
    path.moveTo(points[0].dx, points[0].dy);
    fillPath.moveTo(points[0].dx, labelBottom);
    fillPath.lineTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length - 1; i++) {
      final current = points[i];
      final next = points[i + 1];

      // Improved control points calculation for smoother curves
      double cp1x, cp1y, cp2x, cp2y;

      if (i == 0) {
        final following = i + 1 < points.length ? points[i + 1] : next;
        final dx = (following.dx - current.dx) * 0.3;
        final dy = (following.dy - current.dy) * 0.3;
        cp1x = current.dx + dx;
        cp1y = current.dy + dy;
      } else {
        final previous = points[i - 1];
        final dx = (next.dx - previous.dx) * 0.15;
        final dy = (next.dy - previous.dy) * 0.15;
        cp1x = current.dx + dx;
        cp1y = current.dy + dy;
      }

      if (i == points.length - 2) {
        final previous = points[i];
        final dx = (next.dx - previous.dx) * 0.3;
        final dy = (next.dy - previous.dy) * 0.3;
        cp2x = next.dx - dx;
        cp2y = next.dy - dy;
      } else {
        final following = points[i + 2];
        final dx = (following.dx - current.dx) * 0.15;
        final dy = (following.dy - current.dy) * 0.15;
        cp2x = next.dx - dx;
        cp2y = next.dy - dy;
      }

      path.cubicTo(cp1x, cp1y, cp2x, cp2y, next.dx, next.dy);
      fillPath.cubicTo(cp1x, cp1y, cp2x, cp2y, next.dx, next.dy);
    }

    // Complete the fill path
    fillPath.lineTo(points.last.dx, labelBottom);
    fillPath.close();

    // Draw fill area
    canvas.drawPath(fillPath, fillPaint);

    // Draw precipitation line
    canvas.drawPath(path, paint);

    // Draw precipitation points and labels
    final pointPaint =
        Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.fill;

    for (int i = 0; i < hourlyForecasts.length; i++) {
      final forecast = hourlyForecasts[i];
      final x = i * stepX;
      final normalizedPrecipitation =
          maxPrecipitation > 0
              ? forecast.precipitationProbability / maxPrecipitation
              : 0;
      final y = labelBottom - (normalizedPrecipitation * graphHeight);

      // Draw point
      canvas.drawCircle(Offset(x, y), 5, pointPaint);

      // Draw white border around point
      final borderPaint =
          Paint()
            ..color = Colors.white
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2;
      canvas.drawCircle(Offset(x, y), 5, borderPaint);

      // Draw precipitation percentage text (every 3rd point)
      if (i % 3 == 0 || i == 0 || i == hourlyForecasts.length - 1) {
        final textPainter = TextPainter(
          text: TextSpan(
            text:
                '${(forecast.precipitationProbability * 100).toStringAsFixed(0)}%',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(x - textPainter.width / 2, y - 25));

        // Draw time text
        final timeTextPainter = TextPainter(
          text: TextSpan(
            text:
                '${forecast.dateTime.hour.toString().padLeft(2, '0')}:${forecast.dateTime.minute.toString().padLeft(2, '0')}',
            style: const TextStyle(color: Colors.grey, fontSize: 10),
          ),
          textDirection: TextDirection.ltr,
        );
        timeTextPainter.layout();
        timeTextPainter.paint(
          canvas,
          Offset(x - timeTextPainter.width / 2, labelBottom + 5),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant PrecipitationGraphPainter oldDelegate) {
    return hourlyForecasts != oldDelegate.hourlyForecasts ||
        maxPrecipitation != oldDelegate.maxPrecipitation;
  }
}

class WindGraphPainter extends CustomPainter {
  final List hourlyForecasts;
  final double maxWindSpeed;

  WindGraphPainter({required this.hourlyForecasts, required this.maxWindSpeed});

  @override
  void paint(Canvas canvas, Size size) {
    if (hourlyForecasts.isEmpty) return;

    final paint =
        Paint()
          ..color = Colors.green
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;

    final fillPaint =
        Paint()
          ..color = Colors.green.withValues(alpha: 0.3)
          ..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();

    final height = size.height;
    final stepX = 120.0; // Fixed step for scrollable graph
    final labelBottom = height - 40;
    final graphTop = 40;
    final graphHeight = labelBottom - graphTop;

    // Calculate all points first
    final points = <Offset>[];
    for (int i = 0; i < hourlyForecasts.length; i++) {
      final forecast = hourlyForecasts[i];
      final x = i * stepX;
      final normalizedWindSpeed =
          maxWindSpeed > 0 ? forecast.windSpeed / maxWindSpeed : 0;
      // Higher wind speed = smaller y (top), lower = larger y (bottom)
      final y = labelBottom - (normalizedWindSpeed * graphHeight);
      points.add(Offset(x, y));
    }

    if (points.isEmpty) return;

    // Create smooth cubic bezier curve using improved algorithm
    path.moveTo(points[0].dx, points[0].dy);
    fillPath.moveTo(points[0].dx, labelBottom);
    fillPath.lineTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length - 1; i++) {
      final current = points[i];
      final next = points[i + 1];

      // Improved control points calculation for smoother curves
      double cp1x, cp1y, cp2x, cp2y;

      if (i == 0) {
        final following = i + 1 < points.length ? points[i + 1] : next;
        final dx = (following.dx - current.dx) * 0.3;
        final dy = (following.dy - current.dy) * 0.3;
        cp1x = current.dx + dx;
        cp1y = current.dy + dy;
      } else {
        final previous = points[i - 1];
        final dx = (next.dx - previous.dx) * 0.15;
        final dy = (next.dy - previous.dy) * 0.15;
        cp1x = current.dx + dx;
        cp1y = current.dy + dy;
      }

      if (i == points.length - 2) {
        final previous = points[i];
        final dx = (next.dx - previous.dx) * 0.3;
        final dy = (next.dy - previous.dy) * 0.3;
        cp2x = next.dx - dx;
        cp2y = next.dy - dy;
      } else {
        final following = points[i + 2];
        final dx = (following.dx - current.dx) * 0.15;
        final dy = (following.dy - current.dy) * 0.15;
        cp2x = next.dx - dx;
        cp2y = next.dy - dy;
      }

      path.cubicTo(cp1x, cp1y, cp2x, cp2y, next.dx, next.dy);
      fillPath.cubicTo(cp1x, cp1y, cp2x, cp2y, next.dx, next.dy);
    }

    // Complete the fill path
    fillPath.lineTo(points.last.dx, labelBottom);
    fillPath.close();

    // Draw fill area
    canvas.drawPath(fillPath, fillPaint);

    // Draw wind speed line
    canvas.drawPath(path, paint);

    // Draw wind speed points and labels
    final pointPaint =
        Paint()
          ..color = Colors.green
          ..style = PaintingStyle.fill;

    for (int i = 0; i < hourlyForecasts.length; i++) {
      final forecast = hourlyForecasts[i];
      final x = i * stepX;
      final normalizedWindSpeed =
          maxWindSpeed > 0 ? forecast.windSpeed / maxWindSpeed : 0;
      final y = labelBottom - (normalizedWindSpeed * graphHeight);

      // Draw point
      canvas.drawCircle(Offset(x, y), 5, pointPaint);

      // Draw white border around point
      final borderPaint =
          Paint()
            ..color = Colors.white
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2;
      canvas.drawCircle(Offset(x, y), 5, borderPaint);

      // Draw wind speed text (every 3rd point)
      if (i % 3 == 0 || i == 0 || i == hourlyForecasts.length - 1) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: '${forecast.windSpeed.toStringAsFixed(1)} м/с',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(x - textPainter.width / 2, y - 25));

        // Draw time text
        final timeTextPainter = TextPainter(
          text: TextSpan(
            text:
                '${forecast.dateTime.hour.toString().padLeft(2, '0')}:${forecast.dateTime.minute.toString().padLeft(2, '0')}',
            style: const TextStyle(color: Colors.grey, fontSize: 10),
          ),
          textDirection: TextDirection.ltr,
        );
        timeTextPainter.layout();
        timeTextPainter.paint(
          canvas,
          Offset(x - timeTextPainter.width / 2, labelBottom + 5),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant WindGraphPainter oldDelegate) {
    return hourlyForecasts != oldDelegate.hourlyForecasts ||
        maxWindSpeed != oldDelegate.maxWindSpeed;
  }
}
