import 'package:flutter/material.dart';

void showCustomSnackBar({
  required BuildContext context,
  required String text,
  Color color = Colors.black,
  int milliseconds = 2000,
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