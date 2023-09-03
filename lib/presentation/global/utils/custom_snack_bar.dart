import 'package:flutter/material.dart';

import '../const.dart';

void showCustomSnackBar({
  required BuildContext context,
  required String text,
  Color color = AppColors.secondary,
  int milliseconds = 3000,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      duration: Duration(milliseconds: milliseconds),
    ),
  );
}
