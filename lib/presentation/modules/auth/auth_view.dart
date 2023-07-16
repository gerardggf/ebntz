import 'package:ebntz/presentation/global/const.dart';
import 'package:ebntz/presentation/modules/auth/auth_controller.dart';
import 'package:ebntz/presentation/modules/auth/login_widget.dart';
import 'package:ebntz/presentation/modules/auth/register_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthView extends ConsumerWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          controller.isRegister ? 'Registrarse' : 'Inicio de sesión',
        ),
        backgroundColor: kPrimaryColor,
      ),
      body:
          controller.isRegister ? const RegisterWidget() : const LoginWidget(),
    );
  }
}
