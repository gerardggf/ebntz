import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_posts_state.freezed.dart';

@freezed
class FilterPostsState with _$FilterPostsState {
  factory FilterPostsState({
    @Default(false) bool fetching,
    @Default(null) DateTime? date,
  }) = _FilterPostsState;
}
