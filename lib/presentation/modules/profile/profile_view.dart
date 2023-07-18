import 'package:ebntz/presentation/global/const.dart';
import 'package:ebntz/presentation/global/controllers/session_controller.dart';
import 'package:ebntz/presentation/global/utils/custom_snack_bar.dart';
import 'package:ebntz/presentation/modules/auth/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
              backgroundColor: kPrimaryColor,
            ),
            body: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                ListTile(
                  onTap: () {},
                  title: const Text('Cambiar nombre de usuario'),
                ),
                ListTile(
                  onTap: () {},
                  title: const Text('Cambiar contraseña'),
                ),
                ListTile(
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
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                const Divider(thickness: 1),
                ListTile(
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
