

import 'dart:io';

import 'package:file_picker/file_picker.dart';
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
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null ) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    final path = 'assets/uploadFiles/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });


    final snapshot = await uploadTask!.whenComplete(() => {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: $urlDownload');

    setState(() {
      uploadTask = null;
    });
  }

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
        title: Text('Home Pages'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(pickedFile != null)
              Expanded(
                child: Container(
                  color: Colors.blue,
                  child: Image.file(
                    File(pickedFile!.path!),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                ),
              ),
            ElevatedButton(onPressed: selectFile, child: Text('Select File')),
            ElevatedButton(onPressed: uploadFile, child: Text('Upload File')),
            SizedBox(height: 32,),
            buidProgress(),
          ],
        ),
      )
    );
  }
  Widget buidProgress() => StreamBuilder<TaskSnapshot>(
    stream: uploadTask?.snapshotEvents,
    builder: (context, snaphot){
      if(snaphot.hasData){
        final data = snaphot.data!;
        double progress = data.bytesTransferred / data.totalBytes;

        return SizedBox(
          height: 50,
          child: Stack(
            fit: StackFit.expand,
            children: [
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey,
                color: Colors.green,
              ),
              Center(
                child: Text(
                  '${(100 * progress).roundToDouble()} %',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        );
      }else {
        return const SizedBox(height: 50,);
      }
    }
  );
}
