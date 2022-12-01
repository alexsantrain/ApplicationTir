

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tir/models/UserModel.dart';
import 'package:tir/screen/screenAdmin/AddImage.dart';

class UserService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel?> created(UserModel userModel, thiscontext ) async {
    UserCredential userCredential;
    try {
       userCredential = await _auth.createUserWithEmailAndPassword(email: userModel.email, password: userModel.password);
       userCredential = await _auth.signInWithEmailAndPassword(email: userModel.email, password: userModel.password);
       FirebaseFirestore.instance.collection('User').add({'firstname' : userModel.firstname,'lastname' : userModel.lastname,'birthday': userModel.birthday,'email' : userModel.email,'Equipe': userModel.Equipe}).then((value) => print('User Added')).catchError((error) => print("Failed to add user: $error"));
       Navigator.of(thiscontext).push(MaterialPageRoute(
         builder: (context) => const AddImage(),
       ));
    } catch(e) {
      print(e);
    }
    return userModel ;

  }


  
  Future<UserModel> auth(UserModel userModel, thiscontext) async {

    UserCredential userCredential;
    try {
        userCredential = await _auth.signInWithEmailAndPassword(email: userModel.email, password: userModel.password);
        Navigator.of(thiscontext).push(MaterialPageRoute(
          builder: (context) => const AddImage(),
        ));
    } catch(e) {
      print(e);
    }
    //userModel.setUid = userCredential.user.uid;

    return userModel;

  }

}

