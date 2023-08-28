import 'package:ebntz/data/repositories_impl/account_repository_impl.dart';
import 'package:ebntz/data/services/remote/firebase_firestore_service.dart';
import 'package:ebntz/presentation/global/controllers/session_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountRepositoryProvider = Provider<AccountRepository>(
  (ref) => AccountRepositoryImpl(
    ref.read(firebaseFirestoreServiceProvider),
    ref.read(sessionControllerProvider),
  ),
);

abstract class AccountRepository {
  Future<void> updateFavorites(List<String> favorites);
}
