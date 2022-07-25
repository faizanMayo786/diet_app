import 'dart:io';

import 'package:diet_suggestion_app/src/screens/login/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/util/logo_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          // height: 700,
          width: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 50,
                        top: 50,
                      ),
                      child: Logo(
                        width: 300,
                        height: 200,
                      ),
                    ),
                    Text(
                      "Welcome!",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                    Text(
                      "One must eat to live, not live to eat.",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  kIsWeb
                      ? Padding(
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
                                      primary: Colors.orange,
                                    ),
                                    onPressed: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MyLogin(label: 'Admin'),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Center(
                                            child: Center(
                                              child: Text(
                                                "Admin",
                                                style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.normal,
                                                  fontSize: 17.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 25,
                            right: 25,
                          ),
                          child: SizedBox(
                            height: 50,
                            width: 250,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: const Color(0XFFFBB81F),
                                    ),
                                    onPressed: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MyLogin(label: 'Customer'),
                                        ),
                                      );
                                      
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Center(
                                            child: Text(
                                              "Customer",
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 17.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                          ),
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
            ],
          ),
        ),
      ),
    );
  }
}
