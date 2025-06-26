import 'package:dartz/dartz.dart';
import '../entities/book_entity.dart';
import '../repository/book_repository.dart';

class GetBookDetail {
  final BookRepository repository;

  GetBookDetail(this.repository);

  Future<Either<Failure, BookEntity>> call(int id) {
    return repository.getBookDetail(id);
  }
}
