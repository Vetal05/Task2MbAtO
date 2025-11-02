// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $WeatherCacheTable extends WeatherCache
    with TableInfo<$WeatherCacheTable, WeatherCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeatherCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _cityNameMeta = const VerificationMeta(
    'cityName',
  );
  @override
  late final GeneratedColumn<String> cityName = GeneratedColumn<String>(
    'city_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weatherIdMeta = const VerificationMeta(
    'weatherId',
  );
  @override
  late final GeneratedColumn<int> weatherId = GeneratedColumn<int>(
    'weather_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mainMeta = const VerificationMeta('main');
  @override
  late final GeneratedColumn<String> main = GeneratedColumn<String>(
    'main',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _temperatureMeta = const VerificationMeta(
    'temperature',
  );
  @override
  late final GeneratedColumn<double> temperature = GeneratedColumn<double>(
    'temperature',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _feelsLikeMeta = const VerificationMeta(
    'feelsLike',
  );
  @override
  late final GeneratedColumn<double> feelsLike = GeneratedColumn<double>(
    'feels_like',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _humidityMeta = const VerificationMeta(
    'humidity',
  );
  @override
  late final GeneratedColumn<int> humidity = GeneratedColumn<int>(
    'humidity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pressureMeta = const VerificationMeta(
    'pressure',
  );
  @override
  late final GeneratedColumn<int> pressure = GeneratedColumn<int>(
    'pressure',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _windSpeedMeta = const VerificationMeta(
    'windSpeed',
  );
  @override
  late final GeneratedColumn<double> windSpeed = GeneratedColumn<double>(
    'wind_speed',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _windDirectionMeta = const VerificationMeta(
    'windDirection',
  );
  @override
  late final GeneratedColumn<int> windDirection = GeneratedColumn<int>(
    'wind_direction',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _visibilityMeta = const VerificationMeta(
    'visibility',
  );
  @override
  late final GeneratedColumn<int> visibility = GeneratedColumn<int>(
    'visibility',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cloudinessMeta = const VerificationMeta(
    'cloudiness',
  );
  @override
  late final GeneratedColumn<int> cloudiness = GeneratedColumn<int>(
    'cloudiness',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sunriseMsMeta = const VerificationMeta(
    'sunriseMs',
  );
  @override
  late final GeneratedColumn<int> sunriseMs = GeneratedColumn<int>(
    'sunrise_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sunsetMsMeta = const VerificationMeta(
    'sunsetMs',
  );
  @override
  late final GeneratedColumn<int> sunsetMs = GeneratedColumn<int>(
    'sunset_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMsMeta = const VerificationMeta(
    'timestampMs',
  );
  @override
  late final GeneratedColumn<int> timestampMs = GeneratedColumn<int>(
    'timestamp_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weatherJsonMeta = const VerificationMeta(
    'weatherJson',
  );
  @override
  late final GeneratedColumn<String> weatherJson = GeneratedColumn<String>(
    'weather_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cityName,
    country,
    latitude,
    longitude,
    weatherId,
    main,
    description,
    icon,
    temperature,
    feelsLike,
    humidity,
    pressure,
    windSpeed,
    windDirection,
    visibility,
    cloudiness,
    sunriseMs,
    sunsetMs,
    timestampMs,
    weatherJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weather_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeatherCacheData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('city_name')) {
      context.handle(
        _cityNameMeta,
        cityName.isAcceptableOrUnknown(data['city_name']!, _cityNameMeta),
      );
    } else if (isInserting) {
      context.missing(_cityNameMeta);
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    } else if (isInserting) {
      context.missing(_countryMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('weather_id')) {
      context.handle(
        _weatherIdMeta,
        weatherId.isAcceptableOrUnknown(data['weather_id']!, _weatherIdMeta),
      );
    } else if (isInserting) {
      context.missing(_weatherIdMeta);
    }
    if (data.containsKey('main')) {
      context.handle(
        _mainMeta,
        main.isAcceptableOrUnknown(data['main']!, _mainMeta),
      );
    } else if (isInserting) {
      context.missing(_mainMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('temperature')) {
      context.handle(
        _temperatureMeta,
        temperature.isAcceptableOrUnknown(
          data['temperature']!,
          _temperatureMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_temperatureMeta);
    }
    if (data.containsKey('feels_like')) {
      context.handle(
        _feelsLikeMeta,
        feelsLike.isAcceptableOrUnknown(data['feels_like']!, _feelsLikeMeta),
      );
    } else if (isInserting) {
      context.missing(_feelsLikeMeta);
    }
    if (data.containsKey('humidity')) {
      context.handle(
        _humidityMeta,
        humidity.isAcceptableOrUnknown(data['humidity']!, _humidityMeta),
      );
    } else if (isInserting) {
      context.missing(_humidityMeta);
    }
    if (data.containsKey('pressure')) {
      context.handle(
        _pressureMeta,
        pressure.isAcceptableOrUnknown(data['pressure']!, _pressureMeta),
      );
    } else if (isInserting) {
      context.missing(_pressureMeta);
    }
    if (data.containsKey('wind_speed')) {
      context.handle(
        _windSpeedMeta,
        windSpeed.isAcceptableOrUnknown(data['wind_speed']!, _windSpeedMeta),
      );
    } else if (isInserting) {
      context.missing(_windSpeedMeta);
    }
    if (data.containsKey('wind_direction')) {
      context.handle(
        _windDirectionMeta,
        windDirection.isAcceptableOrUnknown(
          data['wind_direction']!,
          _windDirectionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_windDirectionMeta);
    }
    if (data.containsKey('visibility')) {
      context.handle(
        _visibilityMeta,
        visibility.isAcceptableOrUnknown(data['visibility']!, _visibilityMeta),
      );
    } else if (isInserting) {
      context.missing(_visibilityMeta);
    }
    if (data.containsKey('cloudiness')) {
      context.handle(
        _cloudinessMeta,
        cloudiness.isAcceptableOrUnknown(data['cloudiness']!, _cloudinessMeta),
      );
    } else if (isInserting) {
      context.missing(_cloudinessMeta);
    }
    if (data.containsKey('sunrise_ms')) {
      context.handle(
        _sunriseMsMeta,
        sunriseMs.isAcceptableOrUnknown(data['sunrise_ms']!, _sunriseMsMeta),
      );
    } else if (isInserting) {
      context.missing(_sunriseMsMeta);
    }
    if (data.containsKey('sunset_ms')) {
      context.handle(
        _sunsetMsMeta,
        sunsetMs.isAcceptableOrUnknown(data['sunset_ms']!, _sunsetMsMeta),
      );
    } else if (isInserting) {
      context.missing(_sunsetMsMeta);
    }
    if (data.containsKey('timestamp_ms')) {
      context.handle(
        _timestampMsMeta,
        timestampMs.isAcceptableOrUnknown(
          data['timestamp_ms']!,
          _timestampMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timestampMsMeta);
    }
    if (data.containsKey('weather_json')) {
      context.handle(
        _weatherJsonMeta,
        weatherJson.isAcceptableOrUnknown(
          data['weather_json']!,
          _weatherJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_weatherJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeatherCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeatherCacheData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      cityName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}city_name'],
          )!,
      country:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}country'],
          )!,
      latitude:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}latitude'],
          )!,
      longitude:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}longitude'],
          )!,
      weatherId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}weather_id'],
          )!,
      main:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}main'],
          )!,
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
      icon:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}icon'],
          )!,
      temperature:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}temperature'],
          )!,
      feelsLike:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}feels_like'],
          )!,
      humidity:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}humidity'],
          )!,
      pressure:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}pressure'],
          )!,
      windSpeed:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}wind_speed'],
          )!,
      windDirection:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}wind_direction'],
          )!,
      visibility:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}visibility'],
          )!,
      cloudiness:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}cloudiness'],
          )!,
      sunriseMs:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}sunrise_ms'],
          )!,
      sunsetMs:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}sunset_ms'],
          )!,
      timestampMs:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}timestamp_ms'],
          )!,
      weatherJson:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}weather_json'],
          )!,
    );
  }

  @override
  $WeatherCacheTable createAlias(String alias) {
    return $WeatherCacheTable(attachedDatabase, alias);
  }
}

