String hideEmail(String email) {
  if (email.isEmpty) {
    return "";
  }

  List<String> parts = email.split("@");
  if (parts.length != 2) {
    return email;
  }
  String username = parts[0];
  String domain = parts[1];
  if (username.length <= 2) {
    return email;
  }
  String hiddenUsername =
      "${username[0]}${'*' * (username.length - 2)}${username[username.length - 1]}";
  return "$hiddenUsername@$domain";
}
