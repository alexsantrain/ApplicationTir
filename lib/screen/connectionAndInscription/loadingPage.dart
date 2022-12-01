import 'package:flutter/material.dart';
import 'package:tir/screen/connectionAndInscription/services/UserService.dart';

import '../../commons/commons.dart';
import 'connection.dart';
class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);
  static String id = 'Loading';

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Saint Sylvestre Cappel Saint Sebastien')),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width:  MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color.fromRGBO(50, 129, 126, 1),
          ),
          child:SingleChildScrollView (
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(),
                Image(
                  image: AssetImage('assets/images/Blason.png', ),
                  height: 300,
                  width: 150,
                ),
                BtnGo(onpress: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Connection(),
                  ));
                },text: 'Go !'),
                Image(
                  image: AssetImage('assets/images/logo-archers.png'),
                  height: 300,
                  width: 150,
                ),
                Container(),
              ],
            ),
          )
        ));
  }
}
