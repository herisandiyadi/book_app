// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookModelImpl _$$BookModelImplFromJson(Map<String, dynamic> json) =>
    _$BookModelImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      authors:
          (json['authors'] as List<dynamic>?)
              ?.map((e) => AuthorEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      coverImage: json['cover_image'] as String?,
      description: json['description'] as String?,
      summaries: (json['summaries'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      translators: (json['translators'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      subjects: (json['subjects'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      bookshelves: (json['bookshelves'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      copyright: json['copyright'] as bool?,
      mediaType: json['mediaType'] as String?,
      formats: (json['formats'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      downloadCount: (json['downloadCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$BookModelImplToJson(_$BookModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'authors': instance.authors,
      'cover_image': instance.coverImage,
      'description': instance.description,
      'summaries': instance.summaries,
      'translators': instance.translators,
      'subjects': instance.subjects,
      'bookshelves': instance.bookshelves,
      'languages': instance.languages,
      'copyright': instance.copyright,
      'mediaType': instance.mediaType,
      'formats': instance.formats,
      'downloadCount': instance.downloadCount,
    };
