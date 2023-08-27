import 'dart:async';

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
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'No tienes conexión a internet',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Icon(
                Icons.signal_wifi_connected_no_internet_4_outlined,
                size: 50,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Por favor conéctate a una red',
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
