import 'package:dartz/dartz.dart';
import '../entities/book_entity.dart';
import '../repository/book_repository.dart';

class GetLikedBooks {
  final BookRepository repository;

  GetLikedBooks(this.repository);

  Future<Either<Failure, List<BookEntity>>> call() {
    return repository.getLikedBooks();
  }
}
