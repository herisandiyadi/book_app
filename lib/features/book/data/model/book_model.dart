import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:palm_book_app/features/book/domain/entities/book_entity.dart';

part 'book_model.freezed.dart';
part 'book_model.g.dart';

@freezed
class BookModel with _$BookModel {
  const factory BookModel({
    required int id,
    required String title,
    @Default([]) List<String> authors,
    @JsonKey(name: 'cover_image') String? coverImage,
    String? description,
  }) = _BookModel;

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);
}

// Extension for mapping between BookModel and BookEntity
extension BookModelMapper on BookModel {
  BookEntity toEntity({bool isLiked = false}) => BookEntity(
    id: id,
    title: title,
    authors: authors,
    coverImage: coverImage,
    description: description,
    isLiked: isLiked,
  );
  static BookModel fromEntity(BookEntity entity) => BookModel(
    id: entity.id,
    title: entity.title,
    authors: entity.authors,
    coverImage: entity.coverImage,
    description: entity.description,
  );
}
