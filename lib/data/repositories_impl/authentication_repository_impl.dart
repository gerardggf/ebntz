import 'package:ebntz/data/services/remote/firebase_auth_service.dart';
import 'package:ebntz/domain/either/either.dart';
import 'package:ebntz/domain/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl(
    this._firebaseAuthService,
  );

  final FirebaseAuthService _firebaseAuthService;

  @override
  Future<Either<String, UserModel?>> signIn({
    required String email,
    required String password,
  }) {
    return _firebaseAuthService.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuthService.signOut();
  }

  @override
  Future<String> register({
    required String email,
    required String password,
  }) async {
    return _firebaseAuthService.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<UserModel?> get currentUser async =>
      await _firebaseAuthService.currentUser;

  @override
  User? get firebaseCurrentUser => _firebaseAuthService.firebaseCurrentUser;

  @override
  Future<void> changePassword(String email) async {
    return await _firebaseAuthService.sendPasswordResetEmail(email);
  }

  @override
  Future<void> sendVerifyCurrentUsersEmail() async {
    final user = _firebaseAuthService.firebaseCurrentUser;
    if (user != null) {
      return await user.sendEmailVerification();
    }
  }

  @override
  Future<void> updateDisplayName(String newUsername) async {
    return await _firebaseAuthService.updateDisplayName(newUsername);
  }

  @override
  Future<void> deleteAccount() async {
    final user = _firebaseAuthService.firebaseCurrentUser;
    if (user != null) {
      return await _firebaseAuthService.delete(user);
    }
  }
}
