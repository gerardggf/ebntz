class UserModel {
  final String id;
  final String username;
  final String email;
  final DateTime? creationDate;
  final bool verified;
  final bool isAdmin;
  final List<dynamic> favorites;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.creationDate,
    required this.verified,
    required this.favorites,
    required this.isAdmin,
  });

  UserModel copyWith({
    String? id,
    String? username,
    String? email,
    DateTime? creationDate,
    bool? verified,
    List<dynamic>? favorites,
    bool? isAdmin,
  }) =>
      UserModel(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        creationDate: creationDate ?? this.creationDate,
        verified: verified ?? this.verified,
        favorites: favorites ?? this.favorites,
        isAdmin: isAdmin ?? this.isAdmin,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        creationDate: DateTime.parse(json["creationDate"]),
        verified: json["verified"],
        favorites: json["favorites"],
        isAdmin: json["isAdmin"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "creationDate": creationDate.toString(),
        "verified": verified,
        "favorites": favorites,
        "isAdmin": isAdmin,
      };
}
