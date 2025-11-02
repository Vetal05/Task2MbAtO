import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

// Weather table
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
  TextColumn get weatherJson => text()(); // Full JSON for easy conversion
}

// News articles table
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
  TextColumn get articleJson => text()(); // Full JSON for easy conversion
  IntColumn get savedAtMs => integer()(); // When it was saved
  BoolColumn get isSaved => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

// Cities/Locations table
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

  // Constructor for testing with custom database
  AppDatabase.test(LazyDatabase db) : super(db);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Add migrations here if needed
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
