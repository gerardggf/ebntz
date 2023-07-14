import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebntz/domain/enums.dart';
import 'package:ebntz/domain/models/lineup_item_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  throw UnimplementedError();
});

final firebaseFirestoreServiceProvider = Provider(
  (ref) => FirebaseFirestoreService(
    ref.read(firebaseFirestoreProvider),
  ),
);

class FirebaseFirestoreService {
  final FirebaseFirestore firebaseFirestore;

  FirebaseFirestoreService(this.firebaseFirestore);

  Stream<List<LineupItemModel>> getPosts() async* {
    final snapshots = firebaseFirestore.collection('posts').snapshots();
    final items = snapshots.map(
      (snapshot) => snapshot.docs
          .map(
            (doc) => LineupItemModel.fromJson(
              doc.data(),
            ),
          )
          .toList(),
    );
    yield* items;
  }

  Future<FirebaseResponse> createPost({
    required LineupItemModel post,
    required String imageUrl,
    required List<String> tags,
  }) async {
    try {
      final doc = firebaseFirestore.collection('posts').doc();
      post = post.copyWith(
        id: doc.id,
        url: imageUrl,
        tags: tags,
      );
      doc.set(
        post.toJson(),
      );
      return FirebaseResponse.success;
    } catch (e) {
      return FirebaseResponse.failure;
    }
  }

  Future<FirebaseResponse> deletePost(String id) async {
    try {
      final doc = firebaseFirestore.collection('posts').doc(id);
      await doc.delete();
      return FirebaseResponse.success;
    } catch (e) {
      return FirebaseResponse.failure;
    }
  }
}
