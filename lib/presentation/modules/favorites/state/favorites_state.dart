import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorites_state.freezed.dart';

@freezed
class FavoritesState with _$FavoritesState {
  factory FavoritesState({
    @Default(false) bool fetching,
    @Default(false) bool searchBar,
    @Default(null) String? searchText,
  }) = _FavoritesState;
}
