import 'package:ebntz/presentation/global/utils/custom_snack_bar.dart';
import 'package:ebntz/presentation/global/utils/get_text_from_code.dart';
import 'package:ebntz/presentation/modules/auth/auth_controller.dart';
import 'package:ebntz/presentation/routes/routes.dart';
import 'package:ebntz/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../generated/translations.g.dart';
import '../../global/const.dart';
import '../../global/utils/validate_fields.dart';

class LoginWidget extends ConsumerStatefulWidget {
  const LoginWidget({super.key});

  @override
  ConsumerState<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends ConsumerState<LoginWidget> {
  final TextEditingController _emailController = TextEditingController(),
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
          const SizedBox(height: 10),
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
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Correo electrónico'),
            onChanged: (value) {
              notifier.updateEmail(value);
            },
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Contraseña'),
            onChanged: (value) {
              notifier.updatePassword(value);
            },
          ),
          const SizedBox(height: 30),
          if (controller.fetching)
            const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          else
            CustomButton(
              onPressed: () async {
                await _login();
              },
              child: Text(texts.global.login),
            ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () async {
              context.pushNamed(Routes.changePassword);
            },
            child: Text(
              texts.global.changePassword,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () async {
              notifier.updateIsRegister(true);
            },
            child: Text(
              texts.global.register,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _login() async {
    final controller = ref.read(authControllerProvider);
    final notifier = ref.read(authControllerProvider.notifier);
    FocusManager.instance.primaryFocus?.unfocus();

    if (!validateEmail(controller.email)) {
      showCustomSnackBar(
        context: context,
        text: texts.global.theEnteredTextIsNotInEmailFormat,
      );
      return;
    }
    if (_emailController.text.replaceAll(' ', '').isEmpty ||
        _passwordController.text.replaceAll(' ', '').isEmpty) {
      showCustomSnackBar(
        context: context,
        text: texts.global.theFieldCannotbeEmpty,
      );
      return;
    }

    final result = await notifier.login();
    result.when(
      left: (failure) {
        showCustomSnackBar(
          context: context,
          text: getTextFromAuthCode(context: context, stringCode: failure),
          color: AppColors.secondary,
        );
      },
      right: (_) {},
    );
  }
}
