import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../models/UserModel.dart';

class BtnGo extends StatelessWidget {
  const BtnGo({Key? key, required this.direction, required this.text}) : super(key: key);
  final direction;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
                  builder: (context) => this.direction,
              ));
            },
            child: Text(this.text,style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class InputForm extends StatelessWidget {
  const InputForm({Key? key, required this.controller, required this.textValidator, required this.textLabel}) : super(key: key);
  final controller;
  final String textValidator;
  final String textLabel;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 200,
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if ( value == null || value.isEmpty) {
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
  const BtnService({Key? key, required this.text, required this.email, required this.pass ,required this.setState, required this.userService,required this.formKey}) : super(key: key);
  final String text;
  final email;
  final pass;
  final setState;
  final userService;
  final formKey;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
      BorderRadius.all(Radius.elliptical(100, 100)),
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
              padding: const EdgeInsets.symmetric(
                  horizontal: 30, vertical: 15),
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              if(formKey.currentState!.validate() ){
                userService.auth((UserModel(email: email.value.text, password: pass.value.text)), context ).then((value) => {
                  if(value.id != null ){
                    setState(() {
                      email.text = "";
                      pass.text = "";
                    }),
                  }
                });
              };
            },
            child: Text(this.text,
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class PersonalCarousel extends StatelessWidget {
  const PersonalCarousel({Key? key, required this.files, required this.network}) : super(key: key);
  final List<String> files;
  final network;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400.0,
        initialPage: 0,
        enableInfiniteScroll: false,
        autoPlay: true,
      ),
      items: files.map((i) {
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
                  child: network ?
                        Image.network(
                          i,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
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
