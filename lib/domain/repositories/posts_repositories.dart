import 'dart:io';

import 'package:ebntz/data/repositories_impl/posts_repository_impl.dart';
import 'package:ebntz/data/services/remote/firebase_firestore_service.dart';
import 'package:ebntz/data/services/remote/firebase_storage_service.dart';
import 'package:ebntz/data/services/local/ml_kit_service.dart';
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
  Stream<List<LineupItemModel>> suscribeToPosts({
    bool isApproved = true,
    OrderPostsBy orderBy = OrderPostsBy.creationDate,
  });
  Future<LineupItemModel?> getPost(String id);

  Future<List<String>> getRecognizedTexts(File file);
  Future<FirebaseResponse> createPost({
    required LineupItemModel lineupItemModel,
    required File image,
  });

  Future<FirebaseResponse> editPost({
    required String id,
    required LineupItemModel lineupItemModel,
  });

  Future<FirebaseResponse> deletePost(LineupItemModel lineupItemModel);
  Future<String?> getInfoFromImage(File file);

  Future<bool> updatePostApproval({
    required String id,
    bool isApproved = true,
  });
}
