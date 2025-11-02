import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/ukraine_city.dart';
import '../../../../core/constants/app_constants.dart';

class OpenWeatherGeocodingService {
  static const String _baseUrl = 'http://api.openweathermap.org/geo/1.0/direct';

  /// Пошук населених пунктів за назвою через OpenWeatherMap Geocoding API
  static Future<List<UkraineCity>> searchLocations(String query) async {
    if (query.trim().isEmpty) {
      return [];
    }

    try {
      final uri = Uri.parse(_baseUrl).replace(
        queryParameters: {
          'q': '$query,UA', // Додаємо UA для пошуку в Україні
          'limit': '10', // Обмежуємо до 10 результатів
          'appid': AppConstants.openWeatherApiKey,
        },
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final List<UkraineCity> locations = [];

        for (final location in jsonData) {
          if (location is Map<String, dynamic>) {
            // Перевіряємо, що це Україна
            if (location['country'] == 'UA') {
              locations.add(
                UkraineCity(
                  name: _convertCityNameToUkrainian(location['name'] ?? ''),
                  region: _getRegionFromState(location['state']),
                  latitude: (location['lat'] as num?)?.toDouble() ?? 0.0,
                  longitude: (location['lon'] as num?)?.toDouble() ?? 0.0,
                  population: 0, // API не надає дані про населення
                ),
              );
            }
          }
        }

        return locations;
      } else {
        print('Geocoding API error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error searching locations: $e');
      return [];
    }
  }

  /// Конвертуємо назву області/штату в українську назву області
  static String _getRegionFromState(String? state) {
    if (state == null) return 'Україна';

    // Мапа англійських назв областей на українські
    const regionMap = {
      'Kyiv': 'Київська область',
      'Kharkiv': 'Харківська область',
      'Odessa': 'Одеська область',
      'Dnipropetrovsk': 'Дніпропетровська область',
      'Donetsk': 'Донецька область',
      'Zaporizhzhia': 'Запорізька область',
      'Lviv': 'Львівська область',
      'Mykolaiv': 'Миколаївська область',
      'Vinnytsia': 'Вінницька область',
      'Kherson': 'Херсонська область',
      'Poltava': 'Полтавська область',
      'Chernihiv': 'Чернігівська область',
      'Cherkasy': 'Черкаська область',
      'Zhytomyr': 'Житомирська область',
      'Sumy': 'Сумська область',
      'Khmelnytskyi': 'Хмельницька область',
      'Chernivtsi': 'Чернівецька область',
      'Rivne': 'Рівненська область',
      'Kirovohrad': 'Кіровоградська область',
      'Ivano-Frankivsk': 'Івано-Франківська область',
      'Ternopil': 'Тернопільська область',
      'Volyn': 'Волинська область',
      'Crimea': 'Автономна Республіка Крим',
      'Luhansk': 'Луганська область',
    };

    return regionMap[state] ?? state;
  }

  /// Конвертуємо назву міста з латиниці на українську
  static String _convertCityNameToUkrainian(String latinName) {
    // Спочатку перевіряємо точну відповідність
    const cityMap = {
      // Великі міста
      'Kyiv': 'Київ',
      'Kharkiv': 'Харків',
      'Odessa': 'Одеса',
      'Dnipro': 'Дніпро',
      'Donetsk': 'Донецьк',
      'Zaporizhzhia': 'Запоріжжя',
      'Lviv': 'Львів',
      'Kryvyi Rih': 'Кривий Ріг',
      'Mykolaiv': 'Миколаїв',
      'Mariupol': 'Маріуполь',
      'Vinnytsia': 'Вінниця',
      'Kherson': 'Херсон',
      'Poltava': 'Полтава',
      'Chernihiv': 'Чернігів',
      'Cherkasy': 'Черкаси',
      'Zhytomyr': 'Житомир',
      'Sumy': 'Суми',
      'Khmelnytskyi': 'Хмельницький',
      'Chernivtsi': 'Чернівці',
      'Rivne': 'Рівне',
      'Kropyvnytskyi': 'Кропивницький',
      'Ivano-Frankivsk': 'Івано-Франківськ',
      'Kremenchuk': 'Кременчук',
      'Ternopil': 'Тернопіль',
      'Lutsk': 'Луцьк',
      'Bila Tserkva': 'Біла Церква',
      'Kramatorsk': 'Краматорськ',
      'Melitopol': 'Мелітополь',
      'Kerch': 'Керч',
      'Simferopol': 'Сімферополь',
      'Uzhhorod': 'Ужгород',
      'Mukachevo': 'Мукачево',
      'Kovel': 'Ковель',
      'Kolomyia': 'Коломия',
      'Stryi': 'Стрий',
      'Drohobych': 'Дрогобич',
      'Berdychiv': 'Бердичів',
      'Korosten': 'Коростень',
      'Shostka': 'Шостка',
      'Konotop': 'Конотоп',
      'Romny': 'Ромни',
      'Okhtyrka': 'Охтирка',
      'Lubny': 'Лубни',
      'Mirhorod': 'Миргород',
      'Hadiach': 'Гадяч',
      'Nizhyn': 'Ніжин',
      'Pryluky': 'Прилуки',
      'Bakhmach': 'Бахмач',
      'Novhorod-Siverskyi': 'Новгород-Сіверський',
      'Smila': 'Сміла',
      'Uman': 'Умань',
      'Zolotonosha': 'Золотоноша',
      'Kaniv': 'Канів',
      'Zvenyhorodka': 'Звенигородка',
      'Shpola': 'Шпола',
      'Vasylkiv': 'Васильків',
      'Irpin': 'Ірпінь',
      'Bucha': 'Буча',
      'Vyshhorod': 'Вишгород',
      'Obukhiv': 'Обухів',
      'Skvyra': 'Сквира',
      'Fastiv': 'Фастів',
      'Pereiaslav': 'Переяслав',
      'Slavutych': 'Славутич',
      'Yahotyn': 'Яготин',
      'Tarascha': 'Тараща',
      'Rzhyshchiv': 'Ржищів',
      'Kaharlyk': 'Кагарлик',
      'Myronivka': 'Миронівка',
      'Bohuslav': 'Богуслав',
      'Volodarka': 'Володарка',
      'Ivankiv': 'Іванків',
      'Poliske': 'Поліське',
      'Makariv': 'Макарів',
      'Borodianka': 'Бородянка',
      'Hostomel': 'Гостомель',
      'Vyshneve': 'Вишневе',
      'Boyarka': 'Боярка',
      'Kotsiubynske': 'Коцюбинське',
      'Horenka': 'Горенка',
      'Dmytrivka': 'Дмитрівка',
      'Novi Petrivtsi': 'Нові Петрівці',
      'Kozyn': 'Козин',
      'Hnidyn': 'Гнідин',
      'Kopachiv': 'Копачів',
      'Kozhanka': 'Кожанка',
      'Rokytne': 'Рокитне',
      // Популярні села та селища
      'Lelyukivka': 'Лелюхівка',
      'Novi Sanzhary': 'Нові Санжари',
      'Bilohorodka': 'Білогородка',
      'Zachepylivka': 'Зачепилівка',
    };

    // Спочатку перевіряємо точну відповідність
    if (cityMap.containsKey(latinName)) {
      return cityMap[latinName]!;
    }

    // Якщо точного збігу немає, намагаємося автоматично перекласти
    return _autoTranslateToUkrainian(latinName);
  }

  /// Автоматичний переклад з латиниці на українську
  static String _autoTranslateToUkrainian(String latinName) {
    // Мапа загальних правил транслитерації
    const transliterationMap = {
      'a': 'а',
      'b': 'б',
      'v': 'в',
      'g': 'г',
      'd': 'д',
      'e': 'е',
      'zh': 'ж',
      'z': 'з',
      'i': 'і',
      'y': 'й',
      'k': 'к',
      'l': 'л',
      'm': 'м',
      'n': 'н',
      'o': 'о',
      'p': 'п',
      'r': 'р',
      's': 'с',
      't': 'т',
      'u': 'у',
      'f': 'ф',
      'h': 'х',
      'ts': 'ц',
      'ch': 'ч',
      'sh': 'ш',
      'sch': 'щ',
      'yu': 'ю',
      'ya': 'я',
      'A': 'А',
      'B': 'Б',
      'V': 'В',
      'G': 'Г',
      'D': 'Д',
      'E': 'Е',
      'Zh': 'Ж',
      'Z': 'З',
      'I': 'І',
      'Y': 'Й',
      'K': 'К',
      'L': 'Л',
      'M': 'М',
      'N': 'Н',
      'O': 'О',
      'P': 'П',
      'R': 'Р',
      'S': 'С',
      'T': 'Т',
      'U': 'У',
      'F': 'Ф',
      'H': 'Х',
      'Ts': 'Ц',
      'Ch': 'Ч',
      'Sh': 'Ш',
      'Sch': 'Щ',
      'Yu': 'Ю',
      'Ya': 'Я',
    };

    String result = latinName;

    // Спочатку замінюємо складні сполучення
    result = result.replaceAll('sch', 'щ');
    result = result.replaceAll('Sch', 'Щ');
    result = result.replaceAll('SCH', 'Щ');

    result = result.replaceAll('zh', 'ж');
    result = result.replaceAll('Zh', 'Ж');
    result = result.replaceAll('ZH', 'Ж');

    result = result.replaceAll('ch', 'ч');
    result = result.replaceAll('Ch', 'Ч');
    result = result.replaceAll('CH', 'Ч');

    result = result.replaceAll('sh', 'ш');
    result = result.replaceAll('Sh', 'Ш');
    result = result.replaceAll('SH', 'Ш');

    result = result.replaceAll('ts', 'ц');
    result = result.replaceAll('Ts', 'Ц');
    result = result.replaceAll('TS', 'Ц');

    result = result.replaceAll('yu', 'ю');
    result = result.replaceAll('Yu', 'Ю');
    result = result.replaceAll('YU', 'Ю');

    result = result.replaceAll('ya', 'я');
    result = result.replaceAll('Ya', 'Я');
    result = result.replaceAll('YA', 'Я');

    // Потім замінюємо окремі літери
    for (final entry in transliterationMap.entries) {
      if (entry.key.length == 1) {
        result = result.replaceAll(entry.key, entry.value);
      }
    }

    return result;
  }

  /// Отримати координати для конкретного міста
  static Future<UkraineCity?> getLocationCoordinates(String cityName) async {
    final locations = await searchLocations(cityName);
    if (locations.isNotEmpty) {
      return locations.first;
    }
    return null;
  }
}
