import 'package:ebntz/generated/translations.g.dart';
import 'package:ebntz/const.dart';
import 'package:ebntz/presentation/global/utils/functions/launch_url.dart';
import 'package:flutter/material.dart';

class InfoView extends StatelessWidget {
  const InfoView({super.key});

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
          Text(
            texts.global.infoText1,
          ),
          const SizedBox(height: 20),
          Text(
            texts.global.infoText2,
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              goLaunchUrl(kPrivacyPolicyUrl);
            },
            child: Text(
              texts.global.privacyPolicy,
            ),
          ),
        ],
      ),
    );
  }
}
