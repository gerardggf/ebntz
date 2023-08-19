import 'package:ebntz/domain/repositories/authentication_repository.dart';
import 'package:ebntz/presentation/global/const.dart';
import 'package:ebntz/presentation/global/controllers/session_controller.dart';
import 'package:ebntz/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OptionsDrawer extends ConsumerWidget {
  const OptionsDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 5,
          ),
          child: ListView(
            children: [
              const Text(
                'eBntz',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              if (ref
                      .watch(authenticationRepositoryProvider)
                      .firebaseCurrentUser !=
                  null)
                Text(
                  ref
                      .watch(authenticationRepositoryProvider)
                      .firebaseCurrentUser!
                      .email!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              const SizedBox(height: 15),
              ListTile(
                title: Text(
                  ref.watch(sessionControllerProvider) == null
                      ? 'Iniciar sesión / Registrarse'
                      : 'Perfil',
                  overflow: TextOverflow.ellipsis,
                ),
                minLeadingWidth: 30,
                leading: const Icon(
                  Icons.person,
                  color: kPrimaryColor,
                ),
                onTap: () {
                  context.pop();
                  context.pushNamed(Routes.profile);
                },
              ),
              ListTile(
                title: const Text('Compartir nuevo evento'),
                leading: const Icon(
                  Icons.add,
                  color: kPrimaryColor,
                ),
                minLeadingWidth: 30,
                onTap: () {
                  context.pop();
                  context.pushNamed(Routes.newPost);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
