import 'package:ebntz/presentation/global/const.dart';
import 'package:ebntz/presentation/modules/auth/auth_view.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool logged = false;

  @override
  Widget build(BuildContext context) {
    return !logged
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
                  onTap: () {},
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
