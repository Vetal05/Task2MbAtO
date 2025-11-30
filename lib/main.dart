import 'package:flutter/material.dart';
import 'core/di/injection.dart';
import 'core/constants/app_constants.dart';
import 'core/services/settings_service.dart';
import 'core/services/api_key_service.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ініціалізуємо сервіс API ключів (завантажує з .env або безпечного сховища)
  await ApiKeyService.init();

  // Завантажуємо API ключі в AppConstants для синхронного доступу
  await AppConstants.initializeApiKeys();

  // Налаштовуємо залежності спочатку (потрібно для SettingsService)
  await configureDependencies();

  // Ініціалізуємо налаштування (потребує AuthRepository з service locator)
  await SettingsService.init();

  runApp(const WeatherNewsApp());
}

class WeatherNewsApp extends StatefulWidget {
  const WeatherNewsApp({super.key});

  @override
  State<WeatherNewsApp> createState() => _WeatherNewsAppState();
}

class _WeatherNewsAppState extends State<WeatherNewsApp> {
  final AuthBloc _authBloc = serviceLocator.get<AuthBloc>();
  ThemeMode _themeMode = ThemeMode.dark;

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
    _authBloc.addListener(_onAuthStateChanged);
    _authBloc.checkAuthStatus();
  }

  @override
  void dispose() {
    _authBloc.removeListener(_onAuthStateChanged);
    super.dispose();
  }

  Future<void> _loadThemeMode() async {
    final themeModeString = await SettingsService.getThemeMode();
    if (mounted) {
      setState(() {
        _themeMode =
            themeModeString == 'light'
                ? ThemeMode.light
                : themeModeString == 'system'
                ? ThemeMode.system
                : ThemeMode.dark;
      });
    }
  }

  void _onAuthStateChanged() {
    // Перезавантажуємо тему, коли користувач входить/виходить
    _loadThemeMode();
    setState(() {});
  }

  void _changeTheme(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
    SettingsService.setThemeMode(
      mode == ThemeMode.light
          ? 'light'
          : mode == ThemeMode.system
          ? 'system'
          : 'dark',
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = _authBloc.state;

    Widget homeWidget;
    if (authState is AuthAuthenticated) {
      homeWidget = const HomePage();
    } else if (authState is AuthUnauthenticated) {
      homeWidget = LoginPage(authBloc: _authBloc);
    } else {
      // Стан завантаження (AuthInitial або AuthLoading)
      homeWidget = Scaffold(
        backgroundColor: const Color(0xFF121212),
        body: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
          ),
        ),
      );
    }

    return MaterialApp(
      title: 'Weather & News App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade50,
          foregroundColor: Colors.blue.shade900,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.blue.shade900,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardTheme: CardTheme(
          color: Colors.grey.shade50,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          displayMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          displaySmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          headlineLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          headlineMedium: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          headlineSmall: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          titleLarge: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          titleMedium: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          titleSmall: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          bodyLarge: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          bodyMedium: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          bodySmall: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
          labelLarge: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          labelMedium: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          labelSmall: TextStyle(fontWeight: FontWeight.normal, fontSize: 11),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.yellow,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A1A1A),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          color: const Color(0xFF1A1A1A),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        dividerColor: Colors.grey.withOpacity(0.3),
      ),
      themeMode: _themeMode,
      home: homeWidget,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        if (child == null) {
          return const SizedBox();
        }
        return ThemeProvider(
          themeMode: _themeMode,
          onChangeTheme: _changeTheme,
          child: child,
        );
      },
    );
  }
}

class ThemeProvider extends InheritedWidget {
  final ThemeMode themeMode;
  final Function(ThemeMode) onChangeTheme;

  const ThemeProvider({
    super.key,
    required this.themeMode,
    required this.onChangeTheme,
    required super.child,
  });

  static ThemeProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
  }

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) {
    return themeMode != oldWidget.themeMode;
  }
}
