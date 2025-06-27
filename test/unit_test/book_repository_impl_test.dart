import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:palm_book_app/features/book/data/repository/book_repository_impl.dart';
import 'package:palm_book_app/features/book/data/model/book_model.dart';
import 'package:palm_book_app/features/book/data/datasource/remote_datasource.dart';
import 'package:palm_book_app/features/book/data/datasource/local_datasource.dart';
import 'package:palm_book_app/features/book/domain/entities/book_entity.dart';

class MockRemoteDataSource extends Mock implements BookRemoteDataSource {}

class MockLocalDataSource extends Mock implements BookLocalDataSource {}

void main() {
  late BookRepositoryImpl repository;
  late MockRemoteDataSource mockRemote;
  late MockLocalDataSource mockLocal;

  setUp(() {
    mockRemote = MockRemoteDataSource();
    mockLocal = MockLocalDataSource();
    repository = BookRepositoryImpl(
      remoteDataSource: mockRemote,
      localDataSource: mockLocal,
    );
  });

  test('getBooks returns list of BookEntity with isLiked info', () async {
    final bookModel = BookModel(
      id: 1,
      title: 'Test Book',
      authors: [AuthorEntity(name: 'Author')],
      coverImage: 'url',
      description: 'desc',
    );
    when(
      mockRemote.fetchBooks(page: 1, query: null),
    ).thenAnswer((_) async => [bookModel]);
    when(mockLocal.getLikedBooks()).thenAnswer((_) async => []);

    final result = await repository.getBooks(page: 1);

    expect(result.isRight(), true);
    result.fold((_) => fail('Should not fail'), (books) {
      expect(books.length, 1);
      expect(books.first.title, 'Test Book');
      expect(books.first.isLiked, false);
    });
  });

  test('likeBook calls localDataSource.likeBook', () async {
    final book = BookEntity(
      id: 1,
      title: 'Test Book',
      authors: [AuthorEntity(name: 'Author')],
      coverImage: 'url',
      description: 'desc',
      isLiked: true,
    );
    when(mockLocal.likeBook(any)).thenAnswer((_) async => null);

    final result = await repository.likeBook(book);

    expect(result.isRight(), true);
    verify(mockLocal.likeBook(any)).called(1);
  });
}
