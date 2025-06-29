import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:palm_book_app/features/book/domain/usecases/get_liked_books.dart';
import 'package:palm_book_app/features/book/domain/entities/book_entity.dart';
import 'package:palm_book_app/features/book/domain/repository/book_repository.dart';

class MockBookRepository extends Mock implements BookRepository {}

void main() {
  late GetLikedBooks usecase;
  late MockBookRepository mockRepository;

  setUp(() {
    mockRepository = MockBookRepository();
    usecase = GetLikedBooks(mockRepository);
  });

  test('should return list of liked BookEntity from repository', () async {
    final books = [
      BookEntity(
        id: 1,
        title: 'Test Book',
        authors: [],
        coverImage: 'url',
        description: 'desc',
        isLiked: true,
      ),
    ];
    when(
      () => mockRepository.getLikedBooks(),
    ).thenAnswer((_) async => Right(books));

    final result = await usecase();

    expect(result, Right(books));
    verify(() => mockRepository.getLikedBooks()).called(1);
  });

  test('should return Failure from repository', () async {
    final failure = Failure('error');
    when(
      () => mockRepository.getLikedBooks(),
    ).thenAnswer((_) async => Left(failure));

    final result = await usecase();

    expect(result, Left(failure));
    verify(() => mockRepository.getLikedBooks()).called(1);
  });
}
