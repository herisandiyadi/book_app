import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_entity.freezed.dart';
part 'book_entity.g.dart';

@freezed
class BookEntity with _$BookEntity {
  const factory BookEntity({
    required int id,
    required String title,
    required List<AuthorEntity> authors,
    String? coverImage,
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
    required bool isLiked,
  }) = _BookEntity;
}

@freezed
class AuthorEntity with _$AuthorEntity {
  @JsonSerializable(explicitToJson: true)
  const factory AuthorEntity({
    required String name,
    int? birthYear,
    int? deathYear,
  }) = _AuthorEntity;

  factory AuthorEntity.fromJson(Map<String, dynamic> json) =>
      _$AuthorEntityFromJson(json);
}
