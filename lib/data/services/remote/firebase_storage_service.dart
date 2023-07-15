import 'dart:io';

import 'package:ebntz/domain/enums.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseStorageProvider = Provider<FirebaseStorage>((ref) {
  throw UnimplementedError();
});

final firebaseStorageServiceProvider = Provider(
  (ref) => FirebaseStorageService(
    ref.read(firebaseStorageProvider),
  ),
);

class FirebaseStorageService {
  final FirebaseStorage firebaseStorage;

  FirebaseStorageService(this.firebaseStorage);

  Future<String> postAndGetImageUrl(File file, String id) async {
    final storageRef = firebaseStorage.ref().child('/posts');
    final uploadTask = storageRef.child(id).putFile(file);

    final taskSnapshot = await uploadTask.whenComplete(
      () {},
    );
    if (taskSnapshot.state == TaskState.success) {
      return await storageRef.child(id).getDownloadURL();
    } else {
      return '';
    }
  }

  Future<FirebaseResponse> deleteImage(String imageId) async {
    try {
      final storageRef = firebaseStorage.ref().child('/posts').child(imageId);
      await storageRef.delete();
      return FirebaseResponse.success;
    } catch (e) {
      return FirebaseResponse.failure;
    }
  }
}
