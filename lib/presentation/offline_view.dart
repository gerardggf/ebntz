import 'dart:async';

import 'package:ebntz/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/repositories/connectivity_repository.dart';

import 'routes/routes.dart';

class OfflineView extends ConsumerStatefulWidget {
  const OfflineView({super.key});

  @override
  ConsumerState<OfflineView> createState() => _OfflineViewState();
}

class _OfflineViewState extends ConsumerState<OfflineView> {
  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    super.initState();

    _streamSubscription =
        ref.read(connectivityRepositoryProvider).onInternetChanged.listen(
      (connected) {
        if (connected) {
          context.goNamed(Routes.splash);
        }
      },
    );
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                texts.global.youDoNotHaveInternet,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Icon(
                Icons.signal_wifi_connected_no_internet_4_outlined,
                size: 50,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                texts.global.connectToANetwork,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
