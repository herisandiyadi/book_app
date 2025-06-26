import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_entity.freezed.dart';

@freezed
class BookEntity with _$BookEntity {
  const factory BookEntity({
    required int id,
    required String title,
    required List<String> authors,
    required String? coverImage,
    required String? description,
    required bool isLiked,
  }) = _BookEntity;
}
