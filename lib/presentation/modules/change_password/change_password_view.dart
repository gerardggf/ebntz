import 'package:ebntz/generated/translations.g.dart';
import 'package:ebntz/const.dart';
import 'package:ebntz/presentation/global/utils/custom_snack_bar.dart';
import 'package:ebntz/presentation/modules/change_password/change_password_controller.dart';
import 'package:ebntz/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../global/utils/functions/validate_fields.dart';

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
        title: Text(texts.global.changePassword),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            const Text(
              'eBntz',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              texts.global
                  .enterYourEmailAndWeWillSendYouALinkToRecoverYourPassword,
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: texts.global.email),
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
                      text: texts.global
                          .theLinkToChangeYourAccountPasswordHasBeenSentIfYouDoNotReceiveItCheckYourSpamFolder,
                    );
                  } else {
                    showCustomSnackBar(
                      context: context,
                      text: texts.global.theEnteredTextIsNotInEmailFormat,
                    );
                  }
                },
                child: Text(
                  texts.global.sendEmail,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
