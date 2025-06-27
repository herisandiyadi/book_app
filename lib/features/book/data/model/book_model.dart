import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:palm_book_app/features/book/domain/entities/book_entity.dart';

part 'book_model.freezed.dart';
part 'book_model.g.dart';

@freezed
class BookModel with _$BookModel {
  const factory BookModel({
    required int id,
    required String title,
    @Default([]) List<AuthorEntity> authors,
    @JsonKey(name: 'cover_image') String? coverImage,
    String? description,
    List<String>? summaries,
    List<String>? translators,
    List<String>? subjects,
    List<String>? bookshelves,
    List<String>? languages,
    bool? copyright,
    String? mediaType,
    Map<String, String>? formats,
    int? downloadCount,
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
    summaries: summaries,
    translators: translators,
    subjects: subjects,
    bookshelves: bookshelves,
    languages: languages,
    copyright: copyright,
    mediaType: mediaType,
    formats: formats,
    downloadCount: downloadCount,
    isLiked: isLiked,
  );
  static BookModel fromEntity(BookEntity entity) => BookModel(
    id: entity.id,
    title: entity.title,
    authors: entity.authors,
    coverImage: entity.coverImage,
    description: entity.description,
    summaries: entity.summaries,
    translators: entity.translators,
    subjects: entity.subjects,
    bookshelves: entity.bookshelves,
    languages: entity.languages,
    copyright: entity.copyright,
    mediaType: entity.mediaType,
    formats: entity.formats,
    downloadCount: entity.downloadCount,
  );
}
