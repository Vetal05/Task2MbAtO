# 🌤️ Weather & News App

Flutter Individual Project - Weather & News App з використанням Clean Architecture та BLoC Pattern.

## 🎯 Обрана тема

**Weather & News App** - додаток для отримання поточної погоди та останніх новин.

## 🏗️ Архітектура

- **Clean Architecture** (3 layers: Presentation, Domain, Data)
- **BLoC Pattern** для state management
- **Repository Pattern** + Dependency Injection
- **Service Locator** для управління залежностями

## 🌐 API Integration

- **OpenWeatherMap One Call API 3.0** - повні дані погоди (API Key: 0709d61beaae1c619a3929e0f7246156)
  - Поточна погода
  - Прогноз на години (48 годин)
  - Прогноз на дні (8 днів)
  - Детальна інформація про опади, вітер, вологість
- **NewsAPI** - новини (API Key: cc5063353b1049fda8302de34991a92f)
- **Offline-first approach** з кешуванням
- **Error handling strategy** з retry mechanisms

## 🚀 Features

### Weather Features

- **Поточна погода** з детальною інформацією
- **Графік температури** по годинах з інтерактивними точками
- **Таби навігації** (Температура, Опади, Вітер)
- **Прогноз на тиждень** з горизонтальним селектором
- **Темна тема** з градієнтним дизайном
- **Детальна інформація** про погоду (температура, вологість, тиск, вітер, опади)
- **Пошук міст** та автоматичне визначення локації
- **Збереження улюблених міст**
- **Кешування даних** для офлайн роботи

### News Features

- Топ новини з NewsAPI
- Новини за категоріями (technology, business, sports, etc.)
- Детальна сторінка статей з повним текстом
- Пошук новин
- Збереження статей
- Підтримка різних країн (US, UK, UA, etc.)
- Кешування для офлайн роботи

### Technical Features

- Clean Architecture
- BLoC State Management
- Repository Pattern
- Dependency Injection
- Error Handling
- Offline Support
- Responsive UI

## 🧪 Testing

- Unit tests: Планується
- Widget tests: Планується
- Integration tests: Планується

## 📱 Screenshots

Додаток містить:

- **Новий темний UI** з градієнтним дизайном
- **Графік температури** по годинах з інтерактивними точками
- **Таби навігації** (Температура, Опади, Вітер)
- **Прогноз на тиждень** з горизонтальним скролом
- **Детальна інформація** про погоду (вологість, вітер, опади)
- **Список останніх новин** з зображеннями
- **Пошук міст та новин**

## 🛠️ Setup Instructions

1. Клонуйте репозиторій
2. Встановіть залежності: `flutter pub get`
3. Очистіть кеш: `flutter clean`
4. Запустіть додаток: `flutter run`

### ⚠️ Важливо:

- Переконайтеся, що у вас встановлений Flutter SDK
- API ключі вже налаштовані в коді
- Додаток працює з реальними API (OpenWeatherMap та NewsAPI)
- Якщо виникає помилка "type 'Null' is not a subtype of type 'WeatherBloc'", виконайте `flutter clean` та `flutter pub get`

## 🔧 CI/CD

- Планується налаштування GitHub Actions
- Автоматичне тестування
- Збірка APK файлів
- Звіти про покриття коду

## 📊 Performance Optimizations

- Lazy loading для списків
- Image caching optimization
- Widget rebuild optimization
- Memory management
- Offline-first approach

## 🔒 Security Measures

- API keys в константах (для демо)
- Secure storage implementation (планується)
- Code obfuscation для release (планується)

## 📁 Project Structure

```
lib/
├── core/                    # Core utilities
│   ├── constants/          # App constants
│   ├── di/                 # Dependency injection
│   ├── error/              # Error handling
│   └── network/            # Network utilities
├── features/               # Feature modules
│   ├── weather/            # Weather feature
│   │   ├── data/           # Data layer
│   │   ├── domain/         # Domain layer
│   │   └── presentation/  # Presentation layer
│   ├── news/               # News feature
│   │   ├── data/           # Data layer
│   │   ├── domain/         # Domain layer
│   │   └── presentation/   # Presentation layer
│   └── home/               # Home feature
│       └── presentation/   # Presentation layer
└── main.dart              # App entry point
```

## 🎯 Use Cases

### Weather Use Cases

- GetCurrentWeather
- GetWeatherForecast
- SearchCities
- GetCurrentLocation
- SaveCity

### News Use Cases

- GetTopHeadlines
- GetArticlesByCategory
- SearchArticles
- SaveArticle

## 🔄 State Management

Використовується BLoC Pattern з ChangeNotifier для:

- WeatherBloc - управління станом погоди
- NewsBloc - управління станом новин

## 📦 Dependencies

- `flutter` - Flutter SDK
- `http` - HTTP client
- `intl` - Internationalization

## 🚧 TODO

- [ ] Додати unit тести
- [ ] Додати widget тести
- [ ] Додати integration тести
- [ ] Налаштувати CI/CD pipeline
- [ ] Додати аутентифікацію
- [ ] Покращити UI/UX
- [ ] Додати push notifications
- [ ] Додати геолокацію

## 📄 License

Цей проект створено як частину індивідуального завдання з Flutter розробки.

## 👨‍💻 Author

Створено з використанням Clean Architecture та найкращих практик Flutter розробки.
