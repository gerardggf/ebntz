import 'package:ebntz/presentation/global/utils/custom_snack_bar.dart';
import 'package:ebntz/presentation/global/utils/get_text_from_code.dart';
import 'package:ebntz/presentation/modules/auth/auth_controller.dart';
import 'package:ebntz/presentation/routes/routes.dart';
import 'package:ebntz/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginWidget extends ConsumerStatefulWidget {
  const LoginWidget({super.key});

  @override
  ConsumerState<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends ConsumerState<LoginWidget> {
  final TextEditingController _usernameController = TextEditingController(),
      _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(authControllerProvider);
    final notifier = ref.watch(authControllerProvider.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Inicia sesión para poder compartir eventos y poder editar tu perfil',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Correo electrónico'),
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Contraseña'),
          ),
          const SizedBox(height: 30),
          CustomButton(
            onPressed: () {
              login();
            },
            child: const Text('Iniciar sesión'),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () async {
              notifier.updateIsRegister(true);
            },
            child: const Text(
              'Registrarse',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> login() async {
    final notifier = ref.read(authControllerProvider.notifier);

    final result = await notifier.login();
    result.when(
      left: (failure) {
        showCustomSnackBar(
          context: context,
          text: getTextFromAuthCode(context: context, stringCode: failure),
          color: Colors.orange,
        );
      },
      right: (_) {
        // if (!ref.watch(authenticationRepositoryProvider).currentUser!.verified) {
        //   Navigator.pushReplacementNamed(context, Routes.verifyEmail);
        // }
        // else {
        Navigator.pushReplacementNamed(context, Routes.home);
        //}
      },
    );
  }
}
