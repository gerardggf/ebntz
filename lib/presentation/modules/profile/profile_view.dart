import 'package:ebntz/domain/repositories/authentication_repository.dart';
import 'package:ebntz/generated/translations.g.dart';
import 'package:ebntz/presentation/global/const.dart';
import 'package:ebntz/presentation/global/controllers/session_controller.dart';
import 'package:ebntz/presentation/global/utils/custom_snack_bar.dart';
import 'package:ebntz/presentation/global/utils/dialogs/change_username_dialog.dart';
import 'package:ebntz/presentation/global/utils/string_functions.dart';
import 'package:ebntz/presentation/modules/auth/auth_view.dart';
import 'package:ebntz/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../global/utils/date_functions.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final sessionController = ref.watch(sessionControllerProvider);
    final sessionControllerNotifier =
        ref.watch(sessionControllerProvider.notifier);

    return sessionController == null
        ? const AuthView()
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(texts.global.myProfile),
              backgroundColor: AppColors.primary,
            ),
            body: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(20).copyWith(bottom: 5),
                  child: Column(
                    children: [
                      Text(
                        sessionController.username,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        hideEmail(sessionController.email),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${texts.global.accountCreatedOn} ${dateToString(sessionController.creationDate)}',
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: const Icon(Icons.bookmark_outline),
                  minLeadingWidth: 30,
                  onTap: () {
                    context.pushNamed(Routes.favorites);
                  },
                  title: Text(texts.global.saved),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  minLeadingWidth: 30,
                  onTap: () async {
                    await showDialog<String>(
                      context: context,
                      builder: (_) {
                        return const ChangeUsernameDialog();
                      },
                    );
                  },
                  title: Text(texts.global.changeUsername),
                ),
                ListTile(
                  leading: const Icon(Icons.password_outlined),
                  minLeadingWidth: 30,
                  onTap: () {
                    context.pushNamed(Routes.changePassword);
                  },
                  title: Text(texts.global.changePassword),
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  minLeadingWidth: 30,
                  onTap: () async {
                    await sessionControllerNotifier.signOut();
                    if (mounted) {
                      showCustomSnackBar(
                        context: context,
                        text: texts.global.sessionHasBeenClosed,
                      );
                      Navigator.pop(context);
                    }
                  },
                  title: Text(
                    texts.global.logout,
                  ),
                ),
                const Divider(thickness: 1),
                ListTile(
                  leading: const Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.red,
                  ),
                  minLeadingWidth: 30,
                  onTap: () async {
                    if (await _deleteAccountDialogs()) {
                      await sessionControllerNotifier.setUser(null);
                      await ref
                          .read(authenticationRepositoryProvider)
                          .deleteAccount();
                      if (!mounted) return;
                      context.pop();
                      showCustomSnackBar(
                        context: context,
                        text: texts.global.theAccountHasBeenSuccessfullyDeleted,
                        color: Colors.red,
                      );
                    }
                  },
                  title: Text(
                    texts.global.deleteAccount,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          );
  }

  Future<bool> _deleteAccountDialogs() async {
    final result = await showDialog<bool?>(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(
          texts.global.areYouSureYouWantToDeleteYourAccount,
        ),
        title: Text(
          texts.global.deleteAccount,
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final result2 = await showDialog<bool?>(
                context: context,
                builder: (_) => AlertDialog(
                  content: Text(
                    texts.global
                        .yourDataWillBeDeletedButNotTheRoutesYouHaveCreatedHoweverTheyWillRemainAnonymousIfYouWantToDeleteThemPleaseDoItManually,
                  ),
                  title: Text(
                    texts.global.deleteAccount,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        context.pop(true);
                      },
                      child: Text(texts.global.confirm),
                    ),
                    TextButton(
                      onPressed: () {
                        context.pop(false);
                      },
                      child: Text(texts.global.cancel),
                    ),
                  ],
                ),
              );
              if (!mounted) return;
              context.pop(result2);
            },
            child: Text(texts.global.confirm),
          ),
          TextButton(
            onPressed: () {
              context.pop(false);
            },
            child: Text(texts.global.cancel),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}
