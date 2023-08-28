import 'package:ebntz/domain/repositories/account_repository.dart';
import 'package:ebntz/domain/repositories/authentication_repository.dart';
import 'package:ebntz/presentation/global/controllers/session_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state/favorites_state.dart';

final favoritesControllerProvider =
    StateNotifierProvider<FavoritesController, FavoritesState>(
  (ref) => FavoritesController(
    FavoritesState(),
    ref.read(accountRepositoryProvider),
    ref.read(
      sessionControllerProvider.notifier,
    ),
    ref.read(authenticationRepositoryProvider),
  ),
);

class FavoritesController extends StateNotifier<FavoritesState> {
  FavoritesController(
    super.state,
    this.accountRepository,
    this.sessionController,
    this.authenticationRepository,
  );

  final AccountRepository accountRepository;
  final SessionController sessionController;
  final AuthenticationRepository authenticationRepository;

  void updateSearchBar(bool value) => state = state.copyWith(searchBar: value);

  void updateFetching(bool value) => state = state.copyWith(fetching: value);

  void updateSearchText(String? text) =>
      state = state.copyWith(searchText: text);

  Future<void> addToFavorites(String id) async {
    updateFetching(true);
    if (sessionController.state == null) return;
    final favoritePosts = List<String>.from(sessionController.state!.favorites);
    favoritePosts.add(id);
    await accountRepository.updateFavorites(favoritePosts);
    await updateUser();
    updateFetching(false);
  }

  Future<void> deleteFromFavorites(String id) async {
    updateFetching(true);
    if (sessionController.state == null) return;
    final favoritePosts = List<String>.from(sessionController.state!.favorites);
    favoritePosts.remove(id);
    await accountRepository.updateFavorites(favoritePosts);
    await updateUser();
    updateFetching(false);
  }

  Future<void> updateUser() async {
    final updatedUser = await authenticationRepository.currentUser;
    if (updatedUser == null) return;
    sessionController.setUser(updatedUser);
  }
}
