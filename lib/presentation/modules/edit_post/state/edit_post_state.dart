import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_post_state.freezed.dart';

@freezed
class EditPostState with _$EditPostState {
  factory EditPostState({
    @Default(false) bool fetching,
    @Default('') String title,
    @Default('') String description,
    @Default(null) String? location,
    @Default('') String imageUrl,
    @Default([]) List<DateTime> dates,
  }) = _EditPostState;
}
