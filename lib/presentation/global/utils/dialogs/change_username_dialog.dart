import 'package:ebntz/domain/repositories/authentication_repository.dart';
import 'package:ebntz/presentation/global/controllers/session_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangeUsernameDialog extends ConsumerStatefulWidget {
  const ChangeUsernameDialog({
    super.key,
  });

  @override
  ConsumerState<ChangeUsernameDialog> createState() =>
      _ChangeUsernameDialogState();
}

class _ChangeUsernameDialogState extends ConsumerState<ChangeUsernameDialog> {
  final TextEditingController _usernameController = TextEditingController();

  late String username;

  @override
  void initState() {
    super.initState();

    _usernameController.text = ref
            .read(authenticationRepositoryProvider)
            .firebaseCurrentUser
            ?.displayName ??
        '';
    username = _usernameController.text;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Cambiar nombre de usuario'),
      content: TextField(
        controller: _usernameController,
        onChanged: (value) {
          username = value;
        },
        decoration: const InputDecoration(
          hintText: 'Nuevo nombre de usuario',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (username.isEmpty) return;
            await ref
                .read(authenticationRepositoryProvider)
                .updateDisplayName(username);
            ref.read(sessionControllerProvider.notifier).setUser(
                  (await ref
                      .read(authenticationRepositoryProvider)
                      .currentUser)!,
                );

            if (context.mounted) {
              Navigator.pop(context);
            }
          },
          child: const Text('Confirmar'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          child: const Text('Confirmar'),
        ),
      ],
    );
  }
}
