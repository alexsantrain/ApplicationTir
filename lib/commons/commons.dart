import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../models/UserModel.dart';

class BtnGo extends StatelessWidget {
  const BtnGo({Key? key, required this.onpress, required this.text}) : super(key: key);
  final VoidCallback onpress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.elliptical(100, 100)),),backgroundColor: Color.fromRGBO(55, 139, 136, 0.5),padding:  EdgeInsets.symmetric(horizontal: 30, vertical: 15)
      ),
      onPressed: onpress,
      child: Text(text,
            style: TextStyle(
              fontSize: 20,
              color:  Colors.white,
            ),
      ),
    );
  }
}

class InputForm extends StatelessWidget {
  const InputForm({Key? key, required this.controller, required this.textValidator,required this.textLabel, required this.height, required this.width}): super(key: key);
  final TextEditingController controller;
  final String textValidator;
  final String textLabel;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
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


class PersonalCarousel extends StatelessWidget {
  const PersonalCarousel({Key? key, required this.files, required this.network, required this.height})
      : super(key: key);
  final List<String> files;
  final bool network;
  final double height;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: height,
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
