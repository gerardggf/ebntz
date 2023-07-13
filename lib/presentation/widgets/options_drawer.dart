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
              const SizedBox(height: 15),
              ListTile(
                title: const Text('Perfil'),
                leading: const Icon(
                  Icons.person,
                  color: Colors.black,
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
                  color: Colors.black,
                ),
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
