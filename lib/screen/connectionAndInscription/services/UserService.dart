import 'package:firebase_auth/firebase_auth.dart';
import 'package:tir/models/UserModel.dart';

class UserService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  
  Future<UserModel> auth(UserModel userModel, login) async {

    
    UserCredential userCredential;
    print(userModel.toJson());
    try {
      if(login){
        userCredential = await _auth.signInWithEmailAndPassword(email: userModel.email, password: userModel.password);
      }else{
        userCredential = await _auth.createUserWithEmailAndPassword(email: userModel.email, password: userModel.password);
      }

    } catch(e) {
      print(e);
    }
    //userModel.setUid = userCredential.user.uid;

    return userModel;

  }
}