class WeatherCacheData extends DataClass
    implements Insertable<WeatherCacheData> {
  final int id;
  final String cityName;
  final String country;
  final double latitude;
  final double longitude;
  final int weatherId;
  final String main;
  final String description;
  final String icon;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final int pressure;
  final double windSpeed;
  final int windDirection;
  final int visibility;
  final int cloudiness;
  final int sunriseMs;
  final int sunsetMs;
  final int timestampMs;
  final String weatherJson;
  const WeatherCacheData({
    required this.id,
    required this.cityName,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.weatherId,
    required this.main,
    required this.description,
    required this.icon,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.windDirection,
    required this.visibility,
    required this.cloudiness,
    required this.sunriseMs,
    required this.sunsetMs,
    required this.timestampMs,
    required this.weatherJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['city_name'] = Variable<String>(cityName);
    map['country'] = Variable<String>(country);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['weather_id'] = Variable<int>(weatherId);
    map['main'] = Variable<String>(main);
    map['description'] = Variable<String>(description);
    map['icon'] = Variable<String>(icon);
    map['temperature'] = Variable<double>(temperature);
    map['feels_like'] = Variable<double>(feelsLike);
    map['humidity'] = Variable<int>(humidity);
    map['pressure'] = Variable<int>(pressure);
    map['wind_speed'] = Variable<double>(windSpeed);
    map['wind_direction'] = Variable<int>(windDirection);
    map['visibility'] = Variable<int>(visibility);
    map['cloudiness'] = Variable<int>(cloudiness);
    map['sunrise_ms'] = Variable<int>(sunriseMs);
    map['sunset_ms'] = Variable<int>(sunsetMs);
    map['timestamp_ms'] = Variable<int>(timestampMs);
    map['weather_json'] = Variable<String>(weatherJson);
    return map;
  }

  WeatherCacheCompanion toCompanion(bool nullToAbsent) {
    return WeatherCacheCompanion(
      id: Value(id),
      cityName: Value(cityName),
      country: Value(country),
      latitude: Value(latitude),
      longitude: Value(longitude),
      weatherId: Value(weatherId),
      main: Value(main),
      description: Value(description),
      icon: Value(icon),
      temperature: Value(temperature),
      feelsLike: Value(feelsLike),
      humidity: Value(humidity),
      pressure: Value(pressure),
      windSpeed: Value(windSpeed),
      windDirection: Value(windDirection),
      visibility: Value(visibility),
      cloudiness: Value(cloudiness),
      sunriseMs: Value(sunriseMs),
      sunsetMs: Value(sunsetMs),
      timestampMs: Value(timestampMs),
      weatherJson: Value(weatherJson),
    );
  }

  factory WeatherCacheData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeatherCacheData(
      id: serializer.fromJson<int>(json['id']),
      cityName: serializer.fromJson<String>(json['cityName']),
      country: serializer.fromJson<String>(json['country']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      weatherId: serializer.fromJson<int>(json['weatherId']),
      main: serializer.fromJson<String>(json['main']),
      description: serializer.fromJson<String>(json['description']),
      icon: serializer.fromJson<String>(json['icon']),
      temperature: serializer.fromJson<double>(json['temperature']),
      feelsLike: serializer.fromJson<double>(json['feelsLike']),
      humidity: serializer.fromJson<int>(json['humidity']),
      pressure: serializer.fromJson<int>(json['pressure']),
      windSpeed: serializer.fromJson<double>(json['windSpeed']),
      windDirection: serializer.fromJson<int>(json['windDirection']),
      visibility: serializer.fromJson<int>(json['visibility']),
      cloudiness: serializer.fromJson<int>(json['cloudiness']),
      sunriseMs: serializer.fromJson<int>(json['sunriseMs']),
      sunsetMs: serializer.fromJson<int>(json['sunsetMs']),
      timestampMs: serializer.fromJson<int>(json['timestampMs']),
      weatherJson: serializer.fromJson<String>(json['weatherJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cityName': serializer.toJson<String>(cityName),
      'country': serializer.toJson<String>(country),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'weatherId': serializer.toJson<int>(weatherId),
      'main': serializer.toJson<String>(main),
      'description': serializer.toJson<String>(description),
      'icon': serializer.toJson<String>(icon),
      'temperature': serializer.toJson<double>(temperature),
      'feelsLike': serializer.toJson<double>(feelsLike),
      'humidity': serializer.toJson<int>(humidity),
      'pressure': serializer.toJson<int>(pressure),
      'windSpeed': serializer.toJson<double>(windSpeed),
      'windDirection': serializer.toJson<int>(windDirection),
      'visibility': serializer.toJson<int>(visibility),
      'cloudiness': serializer.toJson<int>(cloudiness),
      'sunriseMs': serializer.toJson<int>(sunriseMs),
      'sunsetMs': serializer.toJson<int>(sunsetMs),
      'timestampMs': serializer.toJson<int>(timestampMs),
      'weatherJson': serializer.toJson<String>(weatherJson),
    };
  }

  WeatherCacheData copyWith({
    int? id,
    String? cityName,
    String? country,
    double? latitude,
    double? longitude,
    int? weatherId,
    String? main,
    String? description,
    String? icon,
    double? temperature,
    double? feelsLike,
    int? humidity,
    int? pressure,
    double? windSpeed,
    int? windDirection,
    int? visibility,
    int? cloudiness,
    int? sunriseMs,
    int? sunsetMs,
    int? timestampMs,
    String? weatherJson,
  }) => WeatherCacheData(
    id: id ?? this.id,
    cityName: cityName ?? this.cityName,
    country: country ?? this.country,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    weatherId: weatherId ?? this.weatherId,
    main: main ?? this.main,
    description: description ?? this.description,
    icon: icon ?? this.icon,
    temperature: temperature ?? this.temperature,
    feelsLike: feelsLike ?? this.feelsLike,
    humidity: humidity ?? this.humidity,
    pressure: pressure ?? this.pressure,
    windSpeed: windSpeed ?? this.windSpeed,
    windDirection: windDirection ?? this.windDirection,
    visibility: visibility ?? this.visibility,
    cloudiness: cloudiness ?? this.cloudiness,
    sunriseMs: sunriseMs ?? this.sunriseMs,
    sunsetMs: sunsetMs ?? this.sunsetMs,
    timestampMs: timestampMs ?? this.timestampMs,
    weatherJson: weatherJson ?? this.weatherJson,
  );
  WeatherCacheData copyWithCompanion(WeatherCacheCompanion data) {
    return WeatherCacheData(
      id: data.id.present ? data.id.value : this.id,
      cityName: data.cityName.present ? data.cityName.value : this.cityName,
      country: data.country.present ? data.country.value : this.country,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      weatherId: data.weatherId.present ? data.weatherId.value : this.weatherId,
      main: data.main.present ? data.main.value : this.main,
      description:
          data.description.present ? data.description.value : this.description,
      icon: data.icon.present ? data.icon.value : this.icon,
      temperature:
          data.temperature.present ? data.temperature.value : this.temperature,
      feelsLike: data.feelsLike.present ? data.feelsLike.value : this.feelsLike,
      humidity: data.humidity.present ? data.humidity.value : this.humidity,
      pressure: data.pressure.present ? data.pressure.value : this.pressure,
      windSpeed: data.windSpeed.present ? data.windSpeed.value : this.windSpeed,
      windDirection:
          data.windDirection.present
              ? data.windDirection.value
              : this.windDirection,
      visibility:
          data.visibility.present ? data.visibility.value : this.visibility,
      cloudiness:
          data.cloudiness.present ? data.cloudiness.value : this.cloudiness,
      sunriseMs: data.sunriseMs.present ? data.sunriseMs.value : this.sunriseMs,
      sunsetMs: data.sunsetMs.present ? data.sunsetMs.value : this.sunsetMs,
      timestampMs:
          data.timestampMs.present ? data.timestampMs.value : this.timestampMs,
      weatherJson:
          data.weatherJson.present ? data.weatherJson.value : this.weatherJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeatherCacheData(')
          ..write('id: $id, ')
          ..write('cityName: $cityName, ')
          ..write('country: $country, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('weatherId: $weatherId, ')
          ..write('main: $main, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('temperature: $temperature, ')
          ..write('feelsLike: $feelsLike, ')
          ..write('humidity: $humidity, ')
          ..write('pressure: $pressure, ')
          ..write('windSpeed: $windSpeed, ')
          ..write('windDirection: $windDirection, ')
          ..write('visibility: $visibility, ')
          ..write('cloudiness: $cloudiness, ')
          ..write('sunriseMs: $sunriseMs, ')
          ..write('sunsetMs: $sunsetMs, ')
          ..write('timestampMs: $timestampMs, ')
          ..write('weatherJson: $weatherJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    cityName,
    country,
    latitude,
    longitude,
    weatherId,
    main,
    description,
    icon,
    temperature,
    feelsLike,
    humidity,
    pressure,
    windSpeed,
    windDirection,
    visibility,
    cloudiness,
    sunriseMs,
    sunsetMs,
    timestampMs,
    weatherJson,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeatherCacheData &&
          other.id == this.id &&
          other.cityName == this.cityName &&
          other.country == this.country &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.weatherId == this.weatherId &&
          other.main == this.main &&
          other.description == this.description &&
          other.icon == this.icon &&
          other.temperature == this.temperature &&
          other.feelsLike == this.feelsLike &&
          other.humidity == this.humidity &&
          other.pressure == this.pressure &&
          other.windSpeed == this.windSpeed &&
          other.windDirection == this.windDirection &&
          other.visibility == this.visibility &&
          other.cloudiness == this.cloudiness &&
          other.sunriseMs == this.sunriseMs &&
          other.sunsetMs == this.sunsetMs &&
          other.timestampMs == this.timestampMs &&
          other.weatherJson == this.weatherJson);
}

class WeatherCacheCompanion extends UpdateCompanion<WeatherCacheData> {
  final Value<int> id;
  final Value<String> cityName;
  final Value<String> country;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<int> weatherId;
  final Value<String> main;
  final Value<String> description;
  final Value<String> icon;
  final Value<double> temperature;
  final Value<double> feelsLike;
  final Value<int> humidity;
  final Value<int> pressure;
  final Value<double> windSpeed;
  final Value<int> windDirection;
  final Value<int> visibility;
  final Value<int> cloudiness;
  final Value<int> sunriseMs;
  final Value<int> sunsetMs;
  final Value<int> timestampMs;
  final Value<String> weatherJson;
  const WeatherCacheCompanion({
    this.id = const Value.absent(),
    this.cityName = const Value.absent(),
    this.country = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.weatherId = const Value.absent(),
    this.main = const Value.absent(),
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    this.temperature = const Value.absent(),
    this.feelsLike = const Value.absent(),
    this.humidity = const Value.absent(),
    this.pressure = const Value.absent(),
    this.windSpeed = const Value.absent(),
    this.windDirection = const Value.absent(),
    this.visibility = const Value.absent(),
    this.cloudiness = const Value.absent(),
    this.sunriseMs = const Value.absent(),
    this.sunsetMs = const Value.absent(),
    this.timestampMs = const Value.absent(),
    this.weatherJson = const Value.absent(),
  });
  WeatherCacheCompanion.insert({
    this.id = const Value.absent(),
    required String cityName,
    required String country,
    required double latitude,
    required double longitude,
    required int weatherId,
    required String main,
    required String description,
    required String icon,
    required double temperature,
    required double feelsLike,
    required int humidity,
    required int pressure,
    required double windSpeed,
    required int windDirection,
    required int visibility,
    required int cloudiness,
    required int sunriseMs,
    required int sunsetMs,
    required int timestampMs,
    required String weatherJson,
  }) : cityName = Value(cityName),
       country = Value(country),
       latitude = Value(latitude),
       longitude = Value(longitude),
       weatherId = Value(weatherId),
       main = Value(main),
       description = Value(description),
       icon = Value(icon),
       temperature = Value(temperature),
       feelsLike = Value(feelsLike),
       humidity = Value(humidity),
       pressure = Value(pressure),
       windSpeed = Value(windSpeed),
       windDirection = Value(windDirection),
       visibility = Value(visibility),
       cloudiness = Value(cloudiness),
       sunriseMs = Value(sunriseMs),
       sunsetMs = Value(sunsetMs),
       timestampMs = Value(timestampMs),
       weatherJson = Value(weatherJson);
  static Insertable<WeatherCacheData> custom({
    Expression<int>? id,
    Expression<String>? cityName,
    Expression<String>? country,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<int>? weatherId,
    Expression<String>? main,
    Expression<String>? description,
    Expression<String>? icon,
    Expression<double>? temperature,
    Expression<double>? feelsLike,
    Expression<int>? humidity,
    Expression<int>? pressure,
    Expression<double>? windSpeed,
    Expression<int>? windDirection,
    Expression<int>? visibility,
    Expression<int>? cloudiness,
    Expression<int>? sunriseMs,
    Expression<int>? sunsetMs,
    Expression<int>? timestampMs,
    Expression<String>? weatherJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cityName != null) 'city_name': cityName,
      if (country != null) 'country': country,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (weatherId != null) 'weather_id': weatherId,
      if (main != null) 'main': main,
      if (description != null) 'description': description,
      if (icon != null) 'icon': icon,
      if (temperature != null) 'temperature': temperature,
      if (feelsLike != null) 'feels_like': feelsLike,
      if (humidity != null) 'humidity': humidity,
      if (pressure != null) 'pressure': pressure,
      if (windSpeed != null) 'wind_speed': windSpeed,
      if (windDirection != null) 'wind_direction': windDirection,
      if (visibility != null) 'visibility': visibility,
      if (cloudiness != null) 'cloudiness': cloudiness,
      if (sunriseMs != null) 'sunrise_ms': sunriseMs,
      if (sunsetMs != null) 'sunset_ms': sunsetMs,
      if (timestampMs != null) 'timestamp_ms': timestampMs,
      if (weatherJson != null) 'weather_json': weatherJson,
    });
  }

  WeatherCacheCompanion copyWith({
    Value<int>? id,
    Value<String>? cityName,
    Value<String>? country,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<int>? weatherId,
    Value<String>? main,
    Value<String>? description,
    Value<String>? icon,
    Value<double>? temperature,
    Value<double>? feelsLike,
    Value<int>? humidity,
    Value<int>? pressure,
    Value<double>? windSpeed,
    Value<int>? windDirection,
    Value<int>? visibility,
    Value<int>? cloudiness,
    Value<int>? sunriseMs,
    Value<int>? sunsetMs,
    Value<int>? timestampMs,
    Value<String>? weatherJson,
  }) {
    return WeatherCacheCompanion(
      id: id ?? this.id,
      cityName: cityName ?? this.cityName,
      country: country ?? this.country,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      weatherId: weatherId ?? this.weatherId,
      main: main ?? this.main,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      temperature: temperature ?? this.temperature,
      feelsLike: feelsLike ?? this.feelsLike,
      humidity: humidity ?? this.humidity,
      pressure: pressure ?? this.pressure,
      windSpeed: windSpeed ?? this.windSpeed,
      windDirection: windDirection ?? this.windDirection,
      visibility: visibility ?? this.visibility,
      cloudiness: cloudiness ?? this.cloudiness,
      sunriseMs: sunriseMs ?? this.sunriseMs,
      sunsetMs: sunsetMs ?? this.sunsetMs,
      timestampMs: timestampMs ?? this.timestampMs,
      weatherJson: weatherJson ?? this.weatherJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cityName.present) {
      map['city_name'] = Variable<String>(cityName.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (weatherId.present) {
      map['weather_id'] = Variable<int>(weatherId.value);
    }
    if (main.present) {
      map['main'] = Variable<String>(main.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<double>(temperature.value);
    }
    if (feelsLike.present) {
      map['feels_like'] = Variable<double>(feelsLike.value);
    }
    if (humidity.present) {
      map['humidity'] = Variable<int>(humidity.value);
    }
    if (pressure.present) {
      map['pressure'] = Variable<int>(pressure.value);
    }
    if (windSpeed.present) {
      map['wind_speed'] = Variable<double>(windSpeed.value);
    }
    if (windDirection.present) {
      map['wind_direction'] = Variable<int>(windDirection.value);
    }
    if (visibility.present) {
      map['visibility'] = Variable<int>(visibility.value);
    }
    if (cloudiness.present) {
      map['cloudiness'] = Variable<int>(cloudiness.value);
    }
    if (sunriseMs.present) {
      map['sunrise_ms'] = Variable<int>(sunriseMs.value);
    }
    if (sunsetMs.present) {
      map['sunset_ms'] = Variable<int>(sunsetMs.value);
    }
    if (timestampMs.present) {
      map['timestamp_ms'] = Variable<int>(timestampMs.value);
    }
    if (weatherJson.present) {
      map['weather_json'] = Variable<String>(weatherJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeatherCacheCompanion(')
          ..write('id: $id, ')
          ..write('cityName: $cityName, ')
          ..write('country: $country, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('weatherId: $weatherId, ')
          ..write('main: $main, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('temperature: $temperature, ')
          ..write('feelsLike: $feelsLike, ')
          ..write('humidity: $humidity, ')
          ..write('pressure: $pressure, ')
          ..write('windSpeed: $windSpeed, ')
          ..write('windDirection: $windDirection, ')
          ..write('visibility: $visibility, ')
          ..write('cloudiness: $cloudiness, ')
          ..write('sunriseMs: $sunriseMs, ')
          ..write('sunsetMs: $sunsetMs, ')
          ..write('timestampMs: $timestampMs, ')
          ..write('weatherJson: $weatherJson')
          ..write(')'))
        .toString();
  }
}

class $NewsCacheTable extends NewsCache
    with TableInfo<$NewsCacheTable, NewsCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NewsCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _publishedAtMsMeta = const VerificationMeta(
    'publishedAtMs',
  );
  @override
  late final GeneratedColumn<int> publishedAtMs = GeneratedColumn<int>(
    'published_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _articleJsonMeta = const VerificationMeta(
    'articleJson',
  );
  @override
  late final GeneratedColumn<String> articleJson = GeneratedColumn<String>(
    'article_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _savedAtMsMeta = const VerificationMeta(
    'savedAtMs',
  );
  @override
  late final GeneratedColumn<int> savedAtMs = GeneratedColumn<int>(
    'saved_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSavedMeta = const VerificationMeta(
    'isSaved',
  );
  @override
  late final GeneratedColumn<bool> isSaved = GeneratedColumn<bool>(
    'is_saved',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_saved" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    content,
    url,
    imageUrl,
    publishedAtMs,
    source,
    author,
    category,
    articleJson,
    savedAtMs,
    isSaved,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'news_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<NewsCacheData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('published_at_ms')) {
      context.handle(
        _publishedAtMsMeta,
        publishedAtMs.isAcceptableOrUnknown(
          data['published_at_ms']!,
          _publishedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_publishedAtMsMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('article_json')) {
      context.handle(
        _articleJsonMeta,
        articleJson.isAcceptableOrUnknown(
          data['article_json']!,
          _articleJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_articleJsonMeta);
    }
    if (data.containsKey('saved_at_ms')) {
      context.handle(
        _savedAtMsMeta,
        savedAtMs.isAcceptableOrUnknown(data['saved_at_ms']!, _savedAtMsMeta),
      );
    } else if (isInserting) {
      context.missing(_savedAtMsMeta);
    }
    if (data.containsKey('is_saved')) {
      context.handle(
        _isSavedMeta,
        isSaved.isAcceptableOrUnknown(data['is_saved']!, _isSavedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NewsCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NewsCacheData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
      content:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}content'],
          )!,
      url:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}url'],
          )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      publishedAtMs:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}published_at_ms'],
          )!,
      source:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}source'],
          )!,
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      ),
      category:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}category'],
          )!,
      articleJson:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}article_json'],
          )!,
      savedAtMs:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}saved_at_ms'],
          )!,
      isSaved:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_saved'],
          )!,
    );
  }

  @override
  $NewsCacheTable createAlias(String alias) {
    return $NewsCacheTable(attachedDatabase, alias);
  }
}

