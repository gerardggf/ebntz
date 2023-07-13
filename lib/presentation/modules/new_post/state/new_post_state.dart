import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_post_state.freezed.dart';

@freezed
class NewPostState with _$NewPostState {
  factory NewPostState({
    @Default(false) bool fetching,
    @Default('') String title,
    @Default(null) File? image,
  }) = _NewPostState;
}
