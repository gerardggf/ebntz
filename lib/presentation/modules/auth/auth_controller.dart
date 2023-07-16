import 'package:ebntz/domain/repositories/posts_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state/auth_state.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(
    AuthState(),
    ref.read(postsRepostoryProvider),
  ),
);

class AuthController extends StateNotifier<AuthState> {
  AuthController(
    super.state,
    this.postsRepository,
  );

  final PostsRepository postsRepository;

  void updateIsRegister(bool value) {
    state = state.copyWith(isRegister: value);
  }
}
