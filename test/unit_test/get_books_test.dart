import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:palm_book_app/features/book/domain/usecases/get_books.dart';
import 'package:palm_book_app/features/book/domain/entities/book_entity.dart';
import 'package:palm_book_app/features/book/domain/repository/book_repository.dart';

class MockBookRepository extends Mock implements BookRepository {}

void main() {
  late GetBooks usecase;
  late MockBookRepository mockRepository;

  setUp(() {
    mockRepository = MockBookRepository();
    usecase = GetBooks(mockRepository);
  });

  test('should return list of BookEntity from repository', () async {
    final books = [
      BookEntity(
        id: 1,
        title: 'Test Book',
        authors: [],
        coverImage: 'url',
        description: 'desc',
        isLiked: false,
      ),
    ];
    when(
      () => mockRepository.getBooks(page: 1, query: null),
    ).thenAnswer((_) async => Right(books));

    final result = await usecase(page: 1);

    expect(result, Right(books));
    verify(() => mockRepository.getBooks(page: 1, query: null)).called(1);
  });

  test('should return Failure from repository', () async {
    final failure = Failure('error');
    when(
      () => mockRepository.getBooks(page: 1, query: null),
    ).thenAnswer((_) async => Left(failure));

    final result = await usecase(page: 1);

    expect(result, Left(failure));
    verify(() => mockRepository.getBooks(page: 1, query: null)).called(1);
  });
}
