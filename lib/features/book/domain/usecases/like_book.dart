import 'package:dartz/dartz.dart';
import '../entities/book_entity.dart';
import '../repository/book_repository.dart';

class LikeBook {
  final BookRepository repository;

  LikeBook(this.repository);

  Future<Either<Failure, void>> call(BookEntity book) {
    return repository.likeBook(book);
  }
}
