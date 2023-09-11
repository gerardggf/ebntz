bool validateEmail(String email) {
  final regExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  return regExp.hasMatch(email);
}
