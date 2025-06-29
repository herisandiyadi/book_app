import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:palm_book_app/features/book/data/datasource/remote_datasource.dart';
import 'package:palm_book_app/features/book/data/model/book_model.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late BookRemoteDataSource dataSource;
  late MockHttpClient mockHttp;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    mockHttp = MockHttpClient();
    dataSource = BookRemoteDataSource(
      baseUrl: 'https://example.com/books',
      httpClient: mockHttp,
    );
  });

  test('fetchBooks returns list of BookModel', () async {
    final responseJson = {
      "results": [
        {
          "id": 1,
          "title": "Test Book",
          "authors": [
            {"name": "Author", "birth_year": 1900, "death_year": 1980},
          ],
          "formats": {"image/jpeg": "url"},
          "subjects": ["Fiction"],
        },
      ],
    };
    when(
      () => mockHttp.get(any()),
    ).thenAnswer((_) async => http.Response(jsonEncode(responseJson), 200));

    final books = await dataSource.fetchBooks(page: 1);

    expect(books, isA<List<BookModel>>());
    expect(books.first.title, "Test Book");
    expect(books.first.authors.first.name, "Author");
  });
}
