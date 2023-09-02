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
    final sessionController = ref.watch(sessionControllerProvider);
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
                'ebntz',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              if (sessionController != null)
                Text(
                  sessionController.username,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              const SizedBox(height: 15),
              ListTile(
                title: Text(
                  sessionController == null
                      ? 'Iniciar sesión / Registrarse'
                      : 'Perfil',
                  overflow: TextOverflow.ellipsis,
                ),
                minLeadingWidth: 30,
                leading: const Icon(
                  Icons.person,
                  color: AppColors.primary,
                ),
                onTap: () {
                  context.pop();
                  context.pushNamed(Routes.profile);
                },
              ),
              if (sessionController != null)
                ListTile(
                  title: const Text(
                    'Guardados',
                    overflow: TextOverflow.ellipsis,
                  ),
                  minLeadingWidth: 30,
                  leading: const Icon(
                    Icons.bookmark,
                    color: AppColors.primary,
                  ),
                  onTap: () {
                    context.pop();
                    context.pushNamed(Routes.favorites);
                  },
                ),
              if (sessionController != null)
                ListTile(
                  title: const Text('Compartir nuevo evento'),
                  leading: const Icon(
                    Icons.add,
                    color: AppColors.primary,
                  ),
                  minLeadingWidth: 30,
                  onTap: () {
                    context.pop();
                    context.pushNamed(Routes.pendingApproval);
                  },
                ),
              if (sessionController?.isAdmin ?? false)
                ListTile(
                  leading: const Icon(
                    Icons.pending_actions,
                    color: Colors.red,
                  ),
                  onTap: () {
                    context.pop();
                    context.pushNamed(Routes.pendingApproval);
                  },
                  title: const Text(
                    'Pendientes de aprobar',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
