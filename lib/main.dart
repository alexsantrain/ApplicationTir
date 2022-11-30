import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tir/screen/connectionAndInscription/loadingPage.dart';
import 'package:tir/screen/dashboard/Home.dart';
import 'package:tir/screen/screenAdmin/AddImage.dart';
import 'firebase_options.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> user;

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.black,),
        scaffoldBackgroundColor: const Color.fromRGBO(50, 129, 126, 1),
        appBarTheme: AppBarTheme(backgroundColor: Color.fromRGBO(50, 129, 126, 1)),
      ),
      initialRoute: FirebaseAuth.instance.currentUser == null ? LoadingPage.id : HomeScreen.id,
      routes: {
        LoadingPage.id: (context) => LoadingPage(),
        HomeScreen.id: (context) => AddImage(),
      },
      home: LoadingPage(),
    );
  }

}
