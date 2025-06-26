import 'package:dartz/dartz.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/repository/book_repository.dart';
import '../model/book_model.dart';
import '../datasource/remote_datasource.dart';
import '../datasource/local_datasource.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;
  final BookLocalDataSource localDataSource;

  BookRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<BookEntity>>> getBooks({
    int page = 1,
    String? query,
  }) async {
    try {
      final books = await remoteDataSource.fetchBooks(page: page, query: query);
      final likedBooks = await localDataSource.getLikedBooks();
      final likedIds = likedBooks.map((b) => b.id).toSet();
      return Right(
        books.map((b) => b.toEntity(isLiked: likedIds.contains(b.id))).toList(),
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BookEntity>> getBookDetail(int id) async {
    try {
      final book = await remoteDataSource.fetchBookDetail(id);
      final isLiked = await localDataSource.isBookLiked(id);
      return Right(book.toEntity(isLiked: isLiked));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> likeBook(BookEntity book) async {
    try {
      await localDataSource.likeBook(BookModelMapper.fromEntity(book));
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> dislikeBook(BookEntity book) async {
    try {
      await localDataSource.dislikeBook(book.id);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getLikedBooks() async {
    try {
      final books = await localDataSource.getLikedBooks();
      return Right(books.map((b) => b.toEntity(isLiked: true)).toList());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
