import 'dart:io';

import 'package:ebntz/domain/enums.dart';
import 'package:ebntz/domain/models/lineup_item_model.dart';
import 'package:ebntz/domain/repositories/posts_repositories.dart';
import 'package:ebntz/presentation/modules/new_post/state/new_post_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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

  void updateImage(File? image) => state = state.copyWith(image: image);

  Future<FirebaseResponse> submit() async {
    final result = await postsRepository.createPost(
      image: state.image!,
      lineupItemModel: LineupItemModel(
        id: '',
        author: 'prueba',
        creationDate: DateFormat('dd-MM-yyyy-hh-mm').format(
          DateTime.now(),
        ),
        category: state.category,
        tags: [],
        title: state.title,
        description: state.description,
        location: state.location ?? '',
        url: '',
      ),
    );
    if (result == FirebaseResponse.success) {
      state.image == null;
    }
    return result;
  }
}
