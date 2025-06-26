import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_books.dart' as usecase;
import '../../domain/usecases/get_book_detail.dart' as usecase;
import '../../domain/usecases/like_book.dart' as usecase;
import '../../domain/usecases/dislike_book.dart' as usecase;
import '../../domain/usecases/get_liked_books.dart' as usecase;
import '../../domain/entities/book_entity.dart';
import 'book_event.dart';
import 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final usecase.GetBooks getBooks;
  final usecase.GetBookDetail getBookDetail;
  final usecase.LikeBook likeBook;
  final usecase.DislikeBook dislikeBook;
  final usecase.GetLikedBooks getLikedBooks;

  BookBloc({
    required this.getBooks,
    required this.getBookDetail,
    required this.likeBook,
    required this.dislikeBook,
    required this.getLikedBooks,
  }) : super(BookInitial()) {
    on<FetchBooks>(_onFetchBooks);
    on<FetchMoreBooks>(_onFetchMoreBooks);
    on<SearchBooks>(_onSearchBooks);
    on<GetBookDetail>(_onGetBookDetail);
    on<LikeBook>(_onLikeBook);
    on<DislikeBook>(_onDislikeBook);
    on<FetchLikedBooks>(_onFetchLikedBooks);
  }

  Future<void> _onFetchBooks(FetchBooks event, Emitter<BookState> emit) async {
    emit(BookLoading());
    final result = await getBooks(page: event.page, query: event.query);
    result.fold(
      (failure) => emit(BookError(failure.message)),
      (books) => emit(
        BookLoaded(
          books: books,
          hasReachedMax: books.isEmpty,
          currentPage: event.page,
        ),
      ),
    );
  }

  Future<void> _onFetchMoreBooks(
    FetchMoreBooks event,
    Emitter<BookState> emit,
  ) async {
    if (state is BookLoaded) {
      final currentState = state as BookLoaded;
      final result = await getBooks(page: event.page, query: event.query);
      result.fold((failure) => emit(BookError(failure.message)), (books) {
        if (books.isEmpty) {
          emit(currentState.copyWith(hasReachedMax: true));
        } else {
          emit(
            BookLoaded(
              books: currentState.books + books,
              hasReachedMax: false,
              currentPage: event.page,
            ),
          );
        }
      });
    }
  }

  Future<void> _onSearchBooks(
    SearchBooks event,
    Emitter<BookState> emit,
  ) async {
    emit(BookLoading());
    final result = await getBooks(page: 1);
    result.fold((failure) => emit(BookError(failure.message)), (books) {
      List<BookEntity> filteredBooks = books;
      final query = event.query?.trim().toLowerCase();
      if (query != null && query.isNotEmpty) {
        filteredBooks = books.where((book) {
          final titleMatch = book.title.toLowerCase().contains(query);
          final authorMatch = book.authors.any(
            (author) => author.toLowerCase().contains(query),
          );
          return titleMatch || authorMatch;
        }).toList();
      }
      emit(
        BookLoaded(
          books: filteredBooks,
          hasReachedMax: filteredBooks.isEmpty,
          currentPage: 1,
        ),
      );
    });
  }

  Future<void> _onGetBookDetail(
    GetBookDetail event,
    Emitter<BookState> emit,
  ) async {
    emit(BookLoading());
    final result = await getBookDetail(event.id);
    result.fold(
      (failure) => emit(BookError(failure.message)),
      (book) => emit(BookDetailLoaded(book)),
    );
  }

  Future<void> _onLikeBook(LikeBook event, Emitter<BookState> emit) async {
    if (state is BookLoaded) {
      final currentState = state as BookLoaded;
      final updatedBooks = currentState.books.map((book) {
        if (book.id == event.id) {
          return book.copyWith(isLiked: true);
        }
        return book;
      }).toList();
      emit(
        BookLoaded(
          books: updatedBooks,
          hasReachedMax: currentState.hasReachedMax,
          currentPage: currentState.currentPage,
        ),
      );
      final book = currentState.books.firstWhere(
        (BookEntity? b) => b?.id == event.id,
        orElse: () => throw Exception('Book not found'),
      );
      await likeBook(book.copyWith(isLiked: true));
    }
  }

  Future<void> _onDislikeBook(
    DislikeBook event,
    Emitter<BookState> emit,
  ) async {
    if (state is BookLoaded) {
      final currentState = state as BookLoaded;
      final updatedBooks = currentState.books.map((book) {
        if (book.id == event.id) {
          return book.copyWith(isLiked: false);
        }
        return book;
      }).toList();
      emit(
        BookLoaded(
          books: updatedBooks,
          hasReachedMax: currentState.hasReachedMax,
          currentPage: currentState.currentPage,
        ),
      );
      final book = currentState.books.firstWhere(
        (BookEntity? b) => b?.id == event.id,
        orElse: () => throw Exception('Book not found'),
      );
      await dislikeBook(book.copyWith(isLiked: false));
    } else if (state is LikedBooksLoaded) {
      final currentState = state as LikedBooksLoaded;
      final updatedBooks = currentState.books
          .where((book) => book.id != event.id)
          .toList();
      emit(LikedBooksLoaded(updatedBooks));
      final book = currentState.books.firstWhere(
        (BookEntity? b) => b?.id == event.id,
        orElse: () => throw Exception('Book not found'),
      );
      await dislikeBook(book.copyWith(isLiked: false));
    }
  }

  Future<void> _onFetchLikedBooks(
    FetchLikedBooks event,
    Emitter<BookState> emit,
  ) async {
    emit(BookLoading());
    final result = await getLikedBooks();
    result.fold(
      (failure) => emit(BookError(failure.message)),
      (books) => emit(LikedBooksLoaded(books)),
    );
  }
}
