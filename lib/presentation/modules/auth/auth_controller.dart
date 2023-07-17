import 'package:ebntz/domain/either/either.dart';
import 'package:ebntz/domain/repositories/authentication_repository.dart';
import 'package:ebntz/domain/repositories/posts_repositories.dart';
import 'package:ebntz/presentation/global/controllers/session_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/user_model.dart';
import 'state/auth_state.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(
    AuthState(),
    ref.read(postsRepostoryProvider),
    ref.read(authenticationRepositoryProvider),
    ref.read(sessionControllerProvider.notifier),
  ),
);

class AuthController extends StateNotifier<AuthState> {
  AuthController(
    super.state,
    this.postsRepository,
    this.authenticationRepository,
    this.sessionController,
  );

  final PostsRepository postsRepository;
  final AuthenticationRepository authenticationRepository;
  final SessionController sessionController;

  void updateIsRegister(bool value) =>
      state = state.copyWith(isRegister: value);

  void updateEmail(String text) => state = state.copyWith(email: text);

  void updatePassword(String text) => state = state.copyWith(password: text);

  void onEmailChanged(String text) {
    state = state.copyWith(
      email: text.trim().toLowerCase(),
    );
  }

  void onPasswordChanged(String text) {
    state = state.copyWith(
      password: text.replaceAll(' ', ''),
    );
  }

  Future<Either<String, UserModel?>> login() async {
    state = state.copyWith(fetching: true);
    final result = await authenticationRepository.signIn(
      email: state.email,
      password: state.password,
    );
    result.when(
      left: (_) => state = state.copyWith(fetching: false),
      right: (user) async {
        await sessionController.setUser(user!);
        if (kDebugMode) {
          print(user.toJson());
        }
      },
    );

    return result;
  }

  Future<String> register() async {
    state = state.copyWith(fetching: true);
    final result = await authenticationRepository.register(
      email: state.email,
      password: state.password,
    );
    if (result == 'register-success') {
      authenticationRepository.sendVerifyCurrentUsersEmail();
    }
    state = state.copyWith(fetching: false);
    return result;
  }
}
