import 'package:equatable/equatable.dart';

import '../../domain/entities/book_entity.dart';

abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object?> get props => [];
}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookLoaded extends BookState {
  final List<BookEntity> books;
  final bool hasReachedMax;
  final int currentPage;

  const BookLoaded({
    required this.books,
    required this.hasReachedMax,
    required this.currentPage,
  });

  BookLoaded copyWith({
    List<BookEntity>? books,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return BookLoaded(
      books: books ?? this.books,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [books, hasReachedMax, currentPage];
}

class BookError extends BookState {
  final String message;

  const BookError(this.message);

  @override
  List<Object?> get props => [message];
}

class BookDetailLoaded extends BookState {
  final BookEntity book;

  const BookDetailLoaded(this.book);

  @override
  List<Object?> get props => [book];
}

class LikedBooksLoaded extends BookState {
  final List<BookEntity> books;

  const LikedBooksLoaded(this.books);

  @override
  List<Object?> get props => [books];
}
