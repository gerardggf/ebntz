import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebntz/domain/models/lineup_item_model.dart';
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
    items.listen((event) {
      print(event);
    });
    yield* items;
  }
}
