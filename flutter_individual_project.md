# 📱 Flutter Individual Project: Три тематичні додатки

## 🎯 Мета проекту

Створити один з трьох тематичних мобільних додатків з використанням ключових концепцій курсу. Кожен проект демонструє професійний підхід до розробки від архітектури до production deployment.

---

## 📋 Теми проектів (на вибір)

### 🎬 Тема 1: Movie Discovery App

**API**: [The Movie Database (TMDB) API](https://www.themoviedb.org/documentation/api)

- Каталог фільмів і серіалів
- Пошук за жанрами, роком, рейтингом
- Watchlist/Favorites
- Деталі фільму з трейлерами та відгуками

### 🌤️ Тема 2: Weather & News App

**API**:

- [OpenWeatherMap API](https://openweathermap.org/api) - погода(моє апі: 0709d61beaae1c619a3929e0f7246156)
- [NewsAPI](https://newsapi.org/) - новини(моє апі: cc5063353b1049fda8302de34991a92f )
- Поточна погода і прогноз на тиждень
- Новини за категоріями
- Геолокація та збережені міста
- Push notifications для погодних попереджень

### 🏃‍♂️ Тема 3: Fitness & Recipe App

**API**:

- [Spoonacular API](https://spoonacular.com/food-api) - рецепти
- [ExerciseDB API](https://rapidapi.com/justin-WFnsXH_t6/api/exercisedb/) - вправи
- Каталог рецептів з фільтрацією
- База вправ з інструкціями
- Meal planner та workout tracker
- Калькулятор калорій

---

## 🏗️ Архітектурні вимоги

### ✅ Clean Architecture:

- Presentation, Domain, Data layers
- Repository Pattern для всіх API calls
- Dependency Injection (GetIt)
- Мінімум 5 use cases per тема

### ✅ State Management (на вибір):

- **BLoC Pattern** з Events/States або
- **Riverpod** з Providers/Notifiers
- Global state для auth, favorites, settings
- Error state handling

### ✅ API Integration:

- HTTP client з Dio
- Error handling + retry mechanisms
- Offline-first з кешуванням
- Interceptors для headers/logging

### ✅ Local Storage:

- SQLite/Drift для кешу даних
- Hive для user preferences
- Secure Storage для API keys

### ✅ Authentication:

- Firebase Auth або Supabase або
- Mock API з JWT tokens
- Login/Register flows
- Protected routes

### ✅ Performance:

- Lazy loading для списків
- Image caching optimization
- Widget rebuild optimization
- Memory management

### ✅ Custom UI:

- Мінімум 2 custom widgets
- Hero/Page transitions
- Loading animations
- Responsive design

### ✅ Testing:

- Unit tests (business logic)
- Widget tests (UI components)
- Integration tests (user flows)
- **Мінімум 70% code coverage**

### ✅ CI/CD Pipeline (обов'язково):

Приклад:

```yaml
# .github/workflows/flutter.yml
name: Flutter CI/CD
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter analyze --fatal-infos
      - run: flutter test --coverage

  build:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - run: flutter build apk --release
```

‼️ P.S.: у вас будуть свої налаштування, чим більше тим краще.

### ✅ Security:

- API keys в environment variables
- Secure storage implementation
- Code obfuscation для release

---

## 🗂️ Обов'язкова структура проекту

```
your_app/
├── lib/
│   ├── core/              # Utils, constants, DI
│   ├── features/          # Feature modules
│   │   ├── auth/
│   │   ├── home/
│   │   ├── favorites/
│   │   └── profile/
│   ├── shared/           # Shared widgets/models
│   └── main.dart
├── test/                 # Unit + Widget tests
├── integration_test/     # E2E tests
├── .github/workflows/    # CI/CD
├── README.md            # Детальний опис
└── pubspec.yaml
```

---

## 📊 Критерії оцінювання

| Критерій             | Бали | Деталі                        |
| -------------------- | ---- | ----------------------------- |
| **Architecture**     | 25   | Clean Architecture + DI       |
| **API Integration**  | 20   | Proper HTTP + offline support |
| **State Management** | 15   | BLoC або Riverpod             |
| **Testing**          | 15   | Unit/Widget/Integration       |
| **CI/CD**            | 10   | Working GitHub Actions        |
| **UI/UX**            | 10   | Custom widgets + animations   |
| **Code Quality**     | 5    | Linting, documentation        |

**Всього: 100 балів**

---

## 📝 README.md Template

```markdown
# [Your App Name]

## 🎯 Обрана тема

[Movie Discovery / Weather & News / Fitness & Recipe]

## 🏗️ Архітектура

- Clean Architecture (3 layers)
- [BLoC / Riverpod] for state management
- Repository Pattern + DI

## 🌐 API Integration

- [List of APIs used]
- Offline-first approach
- Error handling strategy

## 🚀 Features

- [List main features]
- Authentication flow
- Favorites/Bookmarks
- Search & Filters

## 🧪 Testing

- Unit tests: XX%
- Widget tests: XX%
- Integration tests: X scenarios

## 📱 Screenshots

[Add 4-6 app screenshots]

## 🛠️ Setup Instructions

1. Clone repository
2. Add API keys to .env
3. Run flutter pub get
4. Run flutter run

## 🔧 CI/CD

- Automated testing on push
- APK build artifacts
- Code coverage reports

## 📊 Performance Optimizations

- [List optimizations implemented]

## 🔒 Security Measures

- [Security implementations]
```

---

## ⏰ Timeline (6 тижнів)

- **Тиждень 1**: Вибір теми + архітектура setup
- **Тиждень 2**: API integration + base UI
- **Тиждень 3**: State management + features
- **Тиждень 4**: Testing + optimizations
- **Тиждень 5**: CI/CD + security
- **Тиждень 6**: Documentation + презентація

---

## 🎤 Презентація (10 хвилин)

### ✅ Структура презентації:

1. **Demo** основного функціоналу (3 хв)
2. **Архітектурні рішення** та обґрунтування (3 хв)
3. **CI/CD pipeline** демонстрація (2 хв)
4. **Challenges & Solutions** (2 хв)

### ✅ Матеріали для подачі:

- GitHub repository (public)
- Working CI/CD pipeline
- APK file для тестування
- Presentation slides
- README.md з повним описом

---

## 💡 Практичні поради

- Почніть з простого MVP
- Використовуйте feature branches
- Коммітьте часто з clear messages
- Тестуйте CI/CD з першого дня
- Документуйте архітектурні рішення
- Не забувайте про error handling

---

## 🏆 Бонусні завдання (+10 балів)

- Dark/Light theme toggle (+3)
- Multi-language support (+3)
- Offline sync strategy (+4)

---
