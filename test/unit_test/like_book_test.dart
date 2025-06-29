import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:palm_book_app/features/book/domain/usecases/like_book.dart';
import 'package:palm_book_app/features/book/domain/entities/book_entity.dart';
import 'package:palm_book_app/features/book/domain/repository/book_repository.dart';

class MockBookRepository extends Mock implements BookRepository {}

void main() {
  late LikeBook usecase;
  late MockBookRepository mockRepository;

  setUp(() {
    mockRepository = MockBookRepository();
    usecase = LikeBook(mockRepository);
  });

  test('should return void from repository', () async {
    final book = BookEntity(
      id: 1,
      title: 'Test Book',
      authors: [],
      coverImage: 'url',
      description: 'desc',
      isLiked: false,
    );
    when(
      () => mockRepository.likeBook(book),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase(book);

    expect(result, const Right(null));
    verify(() => mockRepository.likeBook(book)).called(1);
  });

  test('should return Failure from repository', () async {
    final book = BookEntity(
      id: 1,
      title: 'Test Book',
      authors: [],
      coverImage: 'url',
      description: 'desc',
      isLiked: false,
    );
    final failure = Failure('error');
    when(
      () => mockRepository.likeBook(book),
    ).thenAnswer((_) async => Left(failure));

    final result = await usecase(book);

    expect(result, Left(failure));
    verify(() => mockRepository.likeBook(book)).called(1);
  });
}
