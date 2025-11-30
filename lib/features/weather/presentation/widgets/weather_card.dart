import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../bloc/weather_bloc.dart';

class WeatherCard extends StatefulWidget {
  final WeatherBloc weatherBloc;

  const WeatherCard({super.key, required this.weatherBloc});

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  int _selectedDayIndex = 0;

  @override
  void initState() {
    super.initState();
    widget.weatherBloc.addListener(_onWeatherStateChanged);
  }

  @override
  void dispose() {
    widget.weatherBloc.removeListener(_onWeatherStateChanged);
    super.dispose();
  }

  void _onWeatherStateChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.weatherBloc.state;

    if (state is WeatherLoading) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (state is WeatherError) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  widget.weatherBloc.getWeather(cityName: 'Kyiv');
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (state is WeatherLoaded) {
      final weather = state.weather;
      final forecasts = state.forecasts;

      if (kDebugMode) {
        print('🌤️ WeatherCard: Received ${forecasts.length} forecasts');
        print('🌤️ WeatherCard: Weather city: ${weather.cityName}');
      }

      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Заголовок з назвою міста та країни
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    weather.cityName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    weather.country,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Вибір дня внизу
              if (forecasts.isNotEmpty) ...[
                const SizedBox(height: 16),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: forecasts.length + 1, // +1 for today
                    itemBuilder: (context, index) {
                      final isToday = index == 0;
                      final isSelected = _selectedDayIndex == index;
                      final date =
                          isToday ? DateTime.now() : forecasts[index - 1].date;
                      final forecast = isToday ? null : forecasts[index - 1];

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedDayIndex = index;
                          });
                        },
                        child: Container(
                          width: 70,
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.blue : Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color:
                                  isSelected ? Colors.blue : Colors.grey[300]!,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                isToday ? 'Сьогодні' : _getDayName(date),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              // Іконка погоди
                              if (isToday)
                                Image.network(
                                  'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
                                  width: 24,
                                  height: 24,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.wb_sunny,
                                      size: 24,
                                      color: Colors.orange,
                                    );
                                  },
                                )
                              else if (forecast != null)
                                Image.network(
                                  'https://openweathermap.org/img/wn/${forecast.weather.icon}@2x.png',
                                  width: 24,
                                  height: 24,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.wb_sunny,
                                      size: 24,
                                      color: Colors.orange,
                                    );
                                  },
                                ),
                              const SizedBox(height: 4),
                              // Діапазон температури
                              if (isToday)
                                Text(
                                  '${weather.temperature.toStringAsFixed(0)}°',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        isSelected
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                )
                              else if (forecast != null)
                                Text(
                                  '${forecast.maxTemperature.toStringAsFixed(0)}° ${forecast.minTemperature.toStringAsFixed(0)}°',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        isSelected
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],

              // Деталі погоди для вибраного дня
              _buildSelectedDayWeather(weather, forecasts),
            ],
          ),
        ),
      );
    }

    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: Text('No weather data available')),
      ),
    );
  }

  Widget _buildSelectedDayWeather(weather, forecasts) {
    if (_selectedDayIndex == 0) {
      // Показуємо сьогоднішню погоду
      return _buildTodayWeather(weather);
    } else {
      // Показуємо прогноз для вибраного дня
      final forecastIndex = _selectedDayIndex - 1;
      if (forecastIndex < forecasts.length) {
        return _buildForecastWeather(forecasts[forecastIndex]);
      }
      return _buildTodayWeather(weather);
    }
  }

  Widget _buildTodayWeather(weather) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${weather.temperature.toStringAsFixed(1)}°C',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  weather.description,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            Image.network(
              'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
              width: 80,
              height: 80,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.wb_sunny,
                  size: 80,
                  color: Colors.orange,
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildWeatherDetail(
              icon: Icons.water_drop,
              label: 'Humidity',
              value: '${weather.humidity}%',
            ),
            _buildWeatherDetail(
              icon: Icons.speed,
              label: 'Wind',
              value: '${weather.windSpeed.toStringAsFixed(1)} m/s',
            ),
            _buildWeatherDetail(
              icon: Icons.compress,
              label: 'Pressure',
              value: '${weather.pressure} hPa',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildForecastWeather(forecast) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${forecast.maxTemperature.toStringAsFixed(1)}°C',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${forecast.minTemperature.toStringAsFixed(1)}°C',
                  style: const TextStyle(fontSize: 20, color: Colors.grey),
                ),
                Text(
                  forecast.weather.description,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            Image.network(
              'https://openweathermap.org/img/wn/${forecast.weather.icon}@2x.png',
              width: 80,
              height: 80,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.wb_sunny,
                  size: 80,
                  color: Colors.orange,
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildWeatherDetail(
              icon: Icons.water_drop,
              label: 'Humidity',
              value: '${forecast.humidity}%',
            ),
            _buildWeatherDetail(
              icon: Icons.speed,
              label: 'Wind',
              value: '${forecast.windSpeed.toStringAsFixed(1)} m/s',
            ),
            _buildWeatherDetail(
              icon: Icons.compress,
              label: 'Pressure',
              value: '${forecast.pressure} hPa',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWeatherDetail({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  String _getDayName(DateTime date) {
    const days = ['ПН', 'ВТ', 'СР', 'ЧТ', 'ПТ', 'СБ', 'НД'];
    return days[date.weekday - 1];
  }
}
