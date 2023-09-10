import 'package:ebntz/generated/translations.g.dart';
import 'package:ebntz/presentation/global/utils/custom_snack_bar.dart';
import 'package:ebntz/presentation/global/utils/get_text_from_code.dart';
import 'package:ebntz/presentation/global/utils/validate_fields.dart';
import 'package:ebntz/presentation/modules/auth/auth_controller.dart';
import 'package:ebntz/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../global/const.dart';

class RegisterWidget extends ConsumerStatefulWidget {
  const RegisterWidget({super.key});

  @override
  ConsumerState<RegisterWidget> createState() => _RegisterWidgetState();
}

final _registerFormKey = GlobalKey<FormState>();

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
      child: Form(
        key: _registerFormKey,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                texts.global
                    .registerAndLogInToBeAbleToShareEventsAndToEditYourProfile,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextFormField(
              onChanged: (value) {
                notifier.updateEmail(value);
              },
              controller: _usernameController,
              decoration: InputDecoration(labelText: texts.global.email),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value?.trim() == '') {
                  return texts.global.theFieldCannotbeEmpty;
                }
                if (!validateEmail(value ?? '')) {
                  return texts.global.theEnteredTextIsNotInEmailFormat;
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: texts.global.password),
              onChanged: (value) {
                notifier.updatePassword(value);
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value?.trim() == '') {
                  return texts.global.theFieldCannotbeEmpty;
                }
                if ((value?.length ?? 0) < 6) {
                  return texts.global.thePasswordMustHaveAMinimumOf6Characters;
                }
                return null;
              },
              obscureText: true,
            ),
            TextFormField(
              controller: _repeatPasswordController,
              decoration:
                  InputDecoration(labelText: texts.global.repeatPassword),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value?.trim() == '') {
                  return texts.global.theFieldCannotbeEmpty;
                }
                if (value != _passwordController.text) {
                  return texts.global.passwordsDoNotMatch;
                }
                return null;
              },
              obscureText: true,
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
                  register();
                },
                child: Text(texts.global.register),
              ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                notifier.updateIsRegister(false);
              },
              child: Text(
                texts.global.login,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> register() async {
    final notifier = ref.watch(authControllerProvider.notifier);
    if (_registerFormKey.currentState!.validate()) {
      final result = await notifier.register();
      if (mounted) {
        if (result == 'register-success') {
          notifier.updateIsRegister(false);
          showCustomSnackBar(
            context: context,
            text: texts.global.accountSuccessfullyRegistered,
            color: AppColors.secondary,
          );
        }
        showCustomSnackBar(
          context: context,
          text: getTextFromAuthCode(
            context: context,
            stringCode: result,
          ),
          color: AppColors.secondary,
        );
      }
    } else {
      showCustomSnackBar(
        context: context,
        text: texts.global.thereAreFieldsThatDoNotMeetTheSpecifiedConditions,
        color: AppColors.secondary,
      );
    }
  }
}
