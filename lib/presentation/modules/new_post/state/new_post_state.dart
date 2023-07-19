import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_post_state.freezed.dart';

@freezed
class NewPostState with _$NewPostState {
  factory NewPostState({
    @Default(false) bool fetching,
    @Default(null) DateTime? initialDate,
    @Default('') String title,
    @Default('') String author,
    @Default('') String description,
    @Default('') String category,
    @Default(null) String? location,
    @Default(null) File? image,
  }) = _NewPostState;
}
