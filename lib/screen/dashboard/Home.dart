import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  List<String> Files = [];
  late int nombreDeFiles;

  Future getListeFile() async {
    var month = new DateTime.now().month;
    var year = new DateTime.now().year;
    final results = await FirebaseStorage.instance.ref('assets/uploadFiles/$month-$year/').listAll();

    results.items.forEach((element) async{

      Files.add(await FirebaseStorage.instance.ref('assets/uploadFiles/$month-$year/${element.name}').getDownloadURL());
    });
    nombreDeFiles = results.items.length;
    print(nombreDeFiles);
    return Files;
  }

  @override
  void initState() {
    super.initState();
    getListeFile();
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
              if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                return CarouselSlider(
                  options: CarouselOptions(
                    height: 400.0,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    autoPlay: true,
                  ),
                  items: Files.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              color: Colors.amber
                          ),
                          child: Container(
                              child: Image.network(
                                i,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              }
              if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData){
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


