import 'package:dartz/dartz.dart';

import '../entities/book_entity.dart';

abstract class BookRepository {
  Future<Either<Failure, List<BookEntity>>> getBooks({
    int page = 1,
    String? query,
  });
  Future<Either<Failure, BookEntity>> getBookDetail(int id);
  Future<Either<Failure, void>> likeBook(BookEntity book);
  Future<Either<Failure, void>> dislikeBook(BookEntity book);
  Future<Either<Failure, List<BookEntity>>> getLikedBooks();
}

class Failure {
  final String message;
  Failure(this.message);
}
