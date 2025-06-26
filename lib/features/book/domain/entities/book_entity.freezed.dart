// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BookEntity {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<String> get authors => throw _privateConstructorUsedError;
  String? get coverImage => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get isLiked => throw _privateConstructorUsedError;

  /// Create a copy of BookEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookEntityCopyWith<BookEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookEntityCopyWith<$Res> {
  factory $BookEntityCopyWith(
    BookEntity value,
    $Res Function(BookEntity) then,
  ) = _$BookEntityCopyWithImpl<$Res, BookEntity>;
  @useResult
  $Res call({
    int id,
    String title,
    List<String> authors,
    String? coverImage,
    String? description,
    bool isLiked,
  });
}

/// @nodoc
class _$BookEntityCopyWithImpl<$Res, $Val extends BookEntity>
    implements $BookEntityCopyWith<$Res> {
  _$BookEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? authors = null,
    Object? coverImage = freezed,
    Object? description = freezed,
    Object? isLiked = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            authors: null == authors
                ? _value.authors
                : authors // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            coverImage: freezed == coverImage
                ? _value.coverImage
                : coverImage // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            isLiked: null == isLiked
                ? _value.isLiked
                : isLiked // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BookEntityImplCopyWith<$Res>
    implements $BookEntityCopyWith<$Res> {
  factory _$$BookEntityImplCopyWith(
    _$BookEntityImpl value,
    $Res Function(_$BookEntityImpl) then,
  ) = __$$BookEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String title,
    List<String> authors,
    String? coverImage,
    String? description,
    bool isLiked,
  });
}

/// @nodoc
class __$$BookEntityImplCopyWithImpl<$Res>
    extends _$BookEntityCopyWithImpl<$Res, _$BookEntityImpl>
    implements _$$BookEntityImplCopyWith<$Res> {
  __$$BookEntityImplCopyWithImpl(
    _$BookEntityImpl _value,
    $Res Function(_$BookEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BookEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? authors = null,
    Object? coverImage = freezed,
    Object? description = freezed,
    Object? isLiked = null,
  }) {
    return _then(
      _$BookEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        authors: null == authors
            ? _value._authors
            : authors // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        coverImage: freezed == coverImage
            ? _value.coverImage
            : coverImage // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        isLiked: null == isLiked
            ? _value.isLiked
            : isLiked // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$BookEntityImpl implements _BookEntity {
  const _$BookEntityImpl({
    required this.id,
    required this.title,
    required final List<String> authors,
    required this.coverImage,
    required this.description,
    required this.isLiked,
  }) : _authors = authors;

  @override
  final int id;
  @override
  final String title;
  final List<String> _authors;
  @override
  List<String> get authors {
    if (_authors is EqualUnmodifiableListView) return _authors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_authors);
  }

  @override
  final String? coverImage;
  @override
  final String? description;
  @override
  final bool isLiked;

  @override
  String toString() {
    return 'BookEntity(id: $id, title: $title, authors: $authors, coverImage: $coverImage, description: $description, isLiked: $isLiked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._authors, _authors) &&
            (identical(other.coverImage, coverImage) ||
                other.coverImage == coverImage) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    const DeepCollectionEquality().hash(_authors),
    coverImage,
    description,
    isLiked,
  );

  /// Create a copy of BookEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookEntityImplCopyWith<_$BookEntityImpl> get copyWith =>
      __$$BookEntityImplCopyWithImpl<_$BookEntityImpl>(this, _$identity);
}

abstract class _BookEntity implements BookEntity {
  const factory _BookEntity({
    required final int id,
    required final String title,
    required final List<String> authors,
    required final String? coverImage,
    required final String? description,
    required final bool isLiked,
  }) = _$BookEntityImpl;

  @override
  int get id;
  @override
  String get title;
  @override
  List<String> get authors;
  @override
  String? get coverImage;
  @override
  String? get description;
  @override
  bool get isLiked;

  /// Create a copy of BookEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookEntityImplCopyWith<_$BookEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
