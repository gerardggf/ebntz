import 'package:ebntz/data/repositories_impl/posts_repository_impl.dart';
import 'package:ebntz/data/services/firebase_firestore_service.dart';
import 'package:ebntz/data/services/firebase_storage_service.dart';
import 'package:ebntz/domain/models/lineup_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postsRepostoryProvider = Provider<PostsRepository>(
  (ref) => PostsRepositoryImpl(
    ref.read(firebaseStorageServiceProvider),
    ref.read(firebaseFirestoreServiceProvider),
  ),
);

abstract class PostsRepository {
  Stream<List<LineupItemModel>> getPosts();
}
