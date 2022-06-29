// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final bool isEmail;
  final dynamic onSaved;

  MyTextFormField({
    required this.hintText,
    required this.onSaved,
    this.isPassword = false,
    this.isEmail = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        obscureText: isPassword ? true : false,
        validator: (value) {},
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}
