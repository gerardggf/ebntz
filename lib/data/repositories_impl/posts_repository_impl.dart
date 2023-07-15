import 'dart:io';

import 'package:ebntz/data/services/remote/firebase_firestore_service.dart';
import 'package:ebntz/data/services/remote/firebase_storage_service.dart';
import 'package:ebntz/data/services/remote/ml_kit_service.dart';
import 'package:ebntz/domain/enums.dart';
import 'package:ebntz/domain/models/lineup_item_model.dart';
import 'package:ebntz/domain/repositories/posts_repositories.dart';

class PostsRepositoryImpl implements PostsRepository {
  PostsRepositoryImpl(
    this.firebaseStorageService,
    this.firebaseFirestoreService,
    this.mlKitService,
  );

  final FirebaseStorageService firebaseStorageService;
  final FirebaseFirestoreService firebaseFirestoreService;
  final MLKitService mlKitService;

  @override
  Stream<List<LineupItemModel>> getPosts() {
    return firebaseFirestoreService.getPosts();
  }

  @override
  Future<List<String>> getRecognizedTexts(File file) {
    return mlKitService.getRecognizedTextsList(file);
  }

  @override
  Future<FirebaseResponse> createPost({
    required LineupItemModel lineupItemModel,
    required File image,
  }) async {
    final imageId =
        '${lineupItemModel.title.replaceAll(' ', '_')}_${lineupItemModel.creationDate}';
    final String imageUrl = await firebaseStorageService.postAndGetImageUrl(
      image,
      imageId,
    );

    final tags = await mlKitService.getRecognizedTextsList(image);

    return await firebaseFirestoreService.createPost(
      post: lineupItemModel,
      imageUrl: imageUrl,
      tags: tags,
    );
  }

  @override
  Future<FirebaseResponse> deletePost(LineupItemModel lineupItemModel) async {
    final imageId =
        '${lineupItemModel.title.replaceAll(' ', '_')}_${lineupItemModel.creationDate}';
    final deleteImage = await firebaseStorageService.deleteImage(imageId);
    if (deleteImage == FirebaseResponse.failure) {
      return FirebaseResponse.failure;
    }
    return await firebaseFirestoreService.deletePost(lineupItemModel.id);
  }
}