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
}
