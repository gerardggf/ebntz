import 'package:ebntz/generated/translations.g.dart';
import 'package:ebntz/const.dart';
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
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: const Text(
                  'eBntz',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                sessionController!.username,
                textAlign: TextAlign.center,
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 15),
              ListTile(
                title: Text(
                  texts.global.profile,
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
              ListTile(
                title: Text(
                  texts.global.saved,
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
              ListTile(
                title: Text(
                  texts.global.info,
                  overflow: TextOverflow.ellipsis,
                ),
                minLeadingWidth: 30,
                leading: const Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.primary,
                ),
                onTap: () {
                  context.pop();
                  context.pushNamed(Routes.info);
                },
              ),
              ListTile(
                title: Text(texts.global.shareNewEvent),
                leading: const Icon(
                  Icons.add,
                  color: AppColors.primary,
                ),
                minLeadingWidth: 30,
                onTap: () {
                  context.pop();
                  context.pushNamed(Routes.newPost);
                },
              ),
              if (sessionController.isAdmin)
                ListTile(
                  leading: const Icon(
                    Icons.pending_actions,
                    color: Colors.red,
                  ),
                  onTap: () {
                    context.pop();
                    context.pushNamed(Routes.pendingApproval);
                  },
                  title: Text(
                    texts.global.pendingApproval,
                    style: const TextStyle(
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
