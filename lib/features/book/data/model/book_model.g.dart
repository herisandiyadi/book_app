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
              ?.map((e) => e as String)
              .toList() ??
          const [],
      coverImage: json['cover_image'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$BookModelImplToJson(_$BookModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'authors': instance.authors,
      'cover_image': instance.coverImage,
      'description': instance.description,
    };
