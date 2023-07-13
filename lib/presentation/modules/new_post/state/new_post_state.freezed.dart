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
  $Res call({bool fetching});
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
  }) {
    return _then(_value.copyWith(
      fetching: null == fetching
          ? _value.fetching
          : fetching // ignore: cast_nullable_to_non_nullable
              as bool,
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
  $Res call({bool fetching});
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
  }) {
    return _then(_$_NewPostState(
      fetching: null == fetching
          ? _value.fetching
          : fetching // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_NewPostState implements _NewPostState {
  _$_NewPostState({this.fetching = false});

  @override
  @JsonKey()
  final bool fetching;

  @override
  String toString() {
    return 'NewPostState(fetching: $fetching)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NewPostState &&
            (identical(other.fetching, fetching) ||
                other.fetching == fetching));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fetching);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NewPostStateCopyWith<_$_NewPostState> get copyWith =>
      __$$_NewPostStateCopyWithImpl<_$_NewPostState>(this, _$identity);
}

abstract class _NewPostState implements NewPostState {
  factory _NewPostState({final bool fetching}) = _$_NewPostState;

  @override
  bool get fetching;
  @override
  @JsonKey(ignore: true)
  _$$_NewPostStateCopyWith<_$_NewPostState> get copyWith =>
      throw _privateConstructorUsedError;
}
