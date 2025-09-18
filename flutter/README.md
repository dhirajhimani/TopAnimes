# TopAnimes Flutter

A Flutter application showcasing top anime using Clean Architecture principles, built as a migration from the original Android application.

## Features

- 🎯 **Clean Architecture** - Separated into Data, Domain, and Presentation layers
- 🔄 **State Management** - Using Cubit from flutter_bloc
- 💾 **Offline Support** - Local caching with SharedPreferences
- 🌗 **Dark Theme** - Automatic light/dark theme switching
- 🔄 **Pull to Refresh** - Refresh anime list with pull-to-refresh gesture
- 🌐 **External Links** - Tap anime cards to open in browser
- ⚡ **Modern UI** - Material 3 design with smooth animations

## Project Structure

```
lib/
├── core/                       # Core functionality
│   ├── constants/             # App constants (API URLs, storage keys)
│   ├── error/                 # Error handling (failures, exceptions)
│   ├── network/               # Network client configuration
│   └── usecases/              # Base use case classes
├── data/                      # Data layer
│   ├── datasources/           # Remote and local data sources
│   ├── models/                # Data Transfer Objects (DTOs)
│   └── repositories/          # Repository implementations
├── domain/                    # Domain layer (pure Dart)
│   ├── entities/              # Business entities
│   ├── repositories/          # Repository contracts
│   └── usecases/              # Business logic use cases
├── presentation/              # Presentation layer
│   ├── cubit/                 # State management (Cubit & States)
│   ├── pages/                 # Screen widgets
│   └── widgets/               # Reusable UI components
└── injection_container.dart   # Dependency injection setup
```

## Architecture

This application follows **Clean Architecture** principles:

### Data Layer
- **AnimeRemoteDataSource**: Fetches data from Jikan API
- **AnimeLocalDataSource**: Handles local caching with SharedPreferences
- **AnimeRepositoryImpl**: Implements repository contract, handles data flow

### Domain Layer
- **Anime**: Core business entity (pure Dart)
- **AnimeRepository**: Abstract repository contract
- **GetTopAnime**: Use case for fetching anime data

### Presentation Layer
- **AnimeCubit**: Manages UI state using Cubit pattern
- **AnimeListPage**: Main screen displaying anime grid
- **AnimeCard**: Reusable widget for anime items

## API Integration

The app integrates with the [Jikan API](https://api.jikan.moe/v3/top/anime/1/upcoming) to fetch top upcoming anime data.

## Dependencies

### Core Dependencies
- **flutter_bloc**: State management with Cubit
- **get_it**: Dependency injection
- **dio**: HTTP client for API calls
- **dartz**: Functional programming (Either type)
- **equatable**: Value equality comparison

### UI Dependencies
- **cached_network_image**: Image caching and loading
- **shimmer**: Loading placeholder animations
- **url_launcher**: External link handling

### Development Dependencies
- **bloc_test**: Testing Cubit state changes
- **mocktail**: Mocking for unit tests
- **build_runner**: Code generation
- **json_serializable**: JSON serialization

## Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK (3.8.1 or higher)

### Installation

1. Clone the repository
2. Navigate to the flutter directory:
   ```bash
   cd flutter
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Generate code (if needed):
   ```bash
   flutter packages pub run build_runner build
   ```

5. Run the app:
   ```bash
   flutter run
   ```

## Testing

### Run Unit Tests
```bash
flutter test
```

### Run Widget Tests
```bash
flutter test test/widget_test.dart
```

### Run All Tests with Coverage
```bash
flutter test --coverage
```

## State Management

The app uses **Cubit** for state management with the following states:

- **AnimeInitial**: Initial state when app starts
- **AnimeLoading**: Data is being fetched
- **AnimeLoaded**: Data successfully loaded
- **AnimeError**: Error occurred during data fetching

## Offline Capability

The app provides offline functionality through:

1. **Cache Strategy**: Data is cached locally using SharedPreferences
2. **Cache Validity**: Cache expires after 24 hours
3. **Fallback**: If network fails, app shows cached data
4. **Refresh**: Pull-to-refresh forces fresh data fetch

## Comparison with Android Version

| Android (Kotlin) | Flutter (Dart) |
|-----------------|----------------|
| MVVM + Repository | Clean Architecture |
| ViewModel | Cubit |
| LiveData | Cubit States |
| Retrofit | Dio |
| Room Database | SharedPreferences |
| RecyclerView | GridView.builder |
| Glide | CachedNetworkImage |
| Dagger | get_it |

## Build & Deployment

### Android APK
```bash
flutter build apk --release
```

### iOS IPA
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## Contributing

1. Follow the existing code structure and naming conventions
2. Write tests for new features
3. Ensure code passes linting checks
4. Update documentation for significant changes

## License

This project is licensed under the MIT License - see the original project's LICENSE file for details.
