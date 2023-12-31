import 'package:ebntz/data/services/remote/firebase_firestore_service.dart';
import 'package:ebntz/domain/either/either.dart';
import 'package:ebntz/domain/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => throw UnimplementedError(),
);

final firebaseAuthServiceProvider = Provider<FirebaseAuthService>(
  (ref) => FirebaseAuthService(
    ref.read(firebaseAuthProvider),
    ref.read(firebaseFirestoreServiceProvider),
  ),
);

class FirebaseAuthService {
  FirebaseAuthService(
    this.firebaseAuth,
    this.firestoreService,
  );

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestoreService firestoreService;

  Future<UserModel?> _mapUser(User? user) async {
    if (user == null) {
      return null;
    }
    final firestoreUser = await firestoreService.getUser(user.uid);
    if (user.displayName == null) {
      user.updateDisplayName(
        user.email!.split('@')[0],
      );
    }
    return UserModel(
      id: user.uid,
      username: user.displayName!,
      email: user.email!,
      creationDate: user.metadata.creationTime,
      verified: user.emailVerified,
      favorites: firestoreUser?.favorites ?? [],
      isAdmin: firestoreUser?.isAdmin ?? false,
    );
  }

  Future<UserModel?> get currentUser async =>
      await _mapUser(firebaseAuth.currentUser);
  User? get firebaseCurrentUser => firebaseAuth.currentUser;

  Future<String> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credentials = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await firestoreService.createFirestoreUser(
        UserModel(
          id: credentials.user!.uid,
          username: credentials.user!.email!.split('@')[0],
          email: email,
          creationDate: DateTime.now(),
          verified: true,
          favorites: [],
          isAdmin: false,
        ),
      );
      return 'register-success';
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  Future<Either<String, UserModel?>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return Either.right(
        await _mapUser(credential.user),
      );
    } on FirebaseAuthException catch (e) {
      return Either.left(e.code);
    } catch (e) {
      return Either.left(e.toString());
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    return await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> sendEmailVerification(User user) async {
    return await user.sendEmailVerification();
  }

  Future<void> updateDisplayName(String newUsername) async {
    await firestoreService.updateFirestoreUsername(
        firebaseCurrentUser!.uid, newUsername);
    return await firebaseCurrentUser!.updateDisplayName(newUsername);
  }

  Future<void> signOut() async {
    return await firebaseAuth.signOut();
  }

  Future<void> delete(User user) async {
    try {
      await user.delete();
      await firestoreService.deleteFirestoreUser(user.uid);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
