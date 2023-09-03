import 'package:ebntz/presentation/global/const.dart';
import 'package:ebntz/presentation/global/utils/custom_snack_bar.dart';
import 'package:ebntz/presentation/modules/change_password/change_password_controller.dart';
import 'package:ebntz/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordView extends ConsumerStatefulWidget {
  const ChangePasswordView({super.key});

  @override
  ConsumerState<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends ConsumerState<ChangePasswordView> {
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(changePasswordControllerProvider);
    final notifier = ref.watch(changePasswordControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: const Text('Recuperar contraseña'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Introduce tu correo electrónico y te mandaremos un enlace para poder recuperar tu contraseña',
            ),
            const SizedBox(height: 10),
            TextField(
              decoration:
                  const InputDecoration(labelText: 'Correo electrónico'),
              onChanged: (value) {
                notifier.updateEmail(value);
              },
            ),
            const SizedBox(height: 30),
            if (controller.fetching)
              const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              )
            else
              CustomButton(
                onPressed: () async {
                  if (validateEmail(controller.email)) {
                    await notifier.sendEmail();
                    if (!mounted) return;
                    context.pop();
                    showCustomSnackBar(
                      milliseconds: 4000,
                      context: context,
                      text:
                          'Se ha enviado el enlace para el cambio de contraseña de tu cuenta. En caso de no recibirlo, comprueba tu bandeja de spam',
                    );
                  } else {
                    showCustomSnackBar(
                      context: context,
                      text: 'El correo electrónico no es válido',
                    );
                  }
                },
                child: const Text(
                  'Enviar correo electrónico',
                ),
              ),
          ],
        ),
      ),
    );
  }

  bool validateEmail(String email) {
    final regExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return regExp.hasMatch(email);
  }
}
