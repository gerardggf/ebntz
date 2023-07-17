import 'dart:io';

import 'package:ebntz/domain/enums.dart';
import 'package:ebntz/domain/models/lineup_item_model.dart';
import 'package:ebntz/domain/repositories/posts_repositories.dart';
import 'package:ebntz/presentation/global/utils/date_functions.dart';
import 'package:ebntz/presentation/modules/new_post/state/new_post_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;

final newPostControllerProvider =
    StateNotifierProvider<NewPostController, NewPostState>(
  (ref) => NewPostController(
    NewPostState(),
    ref.read(postsRepostoryProvider),
  ),
);

class NewPostController extends StateNotifier<NewPostState> {
  NewPostController(
    super.state,
    this.postsRepository,
  );

  final PostsRepository postsRepository;

  Future<void> getImage(ImageSource imageSource) async {
    final pickedFile =
        await ImagePicker().pickImage(source: imageSource, imageQuality: 25);

    if (pickedFile != null) {
      io.File? image;
      image = io.File(pickedFile.path);

      updateImage(image);
    }
  }

  void updateTitle(String text) => state = state.copyWith(title: text);

  void updateDescription(String text) =>
      state = state.copyWith(description: text);

  void updateLocation(String text) => state = state.copyWith(location: text);

  void updateCategory(String text) => state = state.copyWith(category: text);

  Future<void> updateImage(File? image) async {
    state = state.copyWith(image: image);
    if (image != null) {
      final infoFromImage = await postsRepository.getInfoFromImage(image);
      if (infoFromImage != null) {
        updateTitle(infoFromImage);
      }
    }
  }

  void updateFetching(bool value) => state = state.copyWith(fetching: value);

  Future<FirebaseResponse> submit() async {
    updateFetching(true);
    final result = await postsRepository.createPost(
      image: state.image!,
      lineupItemModel: LineupItemModel(
        id: '',
        author: 'prueba',
        creationDate: dateToString(
          DateTime.now(),
        )!,
        category: state.category.trim() == '' ? state.category.trim() : 'Music',
        tags: [],
        title:
            '${state.title[0].toUpperCase()}${state.title.substring(1, state.title.length)}'
                .trim(),
        description: state.description.trim(),
        location: state.location?.trim() ?? '',
        url: '',
        approved: true,
      ),
    );
    if (result == FirebaseResponse.success) {
      updateImage(null);
    }
    updateFetching(false);

    return result;
  }
}
