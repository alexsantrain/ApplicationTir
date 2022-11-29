import 'package:flutter/material.dart';
import 'package:tir/screen/connectionAndInscription/services/UserService.dart';

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
            title: Text('Saint Sylvestre Cappel Saint Sebastien',
                style: TextStyle(color: Colors.black, fontSize: 19))),
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
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.elliptical(100, 100)),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.elliptical(100, 100)),
                            color: Color.fromRGBO(55, 139, 136, 0.5),
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Connection()
                          ));
                        },
                        child: Text('Go !',style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
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
