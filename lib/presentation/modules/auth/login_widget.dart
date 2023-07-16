import 'package:ebntz/presentation/modules/auth/auth_controller.dart';
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
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Correo electrónico'),
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Contraseña'),
          ),
          const SizedBox(height: 20),
          CustomButton(
            onPressed: () {},
            child: const Text('Iniciar sesión'),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
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
}
