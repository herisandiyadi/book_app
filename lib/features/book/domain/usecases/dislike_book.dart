import 'package:dartz/dartz.dart';
import '../entities/book_entity.dart';
import '../repository/book_repository.dart';

class DislikeBook {
  final BookRepository repository;

  DislikeBook(this.repository);

  Future<Either<Failure, void>> call(BookEntity book) {
    return repository.dislikeBook(book);
  }
}
