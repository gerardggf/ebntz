import 'package:ebntz/domain/repositories/authentication_repository.dart';
import 'package:ebntz/domain/repositories/connectivity_repository.dart';
import 'package:ebntz/presentation/global/controllers/session_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'routes/routes.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(connectivityRepositoryProvider).initialize();
        _init();
      },
    );
  }

  Future<void> _init() async {
    final routeName = await () async {
      final ConnectivityRepository connectivityRepository =
          ref.read(connectivityRepositoryProvider);
      final AuthenticationRepository authenticationRepository =
          ref.read(authenticationRepositoryProvider);
      final SessionController sessionController =
          ref.read(sessionControllerProvider.notifier);

      final hasInternet = connectivityRepository.hasInternet;

      if (!hasInternet) {
        return Routes.offline;
      }

      final user = await authenticationRepository.currentUser;

      if (user != null) {
        await sessionController.setUser(user);
      }

      return Routes.home;
    }();

    if (mounted) {
      _goTo(routeName);
    }
  }

  void _goTo(String routeName) {
    context.goNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Text(
              'eBntz',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
