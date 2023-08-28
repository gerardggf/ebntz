import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebntz/domain/enums.dart';
import 'package:ebntz/domain/models/lineup_item_model.dart';
import 'package:ebntz/domain/models/user_model.dart';
import 'package:flutter/foundation.dart';
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
  FirebaseFirestoreService(this.firebaseFirestore);

  final FirebaseFirestore firebaseFirestore;

  // posts ---------------------------------------------------

  Stream<List<LineupItemModel>> suscribeToPosts() async* {
    final snapshots = firebaseFirestore
        .collection('posts')
        .orderBy('creationDate', descending: true)
        .snapshots();
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

  Future<LineupItemModel?> getPost(String id) async {
    final doc = await firebaseFirestore.collection('posts').doc(id).get();
    final post = doc.data() == null
        ? null
        : LineupItemModel.fromJson(
            doc.data()!,
          );
    return post;
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

  Future<FirebaseResponse> editPost({
    required String id,
    required LineupItemModel lineupItemModel,
  }) async {
    try {
      final doc = firebaseFirestore.collection('posts').doc(id);
      doc.update(
        lineupItemModel.toJson(),
      );
      return FirebaseResponse.success;
    } catch (e) {
      return FirebaseResponse.failure;
    }
  }

  // users ---------------------------------------------------

  Future<UserModel?> getUser(String userId) async {
    try {
      final CollectionReference usersCollection =
          firebaseFirestore.collection('users');
      DocumentReference docRef = usersCollection.doc(userId);
      return await docRef.get().then(
            (event) => UserModel.fromJson(
              event.data() as Map<String, dynamic>,
            ),
          );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<bool> createFirestoreUser(UserModel? user) async {
    try {
      if (user == null) return false;
      final CollectionReference usersCollection =
          firebaseFirestore.collection('users');
      DocumentReference docRef = usersCollection.doc(user.id);
      await docRef.set(
        user.toJson(),
      );
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<bool> updateFirestoreUsername(String userId, String username) async {
    try {
      final CollectionReference usersCollection =
          firebaseFirestore.collection('users');
      DocumentReference docRef = usersCollection.doc(userId);
      await docRef.update(
        {"username": username},
      );
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<bool> deleteFirestoreUser(String userId) async {
    try {
      final CollectionReference usersCollection =
          firebaseFirestore.collection('users');
      DocumentReference docRef = usersCollection.doc(userId);
      await docRef.delete();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  //favorites -------------------------------------------------------------------------------------------

  Future<bool> updateFavorites(
    List<String> favoritePosts,
    String userId,
  ) async {
    try {
      final CollectionReference usersCollection =
          firebaseFirestore.collection('users');
      DocumentReference docRef = usersCollection.doc(userId);
      await docRef.update(
        {"favorites": favoritePosts},
      );
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }
}
