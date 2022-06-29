import 'package:diet_suggestion_app/src/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../core/util/logo_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF8C49F4),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: const [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 50,
                    top: 75,
                  ),
                  child: Logo(
                    width: 300,
                    height: 200,
                  ),
                ),
                Text(
                  "Welcome!",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  "\nOne must eat to live, not live to eat.",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.black),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: 10,
              ),
              child: SizedBox(
                height: 50,
                width: 250,
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0XFFFBB81F),
                        ),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyLogin(label: 'Admin'),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(
                                child: Center(
                                  child: Text(
                                    "Admin",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 17.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: 70,
              ),
              child: SizedBox(
                height: 50,
                width: 250,
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0XFFFBB81F),
                        ),
                        onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyLogin(label: 'User'),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(
                                child: Text(
                                  "Customer",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
