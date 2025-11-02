import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/ukraine_city.dart';

class UkraineCitiesApiService {
  // Використовуємо локальний розширений список, оскільки API недоступний
  static const String _gistUrl =
      'https://raw.githubusercontent.com/maximgrynykha/ukraine-cities/main/ukraine-cities.json';

  /// Завантажити всі міста України з GitHub Gist
  static Future<List<UkraineCity>> getAllCitiesFromApi() async {
    try {
      final response = await http.get(Uri.parse(_gistUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<UkraineCity> cities = [];

        // Парсимо дані з JSON
        if (jsonData is Map<String, dynamic>) {
          jsonData.forEach((regionName, regionData) {
            if (regionData is Map<String, dynamic>) {
              // Додаємо обласний центр
              if (regionData['center'] != null) {
                final center = regionData['center'];
                cities.add(
                  UkraineCity(
                    name: center['name'] ?? '',
                    region: regionName,
                    latitude: _parseCoordinate(center['lat']),
                    longitude: _parseCoordinate(center['lng']),
                    population: _parsePopulation(center['population']),
                  ),
                );
              }

              // Додаємо міста області
              if (regionData['cities'] is List) {
                for (final cityData in regionData['cities']) {
                  if (cityData is Map<String, dynamic>) {
                    cities.add(
                      UkraineCity(
                        name: cityData['name'] ?? '',
                        region: regionName,
                        latitude: _parseCoordinate(cityData['lat']),
                        longitude: _parseCoordinate(cityData['lng']),
                        population: _parsePopulation(cityData['population']),
                      ),
                    );
                  }
                }
              }
            }
          });
        }

        return cities;
      } else {
        throw Exception('Failed to load cities: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading cities from API: $e');
      // Повертаємо локальний список як fallback
      return _getLocalCities();
    }
  }

  /// Парсинг координат
  static double _parseCoordinate(dynamic coord) {
    if (coord is num) return coord.toDouble();
    if (coord is String) return double.tryParse(coord) ?? 0.0;
    return 0.0;
  }

  /// Парсинг населення
  static int _parsePopulation(dynamic population) {
    if (population is int) return population;
    if (population is String) return int.tryParse(population) ?? 0;
    return 0;
  }

  /// Розширений локальний список міст, сіл та селищ
  static List<UkraineCity> _getLocalCities() {
    return [
      UkraineCity(
        name: 'Київ',
        region: 'Київська область',
        latitude: 50.4501,
        longitude: 30.5234,
        population: 2967360,
      ),
      UkraineCity(
        name: 'Харків',
        region: 'Харківська область',
        latitude: 49.9935,
        longitude: 36.2304,
        population: 1443207,
      ),
      UkraineCity(
        name: 'Одеса',
        region: 'Одеська область',
        latitude: 46.4825,
        longitude: 30.7233,
        population: 1017699,
      ),
      UkraineCity(
        name: 'Дніпро',
        region: 'Дніпропетровська область',
        latitude: 48.4647,
        longitude: 35.0462,
        population: 980948,
      ),
      UkraineCity(
        name: 'Донецьк',
        region: 'Донецька область',
        latitude: 48.0159,
        longitude: 37.8028,
        population: 901645,
      ),
      UkraineCity(
        name: 'Запоріжжя',
        region: 'Запорізька область',
        latitude: 47.8388,
        longitude: 35.1396,
        population: 722713,
      ),
      UkraineCity(
        name: 'Львів',
        region: 'Львівська область',
        latitude: 49.8397,
        longitude: 24.0297,
        population: 717273,
      ),
      UkraineCity(
        name: 'Кривий Ріг',
        region: 'Дніпропетровська область',
        latitude: 47.9105,
        longitude: 33.3918,
        population: 612750,
      ),
      UkraineCity(
        name: 'Миколаїв',
        region: 'Миколаївська область',
        latitude: 46.9750,
        longitude: 31.9946,
        population: 476101,
      ),
      UkraineCity(
        name: 'Маріуполь',
        region: 'Донецька область',
        latitude: 47.0971,
        longitude: 37.5434,
        population: 431859,
      ),
      UkraineCity(
        name: 'Вінниця',
        region: 'Вінницька область',
        latitude: 49.2331,
        longitude: 28.4682,
        population: 370601,
      ),
      UkraineCity(
        name: 'Херсон',
        region: 'Херсонська область',
        latitude: 46.6354,
        longitude: 32.6169,
        population: 283649,
      ),
      UkraineCity(
        name: 'Полтава',
        region: 'Полтавська область',
        latitude: 49.5883,
        longitude: 34.5514,
        population: 284942,
      ),
      UkraineCity(
        name: 'Чернігів',
        region: 'Чернігівська область',
        latitude: 51.4982,
        longitude: 31.2893,
        population: 285234,
      ),
      UkraineCity(
        name: 'Черкаси',
        region: 'Черкаська область',
        latitude: 49.4444,
        longitude: 32.0598,
        population: 269836,
      ),
      UkraineCity(
        name: 'Житомир',
        region: 'Житомирська область',
        latitude: 50.2547,
        longitude: 28.6587,
        population: 264452,
      ),
      UkraineCity(
        name: 'Суми',
        region: 'Сумська область',
        latitude: 50.9077,
        longitude: 34.7981,
        population: 256474,
      ),
      UkraineCity(
        name: 'Хмельницький',
        region: 'Хмельницька область',
        latitude: 49.4220,
        longitude: 26.9965,
        population: 274582,
      ),
      UkraineCity(
        name: 'Чернівці',
        region: 'Чернівецька область',
        latitude: 48.2917,
        longitude: 25.9352,
        population: 264298,
      ),
      UkraineCity(
        name: 'Рівне',
        region: 'Рівненська область',
        latitude: 50.6199,
        longitude: 26.2516,
        population: 245289,
      ),
      UkraineCity(
        name: 'Кропивницький',
        region: 'Кіровоградська область',
        latitude: 48.5132,
        longitude: 32.2597,
        population: 227413,
      ),
      UkraineCity(
        name: 'Івано-Франківськ',
        region: 'Івано-Франківська область',
        latitude: 48.9226,
        longitude: 24.7111,
        population: 238196,
      ),
      UkraineCity(
        name: 'Кременчук',
        region: 'Полтавська область',
        latitude: 49.0685,
        longitude: 33.4104,
        population: 217710,
      ),
      UkraineCity(
        name: 'Тернопіль',
        region: 'Тернопільська область',
        latitude: 49.5535,
        longitude: 25.5948,
        population: 223462,
      ),
      UkraineCity(
        name: 'Луцьк',
        region: 'Волинська область',
        latitude: 50.7472,
        longitude: 25.3254,
        population: 217103,
      ),
      UkraineCity(
        name: 'Біла Церква',
        region: 'Київська область',
        latitude: 49.7969,
        longitude: 30.1125,
        population: 208944,
      ),
      UkraineCity(
        name: 'Краматорськ',
        region: 'Донецька область',
        latitude: 48.7389,
        longitude: 37.5839,
        population: 150084,
      ),
      UkraineCity(
        name: 'Мелітополь',
        region: 'Запорізька область',
        latitude: 46.8489,
        longitude: 35.3653,
        population: 150768,
      ),
      UkraineCity(
        name: 'Керч',
        region: 'Автономна Республіка Крим',
        latitude: 45.3607,
        longitude: 36.4706,
        population: 149566,
      ),
      UkraineCity(
        name: 'Сімферополь',
        region: 'Автономна Республіка Крим',
        latitude: 44.9521,
        longitude: 34.1024,
        population: 332317,
      ),
    ];
  }
}
