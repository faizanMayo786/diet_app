// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final dynamic onSaved;

  MyTextFormField({
    required this.hintText,
    required this.onSaved,
    required this.controller,
  });

  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[100],
        ),
        validator: (value) {},
        keyboardType: TextInputType.text,
      ),
    );
  }
}
