// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../model/user_prover.dart';
import '/src/screens/home/home_screen.dart';
import '../../../core/constants/constants.dart';
import '../../model/user.dart';
import '../../widget/drop_down_button.dart';

class BasicInfoForm extends StatefulWidget {
  BasicInfoForm({
    required this.username,
    required this.email,
    required this.password,
  });
  final String email, username, password;
  @override
  _BasicInfoFormState createState() => _BasicInfoFormState();
}

class _BasicInfoFormState extends State<BasicInfoForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    ageItems.addAll(
      List.generate(250, (index) => index.toString())
          .map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          );
        },
      ).toList(),
    );
    weightItems.addAll(
      List.generate(150, (index) => index.toString())
          .map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          );
        },
      ).toList(),
    );
    heightItems.addAll(
      List.generate(100, (index) => index.toString())
          .map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    ageItems.clear();
    heightItems.clear();
    weightItems.clear();
    genderItems.clear();
    model.age = 'Age';
    model.gender = 'Gender';
    model.height = 'Height';
    model.weight = 'Weight';
    ageItems = [
      const DropdownMenuItem<String>(
        value: 'Age',
        child: Text(
          'Age',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      )
    ];
    weightItems = [
      const DropdownMenuItem<String>(
        value: 'Weight',
        child: Text(
          'Weight',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      )
    ];

    heightItems = [
      const DropdownMenuItem<String>(
        value: 'Height',
        child: Text(
          'Height',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      )
    ];

    genderItems = [
      const DropdownMenuItem<String>(
        value: 'Gender',
        child: Text(
          'Gender',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      const DropdownMenuItem<String>(
        value: 'Single',
        child: Text(
          'Male',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      const DropdownMenuItem<String>(
        value: 'Female',
        child: Text(
          'Female',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    ];

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Information'),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'assets/images/user.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FormDropDownButton(
                          label: model.weight,
                          items: weightItems,
                          valueController: model.weight,
                          width: MediaQuery.of(context).size.width * 0.45,
                          suffix: 'kg',
                          // isEmail: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FormDropDownButton(
                          label: model.height,
                          items: heightItems,
                          valueController: model.height,
                          width: MediaQuery.of(context).size.width * 0.45,
                          suffix: 'cm',
                          // isEmail: true,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormDropDownButton(
                    label: model.age,
                    items: ageItems,
                    valueController: model.age,
                    width: MediaQuery.of(context).size.width,
                    suffix: '',
                    // isEmail: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormDropDownButton(
                    label: model.gender,
                    items: genderItems,
                    valueController: model.gender,
                    width: MediaQuery.of(context).size.width,
                    suffix: '',
                    // isEmail: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    // color: Colors.blueAccent,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: widget.email,
                                  password: widget.password);
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .set({
                            'username': widget.username,
                            'userId': FirebaseAuth.instance.currentUser!.uid,
                            'weight': model.weight,
                            'height': model.height,
                            'age': model.age,
                            'gender': model.gender,
                            'customer': 'yes',
                          });

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                            (route) => false,
                          );
                        } on Exception catch (e) {
                          // TODO
                        }
                      }
                    },
                    child: const SizedBox(
                      height: 40.0,
                      width: 90.0,
                      child: Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
