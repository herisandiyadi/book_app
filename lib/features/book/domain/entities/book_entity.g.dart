// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthorEntityImpl _$$AuthorEntityImplFromJson(Map<String, dynamic> json) =>
    _$AuthorEntityImpl(
      name: json['name'] as String,
      birthYear: (json['birthYear'] as num?)?.toInt(),
      deathYear: (json['deathYear'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$AuthorEntityImplToJson(_$AuthorEntityImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'birthYear': instance.birthYear,
      'deathYear': instance.deathYear,
    };
