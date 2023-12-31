// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_post_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NewPostState {
  bool get fetching => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get author => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  File? get image => throw _privateConstructorUsedError;
  List<DateTime> get dates => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NewPostStateCopyWith<NewPostState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewPostStateCopyWith<$Res> {
  factory $NewPostStateCopyWith(
          NewPostState value, $Res Function(NewPostState) then) =
      _$NewPostStateCopyWithImpl<$Res, NewPostState>;
  @useResult
  $Res call(
      {bool fetching,
      String title,
      String author,
      String description,
      String category,
      String? location,
      File? image,
      List<DateTime> dates});
}

/// @nodoc
class _$NewPostStateCopyWithImpl<$Res, $Val extends NewPostState>
    implements $NewPostStateCopyWith<$Res> {
  _$NewPostStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fetching = null,
    Object? title = null,
    Object? author = null,
    Object? description = null,
    Object? category = null,
    Object? location = freezed,
    Object? image = freezed,
    Object? dates = null,
  }) {
    return _then(_value.copyWith(
      fetching: null == fetching
          ? _value.fetching
          : fetching // ignore: cast_nullable_to_non_nullable
              as bool,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
      dates: null == dates
          ? _value.dates
          : dates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NewPostStateCopyWith<$Res>
    implements $NewPostStateCopyWith<$Res> {
  factory _$$_NewPostStateCopyWith(
          _$_NewPostState value, $Res Function(_$_NewPostState) then) =
      __$$_NewPostStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool fetching,
      String title,
      String author,
      String description,
      String category,
      String? location,
      File? image,
      List<DateTime> dates});
}

/// @nodoc
class __$$_NewPostStateCopyWithImpl<$Res>
    extends _$NewPostStateCopyWithImpl<$Res, _$_NewPostState>
    implements _$$_NewPostStateCopyWith<$Res> {
  __$$_NewPostStateCopyWithImpl(
      _$_NewPostState _value, $Res Function(_$_NewPostState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fetching = null,
    Object? title = null,
    Object? author = null,
    Object? description = null,
    Object? category = null,
    Object? location = freezed,
    Object? image = freezed,
    Object? dates = null,
  }) {
    return _then(_$_NewPostState(
      fetching: null == fetching
          ? _value.fetching
          : fetching // ignore: cast_nullable_to_non_nullable
              as bool,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
      dates: null == dates
          ? _value._dates
          : dates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
    ));
  }
}

/// @nodoc

class _$_NewPostState implements _NewPostState {
  _$_NewPostState(
      {this.fetching = false,
      this.title = '',
      this.author = '',
      this.description = '',
      this.category = '',
      this.location = null,
      this.image = null,
      final List<DateTime> dates = const []})
      : _dates = dates;

  @override
  @JsonKey()
  final bool fetching;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String author;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String category;
  @override
  @JsonKey()
  final String? location;
  @override
  @JsonKey()
  final File? image;
  final List<DateTime> _dates;
  @override
  @JsonKey()
  List<DateTime> get dates {
    if (_dates is EqualUnmodifiableListView) return _dates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dates);
  }

  @override
  String toString() {
    return 'NewPostState(fetching: $fetching, title: $title, author: $author, description: $description, category: $category, location: $location, image: $image, dates: $dates)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NewPostState &&
            (identical(other.fetching, fetching) ||
                other.fetching == fetching) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.image, image) || other.image == image) &&
            const DeepCollectionEquality().equals(other._dates, _dates));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      fetching,
      title,
      author,
      description,
      category,
      location,
      image,
      const DeepCollectionEquality().hash(_dates));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NewPostStateCopyWith<_$_NewPostState> get copyWith =>
      __$$_NewPostStateCopyWithImpl<_$_NewPostState>(this, _$identity);
}

abstract class _NewPostState implements NewPostState {
  factory _NewPostState(
      {final bool fetching,
      final String title,
      final String author,
      final String description,
      final String category,
      final String? location,
      final File? image,
      final List<DateTime> dates}) = _$_NewPostState;

  @override
  bool get fetching;
  @override
  String get title;
  @override
  String get author;
  @override
  String get description;
  @override
  String get category;
  @override
  String? get location;
  @override
  File? get image;
  @override
  List<DateTime> get dates;
  @override
  @JsonKey(ignore: true)
  _$$_NewPostStateCopyWith<_$_NewPostState> get copyWith =>
      throw _privateConstructorUsedError;
}
