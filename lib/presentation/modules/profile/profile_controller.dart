import 'package:ebntz/domain/repositories/authentication_repository.dart';
import 'package:ebntz/presentation/global/controllers/session_controller.dart';
import 'package:ebntz/presentation/modules/new_post/state/new_post_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final newPostControllerProvider =
    StateNotifierProvider<NewPostController, NewPostState>(
  (ref) => NewPostController(
    NewPostState(),
    ref.read(sessionControllerProvider.notifier),
    ref.read(authenticationRepositoryProvider),
  ),
);

class NewPostController extends StateNotifier<NewPostState> {
  NewPostController(
    super.state,
    this.sessionController,
    this.authenticationRepository,
  );

  final SessionController sessionController;
  final AuthenticationRepository authenticationRepository;

  Future<void> deleteAccount() async {
    await sessionController.signOut();
    await authenticationRepository.deleteAccount();
  }
}
