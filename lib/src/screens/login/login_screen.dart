// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:diet_suggestion_app/src/screens/admin_pannel/admin_pannel.dart';
import 'package:diet_suggestion_app/src/screens/home/home_screen.dart';
import 'package:diet_suggestion_app/src/screens/signup/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyLogin extends StatefulWidget {
  MyLogin({Key? key, required this.label}) : super(key: key);
  String label;
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String pass = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 52, 52, 52),
        image: DecorationImage(
            image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                if (widget.label == 'Admin') return AdminPanel();
                return HomeScreen();
              }
              return Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 35, top: 80),
                    child: Text(
                      "Welcome\nBack ${widget.label}",
                      style: TextStyle(color: Colors.white, fontSize: 33),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          right: 35,
                          left: 35,
                          top: MediaQuery.of(context).size.height * 0.5),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !value.contains("@") ||
                                    !value.contains(".")) {
                                  return "Enter Valid Email";
                                } else
                                  return null;
                              },
                              onChanged: (value) {
                                email = value;
                                print(email);
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Valid Password";
                                } else
                                  return null;
                              },
                              onChanged: (value) {
                                pass = value;
                                print(pass);
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: widget.label == 'Admin' ? 100 : 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Color(0xff4c505b),
                                    fontSize: 27,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.orange,
                                  child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      if (widget.label == 'Customer') {
                                        if (_formKey.currentState!.validate()) {
                                          FirebaseAuth.instance
                                              .signInWithEmailAndPassword(
                                                  email: email, password: pass);
                                        }
                                        // Navigator.pushAndRemoveUntil(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //       builder: ((context) => HomeScreen()),
                                        //     ),
                                        //     (route) => false);
                                      }
                                      if (widget.label == 'Admin') {
                                        if (_formKey.currentState!.validate()) {
                                          FirebaseAuth.instance
                                              .signInWithEmailAndPassword(
                                                  email: email, password: pass);
                                        }
                                      
                                      }
                                    },
                                    icon: const Icon(Icons.arrow_forward),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Visibility(
                              visible:
                                  widget.label == 'Customer' ? true : false,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                          primary: Colors.red),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: ((context) =>
                                                MyRegister()),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
