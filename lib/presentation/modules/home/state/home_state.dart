import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    @Default(false) bool fetching,
    @Default(false) bool searchBar,
    @Default(true) bool showRegisterMessage,
    @Default(null) String? searchText,
  }) = _HomeState;
}
