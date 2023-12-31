// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomeState {
  bool get fetching => throw _privateConstructorUsedError;
  bool get searchBar => throw _privateConstructorUsedError;
  bool get showRegisterMessage => throw _privateConstructorUsedError;
  String? get searchText => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call(
      {bool fetching,
      bool searchBar,
      bool showRegisterMessage,
      String? searchText});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fetching = null,
    Object? searchBar = null,
    Object? showRegisterMessage = null,
    Object? searchText = freezed,
  }) {
    return _then(_value.copyWith(
      fetching: null == fetching
          ? _value.fetching
          : fetching // ignore: cast_nullable_to_non_nullable
              as bool,
      searchBar: null == searchBar
          ? _value.searchBar
          : searchBar // ignore: cast_nullable_to_non_nullable
              as bool,
      showRegisterMessage: null == showRegisterMessage
          ? _value.showRegisterMessage
          : showRegisterMessage // ignore: cast_nullable_to_non_nullable
              as bool,
      searchText: freezed == searchText
          ? _value.searchText
          : searchText // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$$_HomeStateCopyWith(
          _$_HomeState value, $Res Function(_$_HomeState) then) =
      __$$_HomeStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool fetching,
      bool searchBar,
      bool showRegisterMessage,
      String? searchText});
}

/// @nodoc
class __$$_HomeStateCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$_HomeState>
    implements _$$_HomeStateCopyWith<$Res> {
  __$$_HomeStateCopyWithImpl(
      _$_HomeState _value, $Res Function(_$_HomeState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fetching = null,
    Object? searchBar = null,
    Object? showRegisterMessage = null,
    Object? searchText = freezed,
  }) {
    return _then(_$_HomeState(
      fetching: null == fetching
          ? _value.fetching
          : fetching // ignore: cast_nullable_to_non_nullable
              as bool,
      searchBar: null == searchBar
          ? _value.searchBar
          : searchBar // ignore: cast_nullable_to_non_nullable
              as bool,
      showRegisterMessage: null == showRegisterMessage
          ? _value.showRegisterMessage
          : showRegisterMessage // ignore: cast_nullable_to_non_nullable
              as bool,
      searchText: freezed == searchText
          ? _value.searchText
          : searchText // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_HomeState implements _HomeState {
  _$_HomeState(
      {this.fetching = false,
      this.searchBar = false,
      this.showRegisterMessage = true,
      this.searchText = null});

  @override
  @JsonKey()
  final bool fetching;
  @override
  @JsonKey()
  final bool searchBar;
  @override
  @JsonKey()
  final bool showRegisterMessage;
  @override
  @JsonKey()
  final String? searchText;

  @override
  String toString() {
    return 'HomeState(fetching: $fetching, searchBar: $searchBar, showRegisterMessage: $showRegisterMessage, searchText: $searchText)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HomeState &&
            (identical(other.fetching, fetching) ||
                other.fetching == fetching) &&
            (identical(other.searchBar, searchBar) ||
                other.searchBar == searchBar) &&
            (identical(other.showRegisterMessage, showRegisterMessage) ||
                other.showRegisterMessage == showRegisterMessage) &&
            (identical(other.searchText, searchText) ||
                other.searchText == searchText));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, fetching, searchBar, showRegisterMessage, searchText);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HomeStateCopyWith<_$_HomeState> get copyWith =>
      __$$_HomeStateCopyWithImpl<_$_HomeState>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  factory _HomeState(
      {final bool fetching,
      final bool searchBar,
      final bool showRegisterMessage,
      final String? searchText}) = _$_HomeState;

  @override
  bool get fetching;
  @override
  bool get searchBar;
  @override
  bool get showRegisterMessage;
  @override
  String? get searchText;
  @override
  @JsonKey(ignore: true)
  _$$_HomeStateCopyWith<_$_HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}
