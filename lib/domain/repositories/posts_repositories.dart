import 'dart:io';

import 'package:ebntz/data/repositories_impl/posts_repository_impl.dart';
import 'package:ebntz/data/services/firebase_firestore_service.dart';
import 'package:ebntz/data/services/firebase_storage_service.dart';
import 'package:ebntz/data/services/ml_kit_service.dart';
import 'package:ebntz/domain/enums.dart';
import 'package:ebntz/domain/models/lineup_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postsRepostoryProvider = Provider<PostsRepository>(
  (ref) => PostsRepositoryImpl(
    ref.read(firebaseStorageServiceProvider),
    ref.read(firebaseFirestoreServiceProvider),
    ref.read(mlKitServiceProvider),
  ),
);

abstract class PostsRepository {
  Stream<List<LineupItemModel>> getPosts();
  Future<List<String>> getRecognizedTexts(File file);
  Future<FirebaseResponse> createPost({
    required LineupItemModel lineupItemModel,
    required File image,
  });
  Future<FirebaseResponse> deletePost(LineupItemModel lineupItemModel);
}
