import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../commons/commons.dart';
import '../connectionAndInscription/loadingPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({route , Key? key}) : super(key: key);
  static String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  List<String> files = [];

  Future getListeFile() async {
    var month = new DateTime.now().month;
    var year = new DateTime.now().year;
    final results = await FirebaseStorage.instance.ref('assets/uploadFiles/$month-$year/').listAll();

    for (var element in results.items) {
      files.add(await FirebaseStorage.instance.ref('assets/uploadFiles/$month-$year/${element.name}').getDownloadURL());
    }
    return files;
  }

  void logout() {
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
        title: Text('Home Pages'),
      ),
      body: Column(
        children: [
          Text('Photo du mois', style: TextStyle(color: Colors.white,)),
          FutureBuilder(
            future: getListeFile(),
            builder: ((context, snapshot) {
              if(snapshot.hasData){
                return PersonalCarousel(files: files, network: true,);
              }
              if(!snapshot.hasData){
                return CircularProgressIndicator();
              }
              return Container();
            }),
          ),
        ]
      ),
    );
  }
}


