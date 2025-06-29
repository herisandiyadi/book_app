import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:palm_book_app/features/book/domain/usecases/get_book_detail.dart';
import 'package:palm_book_app/features/book/domain/entities/book_entity.dart';
import 'package:palm_book_app/features/book/domain/repository/book_repository.dart';

class MockBookRepository extends Mock implements BookRepository {}

void main() {
  late GetBookDetail usecase;
  late MockBookRepository mockRepository;

  setUp(() {
    mockRepository = MockBookRepository();
    usecase = GetBookDetail(mockRepository);
  });

  test('should return BookEntity from repository', () async {
    final book = BookEntity(
      id: 1,
      title: 'Test Book',
      authors: [],
      coverImage: 'url',
      description: 'desc',
      isLiked: false,
    );
    when(
      () => mockRepository.getBookDetail(1),
    ).thenAnswer((_) async => Right(book));

    final result = await usecase(1);

    expect(result, Right(book));
    verify(() => mockRepository.getBookDetail(1)).called(1);
  });

  test('should return Failure from repository', () async {
    final failure = Failure('error');
    when(
      () => mockRepository.getBookDetail(1),
    ).thenAnswer((_) async => Left(failure));

    final result = await usecase(1);

    expect(result, Left(failure));
    verify(() => mockRepository.getBookDetail(1)).called(1);
  });
}
