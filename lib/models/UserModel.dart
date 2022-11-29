import 'package:uuid/uuid.dart';

class UserModel {
  String email;
  String password;
  String id;
  UserModel({ this.id = '', this.email = ' ', this.password = ''});

  Map<String, dynamic> toJson() => {
    'email' : email,
    'password' : password,
    'uid' : id,
  };
}