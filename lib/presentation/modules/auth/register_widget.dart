import 'package:ebntz/presentation/modules/auth/auth_controller.dart';
import 'package:ebntz/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterWidget extends ConsumerStatefulWidget {
  const RegisterWidget({super.key});

  @override
  ConsumerState<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends ConsumerState<RegisterWidget> {
  final TextEditingController _usernameController = TextEditingController(),
      _passwordController = TextEditingController(),
      _repeatPasswordController = TextEditingController();

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
          TextFormField(
            controller: _repeatPasswordController,
            decoration: const InputDecoration(labelText: 'Repetir contraseña'),
          ),
          const SizedBox(height: 20),
          CustomButton(
            onPressed: () {},
            child: const Text('Registrarse'),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              notifier.updateIsRegister(false);
            },
            child: const Text(
              'Iniciar sesión',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
