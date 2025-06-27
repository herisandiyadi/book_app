import 'package:equatable/equatable.dart';
import '../../domain/entities/book_entity.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object?> get props => [];
}

class FetchBooks extends BookEvent {
  final int page;
  final String? query;

  const FetchBooks({this.page = 1, this.query});
}

class FetchMoreBooks extends BookEvent {
  final int page;
  final String? query;

  const FetchMoreBooks({required this.page, this.query});
}

class SearchBooks extends BookEvent {
  final String query;

  const SearchBooks(this.query);

  @override
  List<Object?> get props => [query];
}

class GetBookDetail extends BookEvent {
  final int id;

  const GetBookDetail(this.id);
}

class LikeBook extends BookEvent {
  final BookEntity book;

  const LikeBook(this.book);

  @override
  List<Object?> get props => [book];
}

class DislikeBook extends BookEvent {
  final BookEntity book;

  const DislikeBook(this.book);

  @override
  List<Object?> get props => [book];
}

class FetchLikedBooks extends BookEvent {}
