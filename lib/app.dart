import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'flavors.dart';
import 'features/book/presentation/pages/home_screen.dart';
import 'features/book/presentation/pages/book_detail_screen.dart';
import 'features/book/presentation/pages/liked_books_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/book/presentation/bloc/book_bloc.dart';
import 'features/book/presentation/bloc/book_event.dart';
import 'injection/injection.dart';
import 'package:go_router/go_router.dart';
import 'core/design_system/theme.dart';

/// ThemeSwitcher for toggling light/dark mode
class ThemeSwitcher extends InheritedWidget {
  final ValueNotifier<ThemeMode> themeMode;

  ThemeSwitcher({Key? key, required Widget child})
    : themeMode = ValueNotifier(ThemeMode.dark),
      super(key: key, child: child);

  static ThemeSwitcher of(BuildContext context) {
    final ThemeSwitcher? result = context
        .dependOnInheritedWidgetOfExactType<ThemeSwitcher>();
    assert(result != null, 'No ThemeSwitcher found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ThemeSwitcher oldWidget) =>
      themeMode != oldWidget.themeMode;
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) =>
              _flavorBanner(child: HomeScreen(), show: kDebugMode),
          routes: [
            GoRoute(
              path: 'detail/:id',
              builder: (context, state) {
                final id = int.tryParse(state.pathParameters['id'] ?? '');
                if (id == null) {
                  return const Scaffold(
                    body: Center(child: Text('Invalid book id')),
                  );
                }
                return BookDetailScreen(bookId: id);
              },
            ),
            GoRoute(
              path: 'liked',
              builder: (context, state) => const LikedBooksScreen(),
            ),
          ],
        ),
      ],
    );

    return BlocProvider(
      create: (_) => BookBloc(
        getBooks: sl(),
        getBookDetail: sl(),
        likeBook: sl(),
        dislikeBook: sl(),
        getLikedBooks: sl(),
      )..add(const FetchBooks()),
      child: ThemeSwitcher(
        child: Builder(
          builder: (context) {
            final themeMode = ThemeSwitcher.of(context).themeMode;
            return ValueListenableBuilder<ThemeMode>(
              valueListenable: themeMode,
              builder: (context, mode, _) {
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  title: F.title,
                  theme: appThemeLight,
                  darkTheme: appThemeDark,
                  themeMode: mode,
                  routerConfig: _router,
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _flavorBanner({required Widget child, bool show = true}) => show
      ? Banner(
          location: BannerLocation.topStart,
          message: F.name,
          color: Colors.green.withAlpha(150),
          textStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12.0,
            letterSpacing: 1.0,
          ),
          textDirection: TextDirection.ltr,
          child: child,
        )
      : Container(child: child);
}
