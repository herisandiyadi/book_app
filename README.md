# Palm Book App

A modern Flutter app for browsing, searching, and managing books using the Gutendex API, with a robust futuristic design system, theme switching, and comprehensive testing.

---

## ✨ Features

- **Browse Books**: Responsive grid with cover images, titles, and authors.
- **Search**: Real-time search by title or author with a stylish search bar.
- **Book Details**: View detailed info (title, authors, summaries, description, subjects, bookshelves, languages, copyright, media type, formats, download count).
- **Like/Unlike Books**: Persistent local storage (sqflite) for liked books.
- **Liked Books Page**: Manage and view your liked books.
- **Theme Switching**: Toggle between light and dark mode with a single tap.
- **Futuristic Design System**: Neon blue, electric purple, and dark backgrounds, with glowing accents and modern UI.
- **Shimmer Loading**: Smooth loading indicators for lists and images.
- **SafeArea & Responsive**: All screens are SafeArea-wrapped and adapt to different devices.
- **Widgetbook Integration**: Preview and test design system components in isolation.

---

## 🎨 Design System

- **Palette**:  
  - Neon Blue: `#00FFF7`
  - Electric Purple: `#9D00FF`
  - Deep Navy: `#0A0F2C`
  - Charcoal: `#181A2A`
  - Neon Magenta (Error): `#FF005C`
  - Surface (Light): `#F2F6FF`
- **Typography**: Poppins font via Google Fonts.
- **Theme Switching**:  
  - All UI elements (cards, search, backgrounds, icons) adapt to light/dark mode.
  - Theme switcher in the Home AppBar.
- **Component Highlights**:
  - Cards and search fields use theme-based surface colors.
  - AppBar and buttons use neon accents and glowing shadows.
  - Consistent use of ColorScheme and ThemeData for all widgets.

---

## 🧑‍💻 Architecture

- **Presentation**: Bloc pattern for state management, GoRouter for navigation, modular widgets.
- **Domain**: Usecases for business logic, entities for data structure.
- **Data**: Repository pattern, remote datasource (Gutendex API), local datasource (sqflite).
- **Dependency Injection**: get_it for service locator.

---

## 🚀 Setup

1. **Clone the repo**
   ```sh
   git clone https://github.com/herisandiyadi/book_app.git
   cd palm_book_app
   ```

2. **Install dependencies**
   ```sh
   flutter pub get
   ```

3. **Setup environment**
   - Copy `.env.example` to `.env` and set `API_BASE_URL` (default: `https://gutendex.com/books`)
   - Example:
     ```
     API_BASE_URL=https://gutendex.com/books
     ```

4. **Generate code (Freezed, JsonSerializable)**
   ```sh
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. **Run the app**
   ```sh
   flutter run
   ```

6. **Widgetbook (Design System Preview)**
   ```sh
   flutter run -t widgetbook/widgetbook.dart
   ```

---

## 🧪 Testing

- **Unit Tests**:  
  - Repository, datasource, usecase, and model mapping.
  - Example files:  
    - `test/unit_test/book_repository_impl_test.dart`
    - `test/unit_test/book_remote_datasource_test.dart`
    - `test/unit_test/get_books_test.dart`
    - `test/unit_test/get_book_detail_test.dart`
    - `test/unit_test/like_book_test.dart`
    - `test/unit_test/dislike_book_test.dart`
    - `test/unit_test/get_liked_books_test.dart`
- **Widget Tests**:  
  - Main screens, Bloc, and UI components.
  - Example: `test/widget_test.dart`
- **Run all tests:**
  ```sh
  flutter test
  ```

---

## 🛠 Tech Stack

- Flutter 3.x
- flutter_bloc, freezed, json_serializable, sqflite, get_it, go_router, google_fonts, shimmer, cached_network_image, mockito, widgetbook

---

## 🌐 API

- [Gutendex API](https://gutendex.com/)
- Supports all major fields: id, title, authors, summaries, subjects, bookshelves, languages, copyright, media_type, formats, download_count.

---

## 📁 Folder Structure

```
lib/
  core/
    design_system/
      theme.dart
  features/
    book/
      data/
        datasource/
        model/
        repository/
      domain/
        entities/
        repository/
        usecases/
      presentation/
        bloc/
        pages/
  injection/
  route_observer.dart
  app.dart
  main.dart
  main_dev.dart
  main_staging.dart
  main_production.dart
test/
  unit_test/
    book_repository_impl_test.dart
    book_remote_datasource_test.dart
    get_books_test.dart
    get_book_detail_test.dart
    like_book_test.dart
    dislike_book_test.dart
    get_liked_books_test.dart
  widget_test.dart
widgetbook/
  widgetbook.dart
```

---

## 📄 License

MIT
