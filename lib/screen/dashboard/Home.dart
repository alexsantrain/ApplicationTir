
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../connectionAndInscription/loadingPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({route , Key? key}) : super(key: key);
  static String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;

  void logout(){
    _auth.signOut();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LoadingPage()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              logout();
            }),
        title: Text('aa'),
      ),
      body: Text('cc'),
    );
  }
}
