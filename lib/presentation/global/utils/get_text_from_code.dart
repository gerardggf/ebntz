import 'package:flutter/widgets.dart';

String getTextFromAuthCode({
  required BuildContext context,
  required String stringCode,
}) {
  switch (stringCode) {
    case 'weak-password':
      return 'Contraseña demasiado débil';
    case 'email-already-in-use':
      return 'Ya existe una cuenta que utiliza este correo electrónico';
    case 'user-not-found':
      return 'Este usuario no existe';
    case 'wrong-password':
      return 'Contraseña incorrecta';
    case 'register-success':
      return 'Cuenta creada con éxito';
    default:
      return 'Error de autenticación';
  }
}
