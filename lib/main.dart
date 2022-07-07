import 'package:firebase_core/firebase_core.dart';

import '/src/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  runApp(const DietApp());
}

class DietApp extends StatelessWidget {
  const DietApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: WelcomeScreen(),
    );
  }
}
