import 'package:ebntz/domain/models/lineup_item_model.dart';
import 'package:ebntz/domain/repositories/authentication_repository.dart';
import 'package:ebntz/domain/repositories/posts_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'state/change_password_state.dart';

final changePasswordControllerProvider =
    StateNotifierProvider<ChangePasswordController, ChangePasswordState>(
  (ref) => ChangePasswordController(
    ChangePasswordState(),
    ref.read(postsRepostoryProvider),
    ref.read(authenticationRepositoryProvider),
  ),
);

class ChangePasswordController extends StateNotifier<ChangePasswordState> {
  ChangePasswordController(
    super.state,
    this.postsRepository,
    this.authenticationRepository,
  );

  LineupItemModel? post;

  final PostsRepository postsRepository;
  final AuthenticationRepository authenticationRepository;

  void updateFetching(bool value) => state = state.copyWith(fetching: value);

  void updateEmail(String text) => state = state.copyWith(email: text);

  Future<void> sendEmail() async {
    await authenticationRepository.changePassword(state.email);
  }
}
