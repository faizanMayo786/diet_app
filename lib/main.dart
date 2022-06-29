import '/src/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DietApp());
}

class DietApp extends StatelessWidget {
  const DietApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: WelcomeScreen());
  }
}
