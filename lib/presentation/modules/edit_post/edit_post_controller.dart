import 'dart:io';

import 'package:ebntz/domain/enums.dart';
import 'package:ebntz/domain/models/lineup_item_model.dart';
import 'package:ebntz/domain/repositories/posts_repositories.dart';
import 'package:ebntz/presentation/global/utils/date_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;

import 'state/edit_post_state.dart';

final editPostControllerProvider =
    StateNotifierProvider<EditPostController, EditPostState>(
  (ref) => EditPostController(
    EditPostState(),
    ref.read(postsRepostoryProvider),
  ),
);

class EditPostController extends StateNotifier<EditPostState> {
  EditPostController(
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

  void updateImage(File? image) => state = state.copyWith(image: image);

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
        ),
        category: state.category,
        tags: [],
        title:
            '${state.title[0].toUpperCase()}${state.title.substring(1, state.title.length)}',
        description: state.description,
        location: state.location ?? '',
        url: '',
      ),
    );
    if (result == FirebaseResponse.success) {
      state.image == null;
    }
    updateFetching(false);

    return result;
  }
}
