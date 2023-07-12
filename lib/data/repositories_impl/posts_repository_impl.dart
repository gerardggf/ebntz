import 'package:ebntz/data/services/firebase_firestore_service.dart';
import 'package:ebntz/data/services/firebase_storage_service.dart';
import 'package:ebntz/domain/models/lineup_item_model.dart';
import 'package:ebntz/domain/repositories/posts_repositories.dart';

class PostsRepositoryImpl implements PostsRepository {
  PostsRepositoryImpl(
      this.firebaseStorageService, this.firebaseFirestoreService);

  final FirebaseStorageService firebaseStorageService;
  final FirebaseFirestoreService firebaseFirestoreService;

  @override
  Stream<List<LineupItemModel>> getPosts() {
    return firebaseFirestoreService.getPosts();
  }
}
