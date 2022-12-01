import 'package:uuid/uuid.dart';

class UserModel {
  String email;
  String password;
  String id;
  String birthday;
  String lastname;
  String firstname;
  String Equipe;
  UserModel({ this.id = '', this.email = ' ', this.password = '', this.birthday = '', this.lastname = '', this.firstname = '', this.Equipe = '' });

  Map<String, dynamic> toJson() => {
    'firstname' : firstname,
    'lastname' : lastname,
    'birthday': birthday,
    'email' : email,
  };
}