import 'package:flutter/material.dart';
import 'package:select_modal_flutter/select_modal_flutter.dart';
import 'package:tir/models/UserModel.dart';
import 'package:tir/screen/connectionAndInscription/services/UserService.dart';
import 'package:tir/screen/dashboard/Home.dart';

import 'connection.dart';
class Inscription extends StatefulWidget {
  const Inscription({Key? key}) : super(key: key);

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final _formKey = GlobalKey<FormState>();
  UserService _userService = UserService();

  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return 'Entrez  une address email valide';
    else
      return null;
  }

  String? validateLenghtPass(String? value) {
    if(value == null || value.isEmpty || value.toString().length <= 5 ){
      return 'Entrer un mot de passe supérieur à 5 caractère ';
    } else {
      return null;
    }
  }


  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _confirmPass = TextEditingController();
  TextEditingController controllerEquipe = TextEditingController();

  List<ItemSelect> listeEquipe = [
    ItemSelect(label: "Aucune"),
    ItemSelect(label: "Equipe A"),
    ItemSelect(label: "Equipe B"),
    ItemSelect(label: "Equipe C"),
    ItemSelect(label: "Equipe D"),
  ];

  @override
  void initState() {
    firstname.text = "";
    lastname.text = "";
    dateInput.text = "";
    email.text = "";
    _pass.text = "";
    _confirmPass.text = "";
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
           child: Text('Inscription'),),),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  child: Text(""),
                ),
                Container(
                  height: 85,
                  width: 200,
                  child: TextFormField(
                    controller: firstname,
                    validator: (value) {
                      if ( value == null || value.isEmpty) {
                        return 'Entrer votre Prénom';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: Text("Prénom", style: TextStyle(color: Colors
                          .black)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 85,
                  width: 200,
                  child: TextFormField(
                    controller: lastname,
                    validator: (value) {
                      if ( value == null || value.isEmpty) {
                        return 'Entrer votre Nom de Naissance';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: Text(
                          "Nom de Naissance", style: TextStyle(color: Colors
                          .black)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 215,
                  child: TextFormField(
                    controller: dateInput,
                    validator: (value) {
                      if ( value == null || value.isEmpty) {
                        return 'Entrer votre Date de Naissance';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.calendar_today),
                        labelText: "Votre date de Naissance"
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        String formattedDay = pickedDate.day.toString();
                        String formattedMonth = pickedDate.month.toString();
                        String formattedYear = pickedDate.year.toString();

                        print('$formattedDay/$formattedMonth/$formattedYear');
                        setState(() {
                          dateInput.text =
                          '$formattedDay/$formattedMonth/$formattedYear';
                        });
                      }
                    },
                  ),
                ),
                Container(child: Text(''),),
                Container(
                  height: 50,
                  width: 200,
                  child: SelectModalFlutter(
                    title: 'Votre équipe',
                    searchText: 'Selectionne Ton Equipe',
                    controller: controllerEquipe,
                    listItemSelect: listeEquipe,
                    borderTextField: InputBorder.none,
                    boxDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(color: Colors.black, width: 0.5),
                    ),
                  ),
                ),
                Container(child: Text(''),),
                Container(
                  height: 85,
                  width: 200,
                  child: TextFormField(
                    controller: email,
                    validator: (value) => validateEmail(value),
                    decoration: InputDecoration(
                      label: Text(
                          "Votre adresse email", style: TextStyle(color: Colors
                          .black)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 85,
                  width: 200,
                  child: TextFormField(
                    controller: _pass,
                    validator: (value) => validateLenghtPass(value),
                    decoration: InputDecoration(
                      label: Text(
                          "Votre mot de passe", style: TextStyle(color: Colors
                          .black)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 85,
                  width: 200,
                  child: TextFormField(
                    controller: _confirmPass,
                    validator: (value) {
                      if ( value == null || value.isEmpty ) {
                        return 'Entrer votre mot de passe';
                      } else if (value != _pass.text){
                        return 'Mot de passe pas identique';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      label: Text("Confirmer votre mot de passe",
                          style: TextStyle(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.elliptical(100, 100)),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.elliptical(100, 100)),
                            color: Color.fromRGBO(55, 139, 136, 0.5),
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30,
                              vertical: 15),
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          if(_formKey.currentState!.validate() && dateInput.value != "" ){
                            _userService.auth((UserModel(email: email.value.text, password: _pass.value.text)), false , context).then((value) => {
                              if(value.id != null ){
                                setState(() {
                                  firstname.text = "";
                                  lastname.text = "";
                                  dateInput.text = "";
                                  email.text = "";
                                  _pass.text = "";
                                  _confirmPass.text = "";
                                }),
                                Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomeScreen()
                            ))
                              }
                            });
                          };
                        },
                        child: Text('Go !', style: TextStyle(color: Colors
                            .white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