class NewsCacheData extends DataClass implements Insertable<NewsCacheData> {
  final String id;
  final String title;
  final String description;
  final String content;
  final String url;
  final String? imageUrl;
  final int publishedAtMs;
  final String source;
  final String? author;
  final String category;
  final String articleJson;
  final int savedAtMs;
  final bool isSaved;
  const NewsCacheData({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.url,
    this.imageUrl,
    required this.publishedAtMs,
    required this.source,
    this.author,
    required this.category,
    required this.articleJson,
    required this.savedAtMs,
    required this.isSaved,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['content'] = Variable<String>(content);
    map['url'] = Variable<String>(url);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    map['published_at_ms'] = Variable<int>(publishedAtMs);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    map['category'] = Variable<String>(category);
    map['article_json'] = Variable<String>(articleJson);
    map['saved_at_ms'] = Variable<int>(savedAtMs);
    map['is_saved'] = Variable<bool>(isSaved);
    return map;
  }

  NewsCacheCompanion toCompanion(bool nullToAbsent) {
    return NewsCacheCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      content: Value(content),
      url: Value(url),
      imageUrl:
          imageUrl == null && nullToAbsent
              ? const Value.absent()
              : Value(imageUrl),
      publishedAtMs: Value(publishedAtMs),
      source: Value(source),
      author:
          author == null && nullToAbsent ? const Value.absent() : Value(author),
      category: Value(category),
      articleJson: Value(articleJson),
      savedAtMs: Value(savedAtMs),
      isSaved: Value(isSaved),
    );
  }

