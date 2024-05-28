class Users {
  final int? id;
  final String name;
  final String email;
  final int? phone;
  final String pass;

  Users({
    this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.pass,
  });

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        pass: json["pass"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "pass": pass,
      };
}
