import 'package:flutter/material.dart';
import '../../../../main.dart';
import '../../../../core/services/settings_service.dart';
import '../../../../core/di/injection.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../weather/domain/entities/ukraine_city.dart';
import '../../../weather/presentation/widgets/city_search_widget.dart';

class SettingsPage extends StatefulWidget {
  final Function(bool) onTemperatureUnitChanged;
  final Function(UkraineCity?) onDefaultCityChanged;

  const SettingsPage({
    super.key,
    required this.onTemperatureUnitChanged,
    required this.onDefaultCityChanged,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isCelsius = true;
  UkraineCity? _defaultCity;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final isCelsius = await SettingsService.getIsCelsius();
    final cityName = await SettingsService.getDefaultCityName();
    final cityLat = await SettingsService.getDefaultCityLat();
    final cityLon = await SettingsService.getDefaultCityLon();
    final cityRegion = await SettingsService.getDefaultCityRegion();
    final cityPopulation = await SettingsService.getDefaultCityPopulation();

    setState(() {
      _isCelsius = isCelsius;

      if (cityName != null &&
          cityLat != null &&
          cityLon != null &&
          cityRegion != null &&
          cityPopulation != null) {
        _defaultCity = UkraineCity(
          name: cityName,
          latitude: cityLat,
          longitude: cityLon,
          region: cityRegion,
          population: cityPopulation,
        );
      }
    });
  }

  void _showCitySearchDialog() {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.7,
              padding: const EdgeInsets.all(20),
              child: CitySearchWidget(
                onCitySelected: (city) {
                  setState(() {
                    _defaultCity = city;
                  });
                  SettingsService.setDefaultCity(
                    name: city.name,
                    lat: city.latitude,
                    lon: city.longitude,
                    region: city.region,
                    population: city.population,
                  );
                  widget.onDefaultCityChanged(city);
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
    );
  }

  void _clearDefaultCity() {
    setState(() {
      _defaultCity = null;
    });
    SettingsService.clearDefaultCity();
    widget.onDefaultCityChanged(null);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Налаштування',
          style: TextStyle(
            color: theme.appBarTheme.foregroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Temperature Unit Section
              _buildSectionTitle('Одиниця температури'),
              const SizedBox(height: 16),
              _buildTemperatureUnitCard(),
              const SizedBox(height: 32),

              // Default City Section
              _buildSectionTitle('Стандартне місто'),
              const SizedBox(height: 16),
              _buildDefaultCityCard(),
              const SizedBox(height: 32),

              // Theme Section
              _buildSectionTitle('Тема інтерфейсу'),
              const SizedBox(height: 16),
              _buildThemeCard(),
              const SizedBox(height: 32),

              // Current Date Section
              _buildSectionTitle('Поточна дата'),
              const SizedBox(height: 16),
              _buildCurrentDateCard(),
              const SizedBox(height: 32),

              // Logout Section
              _buildSectionTitle('Обліковий запис'),
              const SizedBox(height: 16),
              _buildLogoutCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeCard() {
    final theme = Theme.of(context);
    final themeProvider = ThemeProvider.of(context);
    final currentTheme = themeProvider?.themeMode ?? ThemeMode.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.dividerColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Оберіть тему інтерфейсу',
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 16,
              fontWeight: theme.brightness == Brightness.light
                  ? FontWeight.w600
                  : FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildThemeOption(
                  'Світла',
                  ThemeMode.light,
                  Icons.light_mode,
                  currentTheme == ThemeMode.light,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildThemeOption(
                  'Темна',
                  ThemeMode.dark,
                  Icons.dark_mode,
                  currentTheme == ThemeMode.dark,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildThemeOption(
                  'Системна',
                  ThemeMode.system,
                  Icons.brightness_auto,
                  currentTheme == ThemeMode.system,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(
    String title,
    ThemeMode mode,
    IconData icon,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () {
        final themeProvider = ThemeProvider.of(context);
        themeProvider?.onChangeTheme(mode);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.yellow : Colors.grey.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.yellow : Colors.grey.withValues(alpha: 0.3),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.black : Colors.white,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutCard() {
    final theme = Theme.of(context);
    final authBloc = serviceLocator.get<AuthBloc>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.dividerColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Вихід з облікового запису',
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 16,
              fontWeight: theme.brightness == Brightness.light
                  ? FontWeight.w600
                  : FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                authBloc.logout();
              },
              icon: const Icon(Icons.logout),
              label: const Text('Вийти'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    return Text(
      title,
      style: TextStyle(
        color: theme.colorScheme.onSurface,
        fontSize: 20,
        fontWeight: isLight ? FontWeight.w700 : FontWeight.bold,
      ),
    );
  }

  Widget _buildTemperatureUnitCard() {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.dividerColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Оберіть одиницю температури',
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 16,
              fontWeight: theme.brightness == Brightness.light
                  ? FontWeight.w600
                  : FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTemperatureOption(
                  'Цельсій (°C)',
                  true,
                  Icons.thermostat,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTemperatureOption(
                  'Фаренгейт (°F)',
                  false,
                  Icons.thermostat_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTemperatureOption(String title, bool isCelsius, IconData icon) {
    final isSelected = _isCelsius == isCelsius;

    return GestureDetector(
      onTap: () async {
        setState(() {
          _isCelsius = isCelsius;
        });
        await SettingsService.setTemperatureUnit(isCelsius);
        widget.onTemperatureUnitChanged(isCelsius);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.yellow : Colors.grey.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.yellow : Colors.grey.withValues(alpha: 0.3),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.black : Colors.white,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultCityCard() {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.dividerColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Місто, яке відкриватиметься автоматично',
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 16,
              fontWeight: theme.brightness == Brightness.light
                  ? FontWeight.w600
                  : FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          if (_defaultCity != null) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.yellow.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.yellow.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_city,
                    color: Colors.yellow,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _defaultCity!.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _defaultCity!.region,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: _clearDefaultCity,
                    icon: const Icon(Icons.close, color: Colors.red),
                  ),
                ],
              ),
            ),
          ] else ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.location_off, color: Colors.grey, size: 24),
                  SizedBox(width: 12),
                  Text(
                    'Стандартне місто не обрано',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _showCitySearchDialog,
              icon: const Icon(Icons.search),
              label: Text(
                _defaultCity != null ? 'Змінити місто' : 'Обрати місто',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentDateCard() {
    final theme = Theme.of(context);
    final now = DateTime.now();
    final formattedDate =
        '${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year}';
    final dayOfWeek = _getDayOfWeek(now.weekday);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Сьогоднішня дата',
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 16,
              fontWeight: theme.brightness == Brightness.light
                  ? FontWeight.w600
                  : FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.calendar_today, color: Colors.yellow, size: 32),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dayOfWeek,
                    style: TextStyle(
                      color: theme.colorScheme.onSurface,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    formattedDate,
                    style: TextStyle(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.yellow.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.yellow.withValues(alpha: 0.3)),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: Colors.yellow, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Додаток автоматично відкривається з поточною датою',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getDayOfWeek(int weekday) {
    const days = [
      'Понеділок',
      'Вівторок',
      'Середа',
      'Четвер',
      'П\'ятниця',
      'Субота',
      'Неділя',
    ];
    return days[weekday - 1];
  }
}
