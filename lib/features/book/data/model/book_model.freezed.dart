// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BookModel _$BookModelFromJson(Map<String, dynamic> json) {
  return _BookModel.fromJson(json);
}

/// @nodoc
mixin _$BookModel {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<AuthorEntity> get authors => throw _privateConstructorUsedError;
  @JsonKey(name: 'cover_image')
  String? get coverImage => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String>? get summaries => throw _privateConstructorUsedError;
  List<String>? get translators => throw _privateConstructorUsedError;
  List<String>? get subjects => throw _privateConstructorUsedError;
  List<String>? get bookshelves => throw _privateConstructorUsedError;
  List<String>? get languages => throw _privateConstructorUsedError;
  bool? get copyright => throw _privateConstructorUsedError;
  String? get mediaType => throw _privateConstructorUsedError;
  Map<String, String>? get formats => throw _privateConstructorUsedError;
  int? get downloadCount => throw _privateConstructorUsedError;

  /// Serializes this BookModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookModelCopyWith<BookModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookModelCopyWith<$Res> {
  factory $BookModelCopyWith(BookModel value, $Res Function(BookModel) then) =
      _$BookModelCopyWithImpl<$Res, BookModel>;
  @useResult
  $Res call({
    int id,
    String title,
    List<AuthorEntity> authors,
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
  });
}

/// @nodoc
class _$BookModelCopyWithImpl<$Res, $Val extends BookModel>
    implements $BookModelCopyWith<$Res> {
  _$BookModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? authors = null,
    Object? coverImage = freezed,
    Object? description = freezed,
    Object? summaries = freezed,
    Object? translators = freezed,
    Object? subjects = freezed,
    Object? bookshelves = freezed,
    Object? languages = freezed,
    Object? copyright = freezed,
    Object? mediaType = freezed,
    Object? formats = freezed,
    Object? downloadCount = freezed,
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
                      as List<AuthorEntity>,
            coverImage: freezed == coverImage
                ? _value.coverImage
                : coverImage // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            summaries: freezed == summaries
                ? _value.summaries
                : summaries // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            translators: freezed == translators
                ? _value.translators
                : translators // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            subjects: freezed == subjects
                ? _value.subjects
                : subjects // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            bookshelves: freezed == bookshelves
                ? _value.bookshelves
                : bookshelves // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            languages: freezed == languages
                ? _value.languages
                : languages // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            copyright: freezed == copyright
                ? _value.copyright
                : copyright // ignore: cast_nullable_to_non_nullable
                      as bool?,
            mediaType: freezed == mediaType
                ? _value.mediaType
                : mediaType // ignore: cast_nullable_to_non_nullable
                      as String?,
            formats: freezed == formats
                ? _value.formats
                : formats // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>?,
            downloadCount: freezed == downloadCount
                ? _value.downloadCount
                : downloadCount // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BookModelImplCopyWith<$Res>
    implements $BookModelCopyWith<$Res> {
  factory _$$BookModelImplCopyWith(
    _$BookModelImpl value,
    $Res Function(_$BookModelImpl) then,
  ) = __$$BookModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String title,
    List<AuthorEntity> authors,
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
  });
}

