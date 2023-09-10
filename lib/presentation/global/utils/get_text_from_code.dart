import 'package:ebntz/generated/translations.g.dart';
import 'package:flutter/widgets.dart';

String getTextFromAuthCode({
  required BuildContext context,
  required String stringCode,
}) {
  switch (stringCode) {
    case 'weak-password':
      return texts.global.weakPassword;
    case 'email-already-in-use':
      return texts.global.thereIsAlreadyAnAccountThatUsesThisEmail;
    case 'user-not-found':
      return texts.global.thisUserDoesNotExist;
    case 'wrong-password':
      return texts.global.wrongPassword;
    case 'register-success':
      return texts.global.accountSuccessfullyRegistered;
    default:
      return texts.global.authentiactionError;
  }
}
