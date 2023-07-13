import 'dart:io';

import 'package:ebntz/data/services/firebase_firestore_service.dart';
import 'package:ebntz/data/services/firebase_storage_service.dart';
import 'package:ebntz/data/services/ml_kit_service.dart';
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
    return mlKitService.getRecognizedText(file);
  }
}
