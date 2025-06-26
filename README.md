# Palm Book App

Palm Book App is a Flutter application for browsing, searching, and managing a collection of books. Users can view book details, like/unlike books, and see their liked books. The app is built with clean architecture principles, supports multiple environments (dev, staging, production), and uses BLoC for state management and GoRouter for navigation.

## Features

- Browse a paginated list of books with cover images and authors
- Search books by title or author
- View detailed information for each book
- Like or unlike books, with persistence
- View a list of liked books
- Responsive UI with loading and error states
- Environment-based configuration (dev, staging, production)
- Clean architecture: separation of data, domain, and presentation layers

## Project Structure

```
lib/
├── app.dart                # App root, GoRouter setup, BLoC provider
├── main.dart               # Main entry (default)
├── main_dev.dart           # Entry for dev flavor
├── main_staging.dart       # Entry for staging flavor
├── main_production.dart    # Entry for production flavor
├── flavors.dart            # Flavor enum and config
├── features/
│   └── book/
│       ├── data/           # Data sources, models, repository implementation
│       ├── domain/         # Entities, repository interface, use cases
│       └── presentation/   # BLoC, UI pages, widgets
├── injection/              # Dependency injection setup
├── route_observer.dart     # (Legacy) Route observer
```

## Key Dependencies

- [flutter_bloc](https://pub.dev/packages/flutter_bloc) - State management
- [go_router](https://pub.dev/packages/go_router) - Declarative routing
- [freezed](https://pub.dev/packages/freezed) - Data classes and unions
- [get_it](https://pub.dev/packages/get_it) - Dependency injection
- [dartz](https://pub.dev/packages/dartz) - Functional programming utilities
- [sqflite](https://pub.dev/packages/sqflite) - Local persistence for liked books
- [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) - Environment variables

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart 3.8.1 or higher

### Setup

1. **Clone the repository:**
   ```sh
   git clone <repo-url>
   cd palm_book_app
   ```

2. **Install dependencies:**
   ```sh
   flutter pub get
   ```

3. **Environment files:**
   - The app uses environment files for configuration. Example files:
     - `.env`
     - `dev.env`
     - `staging.env`
     - `production.env`
   - Make sure `production.env` is included in the `pubspec.yaml` assets:
     ```yaml
     flutter:
       assets:
         - production.env
     ```
   - You can add API keys or other config in these files.

4. **iOS/Android setup:**
   - For iOS, run `pod install` in the `ios/` directory if needed.
   - For Android, no extra steps are required.

### Running the App

#### Default (dev) environment

```sh
flutter run -t lib/main_dev.dart
```

#### Staging environment

```sh
flutter run -t lib/main_staging.dart
```

#### Production environment

```sh
flutter run -t lib/main_production.dart
```

You can also use your IDE's Flutter run configuration and select the appropriate entrypoint.

### Building for Release

- **Android:**
  ```sh
  flutter build apk -t lib/main_production.dart
  ```
- **iOS:**
  ```sh
  flutter build ios -t lib/main_production.dart
  ```

## Environment Variables

- Place your environment variables in the appropriate `.env` file.
- Example (`production.env`):
  ```
  API_URL=https://api.example.com
  ```

## Architecture

- **Presentation Layer:** UI widgets, pages, and BLoC for state management.
- **Domain Layer:** Entities, repository interfaces, and use cases.
- **Data Layer:** Repository implementations, data sources (remote/local), and models.
- **Navigation:** GoRouter with declarative route definitions.
- **State Management:** BLoC pattern with flutter_bloc.

## How Liking/Unliking Works

- Liked books are persisted locally using `sqflite`.
- The like status is merged with remote data on every fetch.
- Liking/unliking a book in the detail or home screen updates the local data and is reflected in the UI after refresh.

## Contributing

Contributions are welcome! Please open issues or submit pull requests for improvements or bug fixes.

## License

This project is licensed under the MIT License.
