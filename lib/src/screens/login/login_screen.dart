// ignore_for_file: library_private_types_in_public_api, must_be_immutable, use_build_context_synchronously, unused_catch_clause

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/core/constants/constants.dart';
import '/src/screens/signup/sign_up_screen.dart';

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
      decoration: widget.label == 'Admin'
          ? const BoxDecoration()
          : const BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage('assets/images/login.png'),
                fit: BoxFit.cover,
              ),
            ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width > 600 ? 400 : 400,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 35, top: 80),
                  child: Text(
                    "Welcome\nBack ${widget.label}",
                    style: TextStyle(
                        color: widget.label == 'Admin'
                            ? Colors.black
                            : Colors.white,
                        fontSize: 33),
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
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              email = value;
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
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              pass = value;
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
                                  onPressed: () async {
                                    if (widget.label == 'Customer') {
                                      try {
                                        await FirebaseAuth.instance
                                            .signInWithEmailAndPassword(
                                                email: email, password: pass);
                                        Navigator.of(context).pop();
                                      } on FirebaseException catch (e) {
                                        snackBar(context, e.message.toString());
                                      }
                                    }
                                    if (widget.label == 'Admin') {
                                      if (_formKey.currentState!.validate()) {
                                        try {
                                          await FirebaseAuth.instance
                                              .signInWithEmailAndPassword(
                                                  email: email, password: pass);
                                          Navigator.of(context).pop();
                                        } on FirebaseException catch (e) {
                                          snackBar(
                                              context, 'Invalid Credential');
                                        }
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
                            visible: widget.label == 'Customer' ? true : false,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        primary: Colors.red),
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) =>
                                              const MyRegister()),
                                        ),
                                        (route) => false,
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
            ),
          ),
        ),
      ),
    );
  }
}
