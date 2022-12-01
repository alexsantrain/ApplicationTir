import 'package:flutter/material.dart';
import 'package:tir/screen/connectionAndInscription/inscription.dart';
import 'package:tir/screen/connectionAndInscription/services/UserService.dart';

import '../../commons/commons.dart';
import '../../models/UserModel.dart';
import '../dashboard/Home.dart';

class Connection extends StatefulWidget {
  const Connection({Key? key}) : super(key: key);

  @override
  State<Connection> createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  final _formKey = GlobalKey<FormState>();
  UserService _userService = UserService();
  TextEditingController email = TextEditingController();
  TextEditingController _pass = TextEditingController();

  @override
  void initState() {
    email.text = "";
    _pass.text = "";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Saint Sylvestre Cappel Saint Sebastien'),),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color.fromRGBO(50, 129, 126, 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage(
                          'assets/images/logo-archers.png',
                        ),
                        height: 200,
                        width: 150,
                      ),
                      InputForm(controller: email, textValidator: 'Entrer votre email', textLabel: 'Votre adresse email',height: 80,width: 200),
                      InputForm(controller: _pass, textValidator: 'Entrer votre mot de passe', textLabel: 'Votre mot de passe', height: 80,width: 200,),
                      TextButton(
                        style:  TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(10, 25),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.centerLeft),
                        onPressed: () {},
                        child: Text(
                          "Mot de passe oublié ",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextButton(
                        style:  TextButton.styleFrom(
                            padding: EdgeInsets.only(bottom: 8),
                            minimumSize: Size(60, 55),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.centerLeft),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Inscription()
                          ));
                        },
                        child: Text(
                          "Inscription",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      BtnGo(text: 'Go !', onpress: () {
                        if (_formKey.currentState!.validate()) {
                          _userService
                              .auth(
                              (UserModel(
                                  email: email.value.text,
                                  password: _pass.value.text)),
                              context)
                              .then((value) => {
                            if (value.id != null)
                              {
                                setState(() {
                                  email.text = "";
                                  _pass.text = "";
                                }),
                              }
                          });
                        }
                      },),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Image(
                          image:
                          AssetImage('assets/images/drapeau-flandre.jpg'),
                          width: 200,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

