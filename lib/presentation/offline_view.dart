import 'package:flutter/material.dart';

class OfflineView extends StatelessWidget {
  const OfflineView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'No tienes conexión a Internet',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
