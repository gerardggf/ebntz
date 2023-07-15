import 'package:ebntz/presentation/global/const.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Perfil'),
        backgroundColor: kPrimaryColor,
      ),
      body: Container(),
    );
  }
}
