// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:palm_book_app/main.dart';
import 'package:palm_book_app/app.dart';
import 'package:palm_book_app/flavors.dart';
import 'package:palm_book_app/injection/injection.dart';
import 'package:palm_book_app/features/book/data/datasource/remote_datasource.dart';
import 'package:palm_book_app/features/book/presentation/pages/home_screen.dart';
import 'package:palm_book_app/features/book/presentation/pages/book_detail_screen.dart';
import 'package:palm_book_app/features/book/presentation/pages/liked_books_screen.dart';
import 'package:palm_book_app/features/book/presentation/bloc/book_bloc.dart';

class MockBookRemoteDataSource extends Mock implements BookRemoteDataSource {}

void main() {
  setUpAll(() async {
    F.appFlavor = Flavor.dev;
    await init();
    // Unregister and register mock for BookRemoteDataSource to avoid dotenv dependency
    sl.unregister<BookRemoteDataSource>();
    sl.registerLazySingleton<BookRemoteDataSource>(
      () => MockBookRemoteDataSource(),
    );
  });

  testWidgets('App can be pumped without error', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.byType(App), findsOneWidget);
  });

  testWidgets('HomeScreen can be pumped without error', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<BookBloc>(
          create: (_) => sl<BookBloc>(),
          child: HomeScreen(),
        ),
      ),
    );
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('BookDetailScreen can be pumped without error', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<BookBloc>(
          create: (_) => sl<BookBloc>(),
          child: BookDetailScreen(bookId: 1),
        ),
      ),
    );
    expect(find.byType(BookDetailScreen), findsOneWidget);
  });

  testWidgets('LikedBooksScreen can be pumped without error', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<BookBloc>(
          create: (_) => sl<BookBloc>(),
          child: LikedBooksScreen(),
        ),
      ),
    );
    expect(find.byType(LikedBooksScreen), findsOneWidget);
  });
}
