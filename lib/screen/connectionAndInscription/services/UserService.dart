

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tir/models/UserModel.dart';
import 'package:tir/screen/screenAdmin/AddImage.dart';

class UserService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  


  
  Future<UserModel> auth(UserModel userModel, login, thiscontext) async {

    UserCredential userCredential;
    try {
      if(login){
        userCredential = await _auth.signInWithEmailAndPassword(email: userModel.email, password: userModel.password);
        Navigator.of(thiscontext).push(MaterialPageRoute(
          builder: (context) => const AddImage(),
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

  Future<UserModel> dbauth(UserModel userModel) async {
    try{
      FirebaseFirestore.instance.collection('User').add({'test': 'aaaa'}).then((value) => print('User Added')).catchError((error) => print("Failed to add user: $error"));
    } catch(e) {
      print(e);
    }
    return userModel;
  }
}

