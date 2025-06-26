import 'package:dartz/dartz.dart';
import '../entities/book_entity.dart';
import '../repository/book_repository.dart';

class GetBooks {
  final BookRepository repository;

  GetBooks(this.repository);

  Future<Either<Failure, List<BookEntity>>> call({
    int page = 1,
    String? query,
  }) {
    return repository.getBooks(page: page, query: query);
  }
}
