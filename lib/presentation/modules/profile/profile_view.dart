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
              title: const Text('Perfil'),
              backgroundColor: AppColors.primary,
            ),
            body: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
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
                ListTile(
                  leading: const Icon(Icons.bookmark_outline),
                  minLeadingWidth: 30,
                  onTap: () {
                    context.pushNamed(Routes.favorites);
                  },
                  title: const Text('Guardados'),
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
                  title: const Text('Cambiar nombre de usuario'),
                ),
                //TODO: pendiente cambiar contraseña
                ListTile(
                  leading: const Icon(Icons.password_outlined),
                  minLeadingWidth: 30,
                  onTap: () {
                    context.pushNamed(Routes.changePassword);
                  },
                  title: const Text('Cambiar contraseña'),
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  minLeadingWidth: 30,
                  onTap: () async {
                    await sessionControllerNotifier.signOut();
                    if (mounted) {
                      showCustomSnackBar(
                        context: context,
                        text: 'Sesión cerrada',
                      );
                      Navigator.pop(context);
                    }
                  },
                  title: const Text(
                    'Cerrar sesión',
                  ),
                ),
                const Divider(thickness: 1),
                ListTile(
                  leading: const Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.red,
                  ),
                  minLeadingWidth: 30,
                  onTap: () {},
                  title: const Text(
                    'Eliminar cuenta',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          );
  }
}
