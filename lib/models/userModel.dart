// @JsonSerializable()
class UserSignIn {
  final int? id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  UserSignIn(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.password});

  factory UserSignIn.fromJson(Map<dynamic, dynamic> json) {
    return UserSignIn(
      id: json['idUserSignIn'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
    );
  }
  tojson() => {
        'firstName': firstName,
        'lastName': lastName,
        "email": email,
        "password": password,
      };
}

class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });
}
