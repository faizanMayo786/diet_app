// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable

import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final dynamic onSaved;
  final bool readOnly;
  MyTextFormField({
    Key? key,
    required this.hintText,
    required this.onSaved,
    required this.controller,
    this.readOnly = false,
  }) : super(key: key);

  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[100],
        ),
        validator: (value) {
          return null;
        },
        readOnly: readOnly,
        keyboardType: TextInputType.text,
      ),
    );
  }
}
