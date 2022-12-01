import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../models/UserModel.dart';

class BtnGo extends StatelessWidget {
  const BtnGo({Key? key, required this.direction, required this.text})
      : super(key: key);
  final direction; //Utiliser plutôt un void Callback
  final String text;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // Voir plutôt Elevated Button et decoration, peut être pas forcément besoin d'un ClipRRect
      borderRadius: const BorderRadius.all(Radius.elliptical(100, 100)),
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
                builder: (context) => direction,
              ));
            },
            child: Text(text, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class InputForm extends StatelessWidget {
  const InputForm(
      {Key? key,
      required this.controller,
      required this.textValidator,
      required this.textLabel})
      : super(key: key);
  final controller; // Mieux typer en indiquant TextEditingController
  final String textValidator;
  final String textLabel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Peut être plutôt passer une height et width en paramètre pour que ce soit plus réutilisable
      height: 80,
      width: 200,
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return textValidator;
          }
          return null;
        },
        decoration: InputDecoration(
          label: Text(textLabel),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }
}

class BtnService extends StatelessWidget {
  // Quelle diff avec le premier btn ? Si c'est le côté email, etc, plutôt le passer dans le callback.
  const BtnService(
      {Key? key,
      required this.text,
      required this.email,
      required this.pass,
      required this.setState,
      required this.userService,
      required this.formKey})
      : super(key: key);
  final String text;
  final email; //Idem, typer au maximum
  final pass;
  final setState;
  final userService;
  final formKey;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.elliptical(100, 100)),
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
              if (formKey.currentState!.validate()) {
                userService
                    .auth(
                        (UserModel(
                            email: email.value.text,
                            password: pass.value.text)),
                        true,
                        context)
                    .then((value) => {
                          if (value.id != null)
                            {
                              setState(() {
                                email.text = "";
                                pass.text = "";
                              }),
                            }
                        });
              }
            },
            child: Text(text, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class PersonalCarousel extends StatelessWidget {
  const PersonalCarousel({Key? key, required this.files, required this.network})
      : super(key: key);
  final List<String> files;
  final network; // Typer pour avoir un bool
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height:
            400.0, // Idem, peut être passer la height quand on l'appelle plutôt
        initialPage: 0,
        enableInfiniteScroll: false,
        autoPlay: true,
      ),
      items: files.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: const BoxDecoration(color: Colors.amber),
              child: Container(
                  child: network
                      ? Image.network(
                          i,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(i),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )),
            );
          },
        );
      }).toList(),
    );
  }
}
