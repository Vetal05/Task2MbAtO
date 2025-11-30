import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

// Таблиця погоди
class WeatherCache extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get cityName => text()();
  TextColumn get country => text()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  IntColumn get weatherId => integer()();
  TextColumn get main => text()();
  TextColumn get description => text()();
  TextColumn get icon => text()();
  RealColumn get temperature => real()();
  RealColumn get feelsLike => real()();
  IntColumn get humidity => integer()();
  IntColumn get pressure => integer()();
  RealColumn get windSpeed => real()();
  IntColumn get windDirection => integer()();
  IntColumn get visibility => integer()();
  IntColumn get cloudiness => integer()();
  IntColumn get sunriseMs => integer()();
  IntColumn get sunsetMs => integer()();
  IntColumn get timestampMs => integer()();
  TextColumn get weatherJson => text()(); // Повний JSON для легкого перетворення
}

// Таблиця новин
class NewsCache extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get content => text()();
  TextColumn get url => text()();
  TextColumn get imageUrl => text().nullable()();
  IntColumn get publishedAtMs => integer()();
  TextColumn get source => text()();
  TextColumn get author => text().nullable()();
  TextColumn get category => text()();
  TextColumn get articleJson => text()(); // Повний JSON для легкого перетворення
  IntColumn get savedAtMs => integer()(); // Коли було збережено
  BoolColumn get isSaved => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

// Таблиця міст/локацій
class CitiesCache extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get country => text()();
  TextColumn get state => text().nullable()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  BoolColumn get isCurrentLocation =>
      boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [WeatherCache, NewsCache, CitiesCache])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // Конструктор для тестування з користувацькою базою даних
  AppDatabase.test(super.db);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Додати міграції тут, якщо потрібно
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'weather_news_app.db'));
    return NativeDatabase(file);
  });
}
