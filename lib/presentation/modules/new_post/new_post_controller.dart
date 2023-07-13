import 'dart:io';

import 'package:ebntz/presentation/modules/new_post/state/new_post_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final newPostControllerProvider =
    StateNotifierProvider<NewPostController, NewPostState>(
  (ref) => NewPostController(
    NewPostState(),
  ),
);

class NewPostController extends StateNotifier<NewPostState> {
  NewPostController(super.state);

  void updateImage(File image) => state = state.copyWith(image: image);
}
