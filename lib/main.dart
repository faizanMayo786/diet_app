import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '/src/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

import 'core/constants/firebase_options.dart';
import 'src/screens/admin_pannel/admin_pannel.dart';
import 'src/screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(options: firebaseOption);
  }
  runApp(const DietApp());
}

class DietApp extends StatelessWidget {
  const DietApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: const ColorScheme.light(
        secondary: Colors.purple,
        primary: Colors.orange,
      )),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              if (kIsWeb) return AdminPanel();
              return HomeScreen();
            }
            return const WelcomeScreen();
          }),
    );
  }
}
