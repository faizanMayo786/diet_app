
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '/src/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCV4-iYZkzV2JmKQlAWYF5p34QnLDBCaBA",
        authDomain: "diet-plan-app.firebaseapp.com",
        projectId: "diet-plan-app",
        storageBucket: "diet-plan-app.appspot.com",
        messagingSenderId: "144829256111",
        appId: "1:144829256111:web:8b25ee8cf8b18c54775f5a",
      ),
    );
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
          colorScheme: ColorScheme.light(
        secondary: Colors.purple,
        primary: Colors.orange,
      )),
      home: WelcomeScreen(),
    );
  }
}
