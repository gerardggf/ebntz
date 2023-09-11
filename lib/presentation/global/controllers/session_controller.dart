import 'package:ebntz/data/services/remote/firebase_firestore_service.dart';
import 'package:ebntz/domain/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/repositories/authentication_repository.dart';

final sessionControllerProvider =
    StateNotifierProvider<SessionController, UserModel?>(
  (ref) => SessionController(
    authenticationRepository: ref.read(authenticationRepositoryProvider),
    firebaseFirestoreService: ref.read(firebaseFirestoreServiceProvider),
  ),
);

class SessionController extends StateNotifier<UserModel?> {
  SessionController({
    required this.authenticationRepository,
    required this.firebaseFirestoreService,
  }) : super(null);

  final AuthenticationRepository authenticationRepository;
  final FirebaseFirestoreService firebaseFirestoreService;

  Future<void> setUser(UserModel? user) async {
    state = user;
  }

  Future<void> signOut() async {
    authenticationRepository.signOut();
    state = null;
  }
}
