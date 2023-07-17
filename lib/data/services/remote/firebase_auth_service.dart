import 'package:ebntz/data/services/remote/firebase_firestore_service.dart';
import 'package:ebntz/domain/either/either.dart';
import 'package:ebntz/domain/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    this.auth,
    this.firestoreService,
  );

  final FirebaseAuth auth;
  final FirebaseFirestoreService firestoreService;

  Future<UserModel?> _mapUser(User? user) async {
    if (user == null) {
      return null;
    }
    final firestoreUser = await firestoreService.getUser(user.uid);
    return UserModel(
      id: user.uid,
      username: user.displayName ?? user.email!.split('@')[0],
      email: user.email!,
      creationDate: user.metadata.creationTime,
      verified: user.emailVerified,
      favorites: firestoreUser?.favorites ?? [],
      isAdmin: firestoreUser?.isAdmin ?? false,
    );
  }

  Future<UserModel?> get currentUser async => await _mapUser(auth.currentUser);
  User? get firebaseCurrentUser => auth.currentUser;

  Future<String> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    print('eee $email');
    print(password);
    try {
      final credentials = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await firestoreService.createFirestoreUser(
        await _mapUser(credentials.user),
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
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
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
    return await auth.sendPasswordResetEmail(email: email);
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
    return await auth.signOut();
  }

  Future<void> delete(User user) async {
    await firestoreService.deleteFirestoreUser(user.uid);
    return await user.delete();
  }
}
