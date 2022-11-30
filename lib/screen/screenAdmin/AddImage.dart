import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tir/screen/dashboard/Home.dart';

import '../connectionAndInscription/loadingPage.dart';


class AddImage extends StatefulWidget {
  const AddImage({Key? key}) : super(key: key);

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  final _auth = FirebaseAuth.instance;
  List<String> Files = [];
  List<String> nameFiles = [];

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return;

    setState(() {
      Files = result.paths.map((path) => path!).toList();
      nameFiles = result.names.map((path) => path!).toList();
    });
  }

  Future uploadFile() async {
    for (var i = 0; i < Files.length; i++) {
      var month = new DateTime.now().month;
      var year = new DateTime.now().year;
      final path = 'assets/uploadFiles/$month-$year/${nameFiles[i]}';
      final ref = await FirebaseStorage.instance.ref().child(path).putFile(File(Files[i]));
    }
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                    child: getFilesWidegets(Files)
                ),
              ),
              ElevatedButton(onPressed: selectFile, child: Text('Select File',)),
              ElevatedButton(onPressed: uploadFile, child: Text('Upload File')),
              ElevatedButton(onPressed: () {
    Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => HomeScreen()));
              },child: Text('Allez a la vue des image ')),
              SizedBox(height: 32,),
            ],
          ),
        )
    );
  }

  Widget getFilesWidegets(List<String> files) {
    List<String> liste = [];

    for (var i = 0; i < files.length; i++) {
      liste.add(
          files[i].toString()
      );
    }
    return CarouselSlider(
      options: CarouselOptions(
        height: 400.0,
        initialPage: 0,
        enableInfiniteScroll: false,
        autoPlay: true,
      ),
      items: liste.map((i) {
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
                  color: Colors.red,
                  child: Image.file(
                    File(i),
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
}