/// @nodoc
class __$$BookModelImplCopyWithImpl<$Res>
    extends _$BookModelCopyWithImpl<$Res, _$BookModelImpl>
    implements _$$BookModelImplCopyWith<$Res> {
  __$$BookModelImplCopyWithImpl(
    _$BookModelImpl _value,
    $Res Function(_$BookModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? authors = null,
    Object? coverImage = freezed,
    Object? description = freezed,
    Object? summaries = freezed,
    Object? translators = freezed,
    Object? subjects = freezed,
    Object? bookshelves = freezed,
    Object? languages = freezed,
    Object? copyright = freezed,
    Object? mediaType = freezed,
    Object? formats = freezed,
    Object? downloadCount = freezed,
  }) {
    return _then(
      _$BookModelImpl(
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
                  as List<AuthorEntity>,
        coverImage: freezed == coverImage
            ? _value.coverImage
            : coverImage // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        summaries: freezed == summaries
            ? _value._summaries
            : summaries // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        translators: freezed == translators
            ? _value._translators
            : translators // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        subjects: freezed == subjects
            ? _value._subjects
            : subjects // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        bookshelves: freezed == bookshelves
            ? _value._bookshelves
            : bookshelves // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        languages: freezed == languages
            ? _value._languages
            : languages // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        copyright: freezed == copyright
            ? _value.copyright
            : copyright // ignore: cast_nullable_to_non_nullable
                  as bool?,
        mediaType: freezed == mediaType
            ? _value.mediaType
            : mediaType // ignore: cast_nullable_to_non_nullable
                  as String?,
        formats: freezed == formats
            ? _value._formats
            : formats // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>?,
        downloadCount: freezed == downloadCount
            ? _value.downloadCount
            : downloadCount // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BookModelImpl implements _BookModel {
  const _$BookModelImpl({
    required this.id,
    required this.title,
    final List<AuthorEntity> authors = const [],
    @JsonKey(name: 'cover_image') this.coverImage,
    this.description,
    final List<String>? summaries,
    final List<String>? translators,
    final List<String>? subjects,
    final List<String>? bookshelves,
    final List<String>? languages,
    this.copyright,
    this.mediaType,
    final Map<String, String>? formats,
    this.downloadCount,
  }) : _authors = authors,
       _summaries = summaries,
       _translators = translators,
       _subjects = subjects,
       _bookshelves = bookshelves,
       _languages = languages,
       _formats = formats;

  factory _$BookModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookModelImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  final List<AuthorEntity> _authors;
  @override
  @JsonKey()
  List<AuthorEntity> get authors {
    if (_authors is EqualUnmodifiableListView) return _authors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_authors);
  }

  @override
  @JsonKey(name: 'cover_image')
  final String? coverImage;
  @override
  final String? description;
  final List<String>? _summaries;
  @override
  List<String>? get summaries {
    final value = _summaries;
    if (value == null) return null;
    if (_summaries is EqualUnmodifiableListView) return _summaries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _translators;
  @override
  List<String>? get translators {
    final value = _translators;
    if (value == null) return null;
    if (_translators is EqualUnmodifiableListView) return _translators;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _subjects;
  @override
  List<String>? get subjects {
    final value = _subjects;
    if (value == null) return null;
    if (_subjects is EqualUnmodifiableListView) return _subjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _bookshelves;
  @override
  List<String>? get bookshelves {
    final value = _bookshelves;
    if (value == null) return null;
    if (_bookshelves is EqualUnmodifiableListView) return _bookshelves;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _languages;
  @override
  List<String>? get languages {
    final value = _languages;
    if (value == null) return null;
    if (_languages is EqualUnmodifiableListView) return _languages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? copyright;
  @override
  final String? mediaType;
  final Map<String, String>? _formats;
  @override
  Map<String, String>? get formats {
    final value = _formats;
    if (value == null) return null;
    if (_formats is EqualUnmodifiableMapView) return _formats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final int? downloadCount;

  @override
  String toString() {
    return 'BookModel(id: $id, title: $title, authors: $authors, coverImage: $coverImage, description: $description, summaries: $summaries, translators: $translators, subjects: $subjects, bookshelves: $bookshelves, languages: $languages, copyright: $copyright, mediaType: $mediaType, formats: $formats, downloadCount: $downloadCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._authors, _authors) &&
            (identical(other.coverImage, coverImage) ||
                other.coverImage == coverImage) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._summaries,
              _summaries,
            ) &&
            const DeepCollectionEquality().equals(
              other._translators,
              _translators,
            ) &&
            const DeepCollectionEquality().equals(other._subjects, _subjects) &&
            const DeepCollectionEquality().equals(
              other._bookshelves,
              _bookshelves,
            ) &&
            const DeepCollectionEquality().equals(
              other._languages,
              _languages,
            ) &&
            (identical(other.copyright, copyright) ||
                other.copyright == copyright) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            const DeepCollectionEquality().equals(other._formats, _formats) &&
            (identical(other.downloadCount, downloadCount) ||
                other.downloadCount == downloadCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    const DeepCollectionEquality().hash(_authors),
    coverImage,
    description,
    const DeepCollectionEquality().hash(_summaries),
    const DeepCollectionEquality().hash(_translators),
    const DeepCollectionEquality().hash(_subjects),
    const DeepCollectionEquality().hash(_bookshelves),
    const DeepCollectionEquality().hash(_languages),
    copyright,
    mediaType,
    const DeepCollectionEquality().hash(_formats),
    downloadCount,
  );

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookModelImplCopyWith<_$BookModelImpl> get copyWith =>
      __$$BookModelImplCopyWithImpl<_$BookModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookModelImplToJson(this);
  }
}

abstract class _BookModel implements BookModel {
  const factory _BookModel({
    required final int id,
    required final String title,
    final List<AuthorEntity> authors,
    @JsonKey(name: 'cover_image') final String? coverImage,
    final String? description,
    final List<String>? summaries,
    final List<String>? translators,
    final List<String>? subjects,
    final List<String>? bookshelves,
    final List<String>? languages,
    final bool? copyright,
    final String? mediaType,
    final Map<String, String>? formats,
    final int? downloadCount,
  }) = _$BookModelImpl;

  factory _BookModel.fromJson(Map<String, dynamic> json) =
      _$BookModelImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  List<AuthorEntity> get authors;
  @override
  @JsonKey(name: 'cover_image')
  String? get coverImage;
  @override
  String? get description;
  @override
  List<String>? get summaries;
  @override
  List<String>? get translators;
  @override
  List<String>? get subjects;
  @override
  List<String>? get bookshelves;
  @override
  List<String>? get languages;
  @override
  bool? get copyright;
  @override
  String? get mediaType;
  @override
  Map<String, String>? get formats;
  @override
  int? get downloadCount;

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookModelImplCopyWith<_$BookModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
