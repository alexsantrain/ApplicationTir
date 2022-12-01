

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tir/models/UserModel.dart';
import 'package:tir/screen/screenAdmin/AddImage.dart';

class UserService {
  FirebaseAuth _auth = FirebaseAuth.instance;


  
  Future<UserModel> auth(UserModel userModel, login, thiscontext) async {

    
    UserCredential userCredential;
    print(userModel.toJson());
    try {
      if(login){
        userCredential = await _auth.signInWithEmailAndPassword(email: userModel.email, password: userModel.password);
        Navigator.of(thiscontext).push(MaterialPageRoute(
          builder: (context) => AddImage(),
        ));
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