  factory NewsCacheData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NewsCacheData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      content: serializer.fromJson<String>(json['content']),
      url: serializer.fromJson<String>(json['url']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      publishedAtMs: serializer.fromJson<int>(json['publishedAtMs']),
      source: serializer.fromJson<String>(json['source']),
      author: serializer.fromJson<String?>(json['author']),
      category: serializer.fromJson<String>(json['category']),
      articleJson: serializer.fromJson<String>(json['articleJson']),
      savedAtMs: serializer.fromJson<int>(json['savedAtMs']),
      isSaved: serializer.fromJson<bool>(json['isSaved']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'content': serializer.toJson<String>(content),
      'url': serializer.toJson<String>(url),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'publishedAtMs': serializer.toJson<int>(publishedAtMs),
      'source': serializer.toJson<String>(source),
      'author': serializer.toJson<String?>(author),
      'category': serializer.toJson<String>(category),
      'articleJson': serializer.toJson<String>(articleJson),
      'savedAtMs': serializer.toJson<int>(savedAtMs),
      'isSaved': serializer.toJson<bool>(isSaved),
    };
  }

  NewsCacheData copyWith({
    String? id,
    String? title,
    String? description,
    String? content,
    String? url,
    Value<String?> imageUrl = const Value.absent(),
    int? publishedAtMs,
    String? source,
    Value<String?> author = const Value.absent(),
    String? category,
    String? articleJson,
    int? savedAtMs,
    bool? isSaved,
  }) => NewsCacheData(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    content: content ?? this.content,
    url: url ?? this.url,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    publishedAtMs: publishedAtMs ?? this.publishedAtMs,
    source: source ?? this.source,
    author: author.present ? author.value : this.author,
    category: category ?? this.category,
    articleJson: articleJson ?? this.articleJson,
    savedAtMs: savedAtMs ?? this.savedAtMs,
    isSaved: isSaved ?? this.isSaved,
  );
  NewsCacheData copyWithCompanion(NewsCacheCompanion data) {
    return NewsCacheData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      content: data.content.present ? data.content.value : this.content,
      url: data.url.present ? data.url.value : this.url,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      publishedAtMs:
          data.publishedAtMs.present
              ? data.publishedAtMs.value
              : this.publishedAtMs,
      source: data.source.present ? data.source.value : this.source,
      author: data.author.present ? data.author.value : this.author,
      category: data.category.present ? data.category.value : this.category,
      articleJson:
          data.articleJson.present ? data.articleJson.value : this.articleJson,
      savedAtMs: data.savedAtMs.present ? data.savedAtMs.value : this.savedAtMs,
      isSaved: data.isSaved.present ? data.isSaved.value : this.isSaved,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NewsCacheData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('content: $content, ')
          ..write('url: $url, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('publishedAtMs: $publishedAtMs, ')
          ..write('source: $source, ')
          ..write('author: $author, ')
          ..write('category: $category, ')
          ..write('articleJson: $articleJson, ')
          ..write('savedAtMs: $savedAtMs, ')
          ..write('isSaved: $isSaved')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    content,
    url,
    imageUrl,
    publishedAtMs,
    source,
    author,
    category,
    articleJson,
    savedAtMs,
    isSaved,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NewsCacheData &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.content == this.content &&
          other.url == this.url &&
          other.imageUrl == this.imageUrl &&
          other.publishedAtMs == this.publishedAtMs &&
          other.source == this.source &&
          other.author == this.author &&
          other.category == this.category &&
          other.articleJson == this.articleJson &&
          other.savedAtMs == this.savedAtMs &&
          other.isSaved == this.isSaved);
}

class NewsCacheCompanion extends UpdateCompanion<NewsCacheData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> description;
  final Value<String> content;
  final Value<String> url;
  final Value<String?> imageUrl;
  final Value<int> publishedAtMs;
  final Value<String> source;
  final Value<String?> author;
  final Value<String> category;
  final Value<String> articleJson;
  final Value<int> savedAtMs;
  final Value<bool> isSaved;
  final Value<int> rowid;
  const NewsCacheCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.content = const Value.absent(),
    this.url = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.publishedAtMs = const Value.absent(),
    this.source = const Value.absent(),
    this.author = const Value.absent(),
    this.category = const Value.absent(),
    this.articleJson = const Value.absent(),
    this.savedAtMs = const Value.absent(),
    this.isSaved = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NewsCacheCompanion.insert({
    required String id,
    required String title,
    required String description,
    required String content,
    required String url,
    this.imageUrl = const Value.absent(),
    required int publishedAtMs,
    required String source,
    this.author = const Value.absent(),
    required String category,
    required String articleJson,
    required int savedAtMs,
    this.isSaved = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       description = Value(description),
       content = Value(content),
       url = Value(url),
       publishedAtMs = Value(publishedAtMs),
       source = Value(source),
       category = Value(category),
       articleJson = Value(articleJson),
       savedAtMs = Value(savedAtMs);
  static Insertable<NewsCacheData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? content,
    Expression<String>? url,
    Expression<String>? imageUrl,
    Expression<int>? publishedAtMs,
    Expression<String>? source,
    Expression<String>? author,
    Expression<String>? category,
    Expression<String>? articleJson,
    Expression<int>? savedAtMs,
    Expression<bool>? isSaved,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (content != null) 'content': content,
      if (url != null) 'url': url,
      if (imageUrl != null) 'image_url': imageUrl,
      if (publishedAtMs != null) 'published_at_ms': publishedAtMs,
      if (source != null) 'source': source,
      if (author != null) 'author': author,
      if (category != null) 'category': category,
      if (articleJson != null) 'article_json': articleJson,
      if (savedAtMs != null) 'saved_at_ms': savedAtMs,
      if (isSaved != null) 'is_saved': isSaved,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NewsCacheCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? description,
    Value<String>? content,
    Value<String>? url,
    Value<String?>? imageUrl,
    Value<int>? publishedAtMs,
    Value<String>? source,
    Value<String?>? author,
    Value<String>? category,
    Value<String>? articleJson,
    Value<int>? savedAtMs,
    Value<bool>? isSaved,
    Value<int>? rowid,
  }) {
    return NewsCacheCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      content: content ?? this.content,
      url: url ?? this.url,
      imageUrl: imageUrl ?? this.imageUrl,
      publishedAtMs: publishedAtMs ?? this.publishedAtMs,
      source: source ?? this.source,
      author: author ?? this.author,
      category: category ?? this.category,
      articleJson: articleJson ?? this.articleJson,
      savedAtMs: savedAtMs ?? this.savedAtMs,
      isSaved: isSaved ?? this.isSaved,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (publishedAtMs.present) {
      map['published_at_ms'] = Variable<int>(publishedAtMs.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (articleJson.present) {
      map['article_json'] = Variable<String>(articleJson.value);
    }
    if (savedAtMs.present) {
      map['saved_at_ms'] = Variable<int>(savedAtMs.value);
    }
    if (isSaved.present) {
      map['is_saved'] = Variable<bool>(isSaved.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NewsCacheCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('content: $content, ')
          ..write('url: $url, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('publishedAtMs: $publishedAtMs, ')
          ..write('source: $source, ')
          ..write('author: $author, ')
          ..write('category: $category, ')
          ..write('articleJson: $articleJson, ')
          ..write('savedAtMs: $savedAtMs, ')
          ..write('isSaved: $isSaved, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CitiesCacheTable extends CitiesCache
    with TableInfo<$CitiesCacheTable, CitiesCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CitiesCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCurrentLocationMeta = const VerificationMeta(
    'isCurrentLocation',
  );
  @override
  late final GeneratedColumn<bool> isCurrentLocation = GeneratedColumn<bool>(
    'is_current_location',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_current_location" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    country,
    state,
    latitude,
    longitude,
    isCurrentLocation,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cities_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<CitiesCacheData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    } else if (isInserting) {
      context.missing(_countryMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('is_current_location')) {
      context.handle(
        _isCurrentLocationMeta,
        isCurrentLocation.isAcceptableOrUnknown(
          data['is_current_location']!,
          _isCurrentLocationMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CitiesCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CitiesCacheData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      country:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}country'],
          )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      ),
      latitude:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}latitude'],
          )!,
      longitude:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}longitude'],
          )!,
      isCurrentLocation:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_current_location'],
          )!,
    );
  }

  @override
  $CitiesCacheTable createAlias(String alias) {
    return $CitiesCacheTable(attachedDatabase, alias);
  }
}

class CitiesCacheData extends DataClass implements Insertable<CitiesCacheData> {
  final int id;
  final String name;
  final String country;
  final String? state;
  final double latitude;
  final double longitude;
  final bool isCurrentLocation;
  const CitiesCacheData({
    required this.id,
    required this.name,
    required this.country,
    this.state,
    required this.latitude,
    required this.longitude,
    required this.isCurrentLocation,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['country'] = Variable<String>(country);
    if (!nullToAbsent || state != null) {
      map['state'] = Variable<String>(state);
    }
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['is_current_location'] = Variable<bool>(isCurrentLocation);
    return map;
  }

  CitiesCacheCompanion toCompanion(bool nullToAbsent) {
    return CitiesCacheCompanion(
      id: Value(id),
      name: Value(name),
      country: Value(country),
      state:
          state == null && nullToAbsent ? const Value.absent() : Value(state),
      latitude: Value(latitude),
      longitude: Value(longitude),
      isCurrentLocation: Value(isCurrentLocation),
    );
  }

  factory CitiesCacheData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CitiesCacheData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      country: serializer.fromJson<String>(json['country']),
      state: serializer.fromJson<String?>(json['state']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      isCurrentLocation: serializer.fromJson<bool>(json['isCurrentLocation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'country': serializer.toJson<String>(country),
      'state': serializer.toJson<String?>(state),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'isCurrentLocation': serializer.toJson<bool>(isCurrentLocation),
    };
  }

  CitiesCacheData copyWith({
    int? id,
    String? name,
    String? country,
    Value<String?> state = const Value.absent(),
    double? latitude,
    double? longitude,
    bool? isCurrentLocation,
  }) => CitiesCacheData(
    id: id ?? this.id,
    name: name ?? this.name,
    country: country ?? this.country,
    state: state.present ? state.value : this.state,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    isCurrentLocation: isCurrentLocation ?? this.isCurrentLocation,
  );
  CitiesCacheData copyWithCompanion(CitiesCacheCompanion data) {
    return CitiesCacheData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      country: data.country.present ? data.country.value : this.country,
      state: data.state.present ? data.state.value : this.state,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      isCurrentLocation:
          data.isCurrentLocation.present
              ? data.isCurrentLocation.value
              : this.isCurrentLocation,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CitiesCacheData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('country: $country, ')
          ..write('state: $state, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('isCurrentLocation: $isCurrentLocation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    country,
    state,
    latitude,
    longitude,
    isCurrentLocation,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CitiesCacheData &&
          other.id == this.id &&
          other.name == this.name &&
          other.country == this.country &&
          other.state == this.state &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.isCurrentLocation == this.isCurrentLocation);
}

class CitiesCacheCompanion extends UpdateCompanion<CitiesCacheData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> country;
  final Value<String?> state;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<bool> isCurrentLocation;
  const CitiesCacheCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.country = const Value.absent(),
    this.state = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.isCurrentLocation = const Value.absent(),
  });
  CitiesCacheCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String country,
    this.state = const Value.absent(),
    required double latitude,
    required double longitude,
    this.isCurrentLocation = const Value.absent(),
  }) : name = Value(name),
       country = Value(country),
       latitude = Value(latitude),
       longitude = Value(longitude);
  static Insertable<CitiesCacheData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? country,
    Expression<String>? state,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<bool>? isCurrentLocation,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (country != null) 'country': country,
      if (state != null) 'state': state,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (isCurrentLocation != null) 'is_current_location': isCurrentLocation,
    });
  }

  CitiesCacheCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? country,
    Value<String?>? state,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<bool>? isCurrentLocation,
  }) {
    return CitiesCacheCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      state: state ?? this.state,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isCurrentLocation: isCurrentLocation ?? this.isCurrentLocation,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (isCurrentLocation.present) {
      map['is_current_location'] = Variable<bool>(isCurrentLocation.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CitiesCacheCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('country: $country, ')
          ..write('state: $state, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('isCurrentLocation: $isCurrentLocation')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WeatherCacheTable weatherCache = $WeatherCacheTable(this);
  late final $NewsCacheTable newsCache = $NewsCacheTable(this);
  late final $CitiesCacheTable citiesCache = $CitiesCacheTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    weatherCache,
    newsCache,
    citiesCache,
  ];
}

typedef $$WeatherCacheTableCreateCompanionBuilder =
    WeatherCacheCompanion Function({
      Value<int> id,
      required String cityName,
      required String country,
      required double latitude,
      required double longitude,
      required int weatherId,
      required String main,
      required String description,
      required String icon,
      required double temperature,
      required double feelsLike,
      required int humidity,
      required int pressure,
      required double windSpeed,
      required int windDirection,
      required int visibility,
      required int cloudiness,
      required int sunriseMs,
      required int sunsetMs,
      required int timestampMs,
      required String weatherJson,
    });
typedef $$WeatherCacheTableUpdateCompanionBuilder =
    WeatherCacheCompanion Function({
      Value<int> id,
      Value<String> cityName,
      Value<String> country,
      Value<double> latitude,
      Value<double> longitude,
      Value<int> weatherId,
      Value<String> main,
      Value<String> description,
      Value<String> icon,
      Value<double> temperature,
      Value<double> feelsLike,
      Value<int> humidity,
      Value<int> pressure,
      Value<double> windSpeed,
      Value<int> windDirection,
      Value<int> visibility,
      Value<int> cloudiness,
      Value<int> sunriseMs,
      Value<int> sunsetMs,
      Value<int> timestampMs,
      Value<String> weatherJson,
    });

class $$WeatherCacheTableFilterComposer
    extends Composer<_$AppDatabase, $WeatherCacheTable> {
  $$WeatherCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cityName => $composableBuilder(
    column: $table.cityName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weatherId => $composableBuilder(
    column: $table.weatherId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get main => $composableBuilder(
    column: $table.main,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get feelsLike => $composableBuilder(
    column: $table.feelsLike,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get humidity => $composableBuilder(
    column: $table.humidity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pressure => $composableBuilder(
    column: $table.pressure,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get windSpeed => $composableBuilder(
    column: $table.windSpeed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get windDirection => $composableBuilder(
    column: $table.windDirection,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cloudiness => $composableBuilder(
    column: $table.cloudiness,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sunriseMs => $composableBuilder(
    column: $table.sunriseMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sunsetMs => $composableBuilder(
    column: $table.sunsetMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timestampMs => $composableBuilder(
    column: $table.timestampMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weatherJson => $composableBuilder(
    column: $table.weatherJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WeatherCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $WeatherCacheTable> {
  $$WeatherCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cityName => $composableBuilder(
    column: $table.cityName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weatherId => $composableBuilder(
    column: $table.weatherId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get main => $composableBuilder(
    column: $table.main,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get feelsLike => $composableBuilder(
    column: $table.feelsLike,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get humidity => $composableBuilder(
    column: $table.humidity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pressure => $composableBuilder(
    column: $table.pressure,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get windSpeed => $composableBuilder(
    column: $table.windSpeed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get windDirection => $composableBuilder(
    column: $table.windDirection,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cloudiness => $composableBuilder(
    column: $table.cloudiness,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sunriseMs => $composableBuilder(
    column: $table.sunriseMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sunsetMs => $composableBuilder(
    column: $table.sunsetMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timestampMs => $composableBuilder(
    column: $table.timestampMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weatherJson => $composableBuilder(
    column: $table.weatherJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WeatherCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeatherCacheTable> {
  $$WeatherCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cityName =>
      $composableBuilder(column: $table.cityName, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<int> get weatherId =>
      $composableBuilder(column: $table.weatherId, builder: (column) => column);

  GeneratedColumn<String> get main =>
      $composableBuilder(column: $table.main, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => column,
  );

  GeneratedColumn<double> get feelsLike =>
      $composableBuilder(column: $table.feelsLike, builder: (column) => column);

  GeneratedColumn<int> get humidity =>
      $composableBuilder(column: $table.humidity, builder: (column) => column);

  GeneratedColumn<int> get pressure =>
      $composableBuilder(column: $table.pressure, builder: (column) => column);

  GeneratedColumn<double> get windSpeed =>
      $composableBuilder(column: $table.windSpeed, builder: (column) => column);

  GeneratedColumn<int> get windDirection => $composableBuilder(
    column: $table.windDirection,
    builder: (column) => column,
  );

  GeneratedColumn<int> get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cloudiness => $composableBuilder(
    column: $table.cloudiness,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sunriseMs =>
      $composableBuilder(column: $table.sunriseMs, builder: (column) => column);

  GeneratedColumn<int> get sunsetMs =>
      $composableBuilder(column: $table.sunsetMs, builder: (column) => column);

  GeneratedColumn<int> get timestampMs => $composableBuilder(
    column: $table.timestampMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get weatherJson => $composableBuilder(
    column: $table.weatherJson,
    builder: (column) => column,
  );
}

class $$WeatherCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeatherCacheTable,
          WeatherCacheData,
          $$WeatherCacheTableFilterComposer,
          $$WeatherCacheTableOrderingComposer,
          $$WeatherCacheTableAnnotationComposer,
          $$WeatherCacheTableCreateCompanionBuilder,
          $$WeatherCacheTableUpdateCompanionBuilder,
          (
            WeatherCacheData,
            BaseReferences<_$AppDatabase, $WeatherCacheTable, WeatherCacheData>,
          ),
          WeatherCacheData,
          PrefetchHooks Function()
        > {
  $$WeatherCacheTableTableManager(_$AppDatabase db, $WeatherCacheTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$WeatherCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$WeatherCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$WeatherCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> cityName = const Value.absent(),
                Value<String> country = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<int> weatherId = const Value.absent(),
                Value<String> main = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<double> temperature = const Value.absent(),
                Value<double> feelsLike = const Value.absent(),
                Value<int> humidity = const Value.absent(),
                Value<int> pressure = const Value.absent(),
                Value<double> windSpeed = const Value.absent(),
                Value<int> windDirection = const Value.absent(),
                Value<int> visibility = const Value.absent(),
                Value<int> cloudiness = const Value.absent(),
                Value<int> sunriseMs = const Value.absent(),
                Value<int> sunsetMs = const Value.absent(),
                Value<int> timestampMs = const Value.absent(),
                Value<String> weatherJson = const Value.absent(),
              }) => WeatherCacheCompanion(
                id: id,
                cityName: cityName,
                country: country,
                latitude: latitude,
                longitude: longitude,
                weatherId: weatherId,
                main: main,
                description: description,
                icon: icon,
                temperature: temperature,
                feelsLike: feelsLike,
                humidity: humidity,
                pressure: pressure,
                windSpeed: windSpeed,
                windDirection: windDirection,
                visibility: visibility,
                cloudiness: cloudiness,
                sunriseMs: sunriseMs,
                sunsetMs: sunsetMs,
                timestampMs: timestampMs,
                weatherJson: weatherJson,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String cityName,
                required String country,
                required double latitude,
                required double longitude,
                required int weatherId,
                required String main,
                required String description,
                required String icon,
                required double temperature,
                required double feelsLike,
                required int humidity,
                required int pressure,
                required double windSpeed,
                required int windDirection,
                required int visibility,
                required int cloudiness,
                required int sunriseMs,
                required int sunsetMs,
                required int timestampMs,
                required String weatherJson,
              }) => WeatherCacheCompanion.insert(
                id: id,
                cityName: cityName,
                country: country,
                latitude: latitude,
                longitude: longitude,
                weatherId: weatherId,
                main: main,
                description: description,
                icon: icon,
                temperature: temperature,
                feelsLike: feelsLike,
                humidity: humidity,
                pressure: pressure,
                windSpeed: windSpeed,
                windDirection: windDirection,
                visibility: visibility,
                cloudiness: cloudiness,
                sunriseMs: sunriseMs,
                sunsetMs: sunsetMs,
                timestampMs: timestampMs,
                weatherJson: weatherJson,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WeatherCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeatherCacheTable,
      WeatherCacheData,
      $$WeatherCacheTableFilterComposer,
      $$WeatherCacheTableOrderingComposer,
      $$WeatherCacheTableAnnotationComposer,
      $$WeatherCacheTableCreateCompanionBuilder,
      $$WeatherCacheTableUpdateCompanionBuilder,
      (
        WeatherCacheData,
        BaseReferences<_$AppDatabase, $WeatherCacheTable, WeatherCacheData>,
      ),
      WeatherCacheData,
      PrefetchHooks Function()
    >;
typedef $$NewsCacheTableCreateCompanionBuilder =
    NewsCacheCompanion Function({
      required String id,
      required String title,
      required String description,
      required String content,
      required String url,
      Value<String?> imageUrl,
      required int publishedAtMs,
      required String source,
      Value<String?> author,
      required String category,
      required String articleJson,
      required int savedAtMs,
      Value<bool> isSaved,
      Value<int> rowid,
    });
typedef $$NewsCacheTableUpdateCompanionBuilder =
    NewsCacheCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> description,
      Value<String> content,
      Value<String> url,
      Value<String?> imageUrl,
      Value<int> publishedAtMs,
      Value<String> source,
      Value<String?> author,
      Value<String> category,
      Value<String> articleJson,
      Value<int> savedAtMs,
      Value<bool> isSaved,
      Value<int> rowid,
    });

class $$NewsCacheTableFilterComposer
    extends Composer<_$AppDatabase, $NewsCacheTable> {
  $$NewsCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get publishedAtMs => $composableBuilder(
    column: $table.publishedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get articleJson => $composableBuilder(
    column: $table.articleJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get savedAtMs => $composableBuilder(
    column: $table.savedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSaved => $composableBuilder(
    column: $table.isSaved,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NewsCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $NewsCacheTable> {
  $$NewsCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get publishedAtMs => $composableBuilder(
    column: $table.publishedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get articleJson => $composableBuilder(
    column: $table.articleJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get savedAtMs => $composableBuilder(
    column: $table.savedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSaved => $composableBuilder(
    column: $table.isSaved,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NewsCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $NewsCacheTable> {
  $$NewsCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<int> get publishedAtMs => $composableBuilder(
    column: $table.publishedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get articleJson => $composableBuilder(
    column: $table.articleJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get savedAtMs =>
      $composableBuilder(column: $table.savedAtMs, builder: (column) => column);

  GeneratedColumn<bool> get isSaved =>
      $composableBuilder(column: $table.isSaved, builder: (column) => column);
}

class $$NewsCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NewsCacheTable,
          NewsCacheData,
          $$NewsCacheTableFilterComposer,
          $$NewsCacheTableOrderingComposer,
          $$NewsCacheTableAnnotationComposer,
          $$NewsCacheTableCreateCompanionBuilder,
          $$NewsCacheTableUpdateCompanionBuilder,
          (
            NewsCacheData,
            BaseReferences<_$AppDatabase, $NewsCacheTable, NewsCacheData>,
          ),
          NewsCacheData,
          PrefetchHooks Function()
        > {
  $$NewsCacheTableTableManager(_$AppDatabase db, $NewsCacheTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$NewsCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$NewsCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$NewsCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<int> publishedAtMs = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> articleJson = const Value.absent(),
                Value<int> savedAtMs = const Value.absent(),
                Value<bool> isSaved = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NewsCacheCompanion(
                id: id,
                title: title,
                description: description,
                content: content,
                url: url,
                imageUrl: imageUrl,
                publishedAtMs: publishedAtMs,
                source: source,
                author: author,
                category: category,
                articleJson: articleJson,
                savedAtMs: savedAtMs,
                isSaved: isSaved,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String description,
                required String content,
                required String url,
                Value<String?> imageUrl = const Value.absent(),
                required int publishedAtMs,
                required String source,
                Value<String?> author = const Value.absent(),
                required String category,
                required String articleJson,
                required int savedAtMs,
                Value<bool> isSaved = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NewsCacheCompanion.insert(
                id: id,
                title: title,
                description: description,
                content: content,
                url: url,
                imageUrl: imageUrl,
                publishedAtMs: publishedAtMs,
                source: source,
                author: author,
                category: category,
                articleJson: articleJson,
                savedAtMs: savedAtMs,
                isSaved: isSaved,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NewsCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NewsCacheTable,
      NewsCacheData,
      $$NewsCacheTableFilterComposer,
      $$NewsCacheTableOrderingComposer,
      $$NewsCacheTableAnnotationComposer,
      $$NewsCacheTableCreateCompanionBuilder,
      $$NewsCacheTableUpdateCompanionBuilder,
      (
        NewsCacheData,
        BaseReferences<_$AppDatabase, $NewsCacheTable, NewsCacheData>,
      ),
      NewsCacheData,
      PrefetchHooks Function()
    >;
typedef $$CitiesCacheTableCreateCompanionBuilder =
    CitiesCacheCompanion Function({
      Value<int> id,
      required String name,
      required String country,
      Value<String?> state,
      required double latitude,
      required double longitude,
      Value<bool> isCurrentLocation,
    });
typedef $$CitiesCacheTableUpdateCompanionBuilder =
    CitiesCacheCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> country,
      Value<String?> state,
      Value<double> latitude,
      Value<double> longitude,
      Value<bool> isCurrentLocation,
    });

class $$CitiesCacheTableFilterComposer
    extends Composer<_$AppDatabase, $CitiesCacheTable> {
  $$CitiesCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCurrentLocation => $composableBuilder(
    column: $table.isCurrentLocation,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CitiesCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $CitiesCacheTable> {
  $$CitiesCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCurrentLocation => $composableBuilder(
    column: $table.isCurrentLocation,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CitiesCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $CitiesCacheTable> {
  $$CitiesCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<bool> get isCurrentLocation => $composableBuilder(
    column: $table.isCurrentLocation,
    builder: (column) => column,
  );
}

class $$CitiesCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CitiesCacheTable,
          CitiesCacheData,
          $$CitiesCacheTableFilterComposer,
          $$CitiesCacheTableOrderingComposer,
          $$CitiesCacheTableAnnotationComposer,
          $$CitiesCacheTableCreateCompanionBuilder,
          $$CitiesCacheTableUpdateCompanionBuilder,
          (
            CitiesCacheData,
            BaseReferences<_$AppDatabase, $CitiesCacheTable, CitiesCacheData>,
          ),
          CitiesCacheData,
          PrefetchHooks Function()
        > {
  $$CitiesCacheTableTableManager(_$AppDatabase db, $CitiesCacheTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CitiesCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$CitiesCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$CitiesCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> country = const Value.absent(),
                Value<String?> state = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<bool> isCurrentLocation = const Value.absent(),
              }) => CitiesCacheCompanion(
                id: id,
                name: name,
                country: country,
                state: state,
                latitude: latitude,
                longitude: longitude,
                isCurrentLocation: isCurrentLocation,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String country,
                Value<String?> state = const Value.absent(),
                required double latitude,
                required double longitude,
                Value<bool> isCurrentLocation = const Value.absent(),
              }) => CitiesCacheCompanion.insert(
                id: id,
                name: name,
                country: country,
                state: state,
                latitude: latitude,
                longitude: longitude,
                isCurrentLocation: isCurrentLocation,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CitiesCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CitiesCacheTable,
      CitiesCacheData,
      $$CitiesCacheTableFilterComposer,
      $$CitiesCacheTableOrderingComposer,
      $$CitiesCacheTableAnnotationComposer,
      $$CitiesCacheTableCreateCompanionBuilder,
      $$CitiesCacheTableUpdateCompanionBuilder,
      (
        CitiesCacheData,
        BaseReferences<_$AppDatabase, $CitiesCacheTable, CitiesCacheData>,
      ),
      CitiesCacheData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WeatherCacheTableTableManager get weatherCache =>
      $$WeatherCacheTableTableManager(_db, _db.weatherCache);
  $$NewsCacheTableTableManager get newsCache =>
      $$NewsCacheTableTableManager(_db, _db.newsCache);
  $$CitiesCacheTableTableManager get citiesCache =>
      $$CitiesCacheTableTableManager(_db, _db.citiesCache);
}
