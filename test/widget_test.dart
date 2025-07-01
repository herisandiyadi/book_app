// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import 'package:palm_book_app/features/book/presentation/pages/home_screen.dart';
import 'package:palm_book_app/features/book/presentation/bloc/book_bloc.dart';
import 'package:palm_book_app/features/book/presentation/bloc/book_event.dart';
import 'package:palm_book_app/features/book/presentation/bloc/book_state.dart';
import 'package:palm_book_app/features/book/domain/entities/book_entity.dart';
import 'package:palm_book_app/app.dart';

class MockBookBloc extends Mock implements BookBloc {}

class FakeBookEvent extends Fake implements BookEvent {}

class FakeBookState extends Fake implements BookState {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeBookEvent());
    registerFallbackValue(FakeBookState());
  });

  late MockBookBloc mockBookBloc;

  setUp(() {
    mockBookBloc = MockBookBloc();
    // Mock stream agar tidak null
    when(
      () => mockBookBloc.stream,
    ).thenAnswer((_) => const Stream<BookState>.empty());
    // Mock add agar bisa diverify
    when(() => mockBookBloc.add(any())).thenReturn(null);
  });

  Widget makeTestableWidget(Widget child) {
    return ThemeSwitcher(
      child: MaterialApp(
        home: BlocProvider<BookBloc>.value(value: mockBookBloc, child: child),
      ),
    );
  }

  testWidgets('Menampilkan shimmer loading saat BookLoading', (tester) async {
    when(() => mockBookBloc.state).thenReturn(BookLoading());
    await tester.pumpWidget(makeTestableWidget(HomeScreen()));
    expect(find.byType(Shimmer), findsWidgets);
  });

  testWidgets('Menampilkan grid buku saat BookLoaded', (tester) async {
    final books = [
      BookEntity(
        id: 1,
        title: 'Buku Satu',
        authors: [AuthorEntity(name: 'Penulis A')],
        coverImage: null,
        isLiked: false,
      ),
      BookEntity(
        id: 2,
        title: 'Buku Dua',
        authors: [AuthorEntity(name: 'Penulis B')],
        coverImage: null,
        isLiked: true,
      ),
    ];
    when(
      () => mockBookBloc.state,
    ).thenReturn(BookLoaded(books: books, hasReachedMax: true, currentPage: 1));
    await tester.pumpWidget(makeTestableWidget(HomeScreen()));
    expect(find.text('Buku Satu'), findsOneWidget);
    expect(find.text('Buku Dua'), findsOneWidget);
    // Ikon favorite di AppBar dan di card buku, jadi harus ada 2
    expect(find.byIcon(Icons.favorite), findsNWidgets(2));
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
  });

  testWidgets('Menampilkan pesan "No books found." jika data kosong', (
    tester,
  ) async {
    when(
      () => mockBookBloc.state,
    ).thenReturn(BookLoaded(books: [], hasReachedMax: true, currentPage: 1));
    await tester.pumpWidget(makeTestableWidget(HomeScreen()));
    expect(find.text('No books found.'), findsOneWidget);
  });

  testWidgets('Menampilkan pesan error saat BookError', (tester) async {
    when(() => mockBookBloc.state).thenReturn(BookError('Gagal memuat data'));
    await tester.pumpWidget(makeTestableWidget(HomeScreen()));
    expect(find.textContaining('Gagal memuat data'), findsOneWidget);
  });

  testWidgets('Mengirim event SearchBooks saat search', (tester) async {
    when(
      () => mockBookBloc.state,
    ).thenReturn(BookLoaded(books: [], hasReachedMax: true, currentPage: 1));
    await tester.pumpWidget(makeTestableWidget(HomeScreen()));
    final searchField = find.byType(TextField);
    expect(searchField, findsOneWidget);
    await tester.enterText(searchField, 'flutter');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    verify(() => mockBookBloc.add(SearchBooks('flutter'))).called(1);
  });
}
