import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_post_state.freezed.dart';

@freezed
class EditPostState with _$EditPostState {
  factory EditPostState({
    @Default(false) bool fetching,
    @Default('') String title,
    @Default('') String author,
    @Default('') String description,
    @Default('') String category,
    @Default(null) String? location,
    @Default(null) File? image,
  }) = _EditPostState;
}
