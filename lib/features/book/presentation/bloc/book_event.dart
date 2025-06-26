import 'package:equatable/equatable.dart';

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
}

class GetBookDetail extends BookEvent {
  final int id;

  const GetBookDetail(this.id);
}

class LikeBook extends BookEvent {
  final int id;

  const LikeBook(this.id);
}

class DislikeBook extends BookEvent {
  final int id;

  const DislikeBook(this.id);
}

class FetchLikedBooks extends BookEvent {}
