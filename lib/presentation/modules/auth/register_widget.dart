import 'package:ebntz/presentation/global/utils/custom_snack_bar.dart';
import 'package:ebntz/presentation/global/utils/get_text_from_code.dart';
import 'package:ebntz/presentation/modules/auth/auth_controller.dart';
import 'package:ebntz/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterWidget extends ConsumerStatefulWidget {
  const RegisterWidget({super.key});

  @override
  ConsumerState<RegisterWidget> createState() => _RegisterWidgetState();
}

final _formKey = GlobalKey<FormState>();

//TODO: arreglar creacion usuario a veces no funciona

class _RegisterWidgetState extends ConsumerState<RegisterWidget> {
  final TextEditingController _usernameController = TextEditingController(),
      _passwordController = TextEditingController(),
      _repeatPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(authControllerProvider.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Regístrate e inicia sesión para poder compartir eventos y poder editar tu perfil',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextFormField(
              onChanged: (value) {
                notifier.updateEmail(value);
              },
              controller: _usernameController,
              decoration:
                  const InputDecoration(labelText: 'Correo electrónico'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value?.trim() == '') {
                  return 'El campo no puede estar vacío';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              onChanged: (value) {
                notifier.updatePassword(value);
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value?.trim() == '') {
                  return 'El campo no puede estar vacío';
                }
                return null;
              },
              obscureText: true,
            ),
            TextFormField(
              controller: _repeatPasswordController,
              decoration:
                  const InputDecoration(labelText: 'Repetir contraseña'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value?.trim() == '') {
                  return 'El campo no puede estar vacío';
                }
                if (value != _passwordController.text) {
                  return 'Las contraseñas no coinciden';
                }
                return null;
              },
              obscureText: true,
            ),
            const SizedBox(height: 30),
            CustomButton(
              onPressed: () async {
                register();
              },
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
      ),
    );
  }

  Future<void> register() async {
    final notifier = ref.watch(authControllerProvider.notifier);
    if (_formKey.currentState!.validate()) {
      final result = await notifier.register();
      if (mounted) {
        if (result == 'register-success') {
          notifier.updateIsRegister(false);
          showCustomSnackBar(
            context: context,
            text: 'Cuenta registrada con éxito',
            color: Colors.orange,
          );
        }
        showCustomSnackBar(
          context: context,
          text: getTextFromAuthCode(
            context: context,
            stringCode: result,
          ),
          color: Colors.orange,
        );
      }
    } else {
      showCustomSnackBar(
        context: context,
        text: 'Hay campos que no cumplen con las condiciones especificadas',
        color: Colors.orange,
      );
    }
  }
}
