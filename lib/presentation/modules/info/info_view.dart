import 'package:ebntz/generated/translations.g.dart';
import 'package:ebntz/const.dart';
import 'package:ebntz/presentation/global/utils/functions/launch_url.dart';
import 'package:flutter/material.dart';

class InfoView extends StatelessWidget {
  const InfoView({super.key});

  //TODO:traducir

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          texts.global.info,
        ),
        elevation: 0,
        backgroundColor: AppColors.primary,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 10),
          const Text(
            'eBntz',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            'Regístrate e inicia sesión para poder compartir eventos y que a la gente les aparezcan en la página principal.',
          ),
          const SizedBox(height: 20),
          const Text(
            'Una vez hayas hecho una publicación, esta quedará pendiente de ser aprobada por parte de un moderador para luego ser visible para todos los usuarios.',
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              goLaunchUrl(kPrivacyPolicyUrl);
            },
            child: const Text(
              'Política de privacidad',
            ),
          ),
        ],
      ),
    );
  }
}
