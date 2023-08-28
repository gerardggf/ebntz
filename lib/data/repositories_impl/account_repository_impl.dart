import 'package:ebntz/data/services/remote/firebase_firestore_service.dart';
import 'package:ebntz/domain/models/user_model.dart';
import 'package:ebntz/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  AccountRepositoryImpl(
    this.firebaseFirestoreService,
    this.sessionController,
  );

  final FirebaseFirestoreService firebaseFirestoreService;
  final UserModel? sessionController;

  @override
  Future<void> updateFavorites(List<String> favorites) async {
    await firebaseFirestoreService.updateFavorites(
      favorites,
      sessionController!.id,
    );
  }
}
