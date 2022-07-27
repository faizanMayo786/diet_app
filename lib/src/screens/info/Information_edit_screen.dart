// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../model/user_prover.dart';
import '../../widget/drop_down_button.dart';
import '../../widget/text_form_field.dart';

class InformationEditScreen extends StatefulWidget {
  const InformationEditScreen({Key? key}) : super(key: key);

  @override
  State<InformationEditScreen> createState() => _InformationEditScreenState();
}

class _InformationEditScreenState extends State<InformationEditScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();

    firebaseData();
  }

  firebaseData() async {
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
    await Future.delayed(Duration.zero);
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    model.age = snapshot.data()!['age'];
    model.gender = snapshot.data()!['gender'];
    model.height = snapshot.data()!['height'];
    model.weight = snapshot.data()!['weight'];
    nameController.text = snapshot.data()!['username'];
    setState(() {});
  }

  @override
  void dispose() {
    model.age = 'Age';
    model.gender = 'Gender';
    model.height = 'Height';
    model.weight = 'Weight';
    nameController.text = '';

    heightItems.clear();
    weightItems.clear();
    genderItems.clear();
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
        value: 'Male',
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
        title: const Text('Account Screen'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              MyTextFormField(
                hintText: 'Name',
                controller: nameController,
                onSaved: () {},
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
                        label:'Weight',
                        items: weightItems,
                        valueController: model.weight,
                        width: MediaQuery.of(context).size.width * 0.45,
                        suffix: 'kg',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormDropDownButton(
                        label: 'Height',
                        items: heightItems,
                        valueController: model.height,
                        width: MediaQuery.of(context).size.width * 0.45,
                        suffix: 'cm',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormDropDownButton(
                  label: 'Age',
                  items: ageItems,
                  valueController: model.age,
                  width: MediaQuery.of(context).size.width,
                  suffix: '',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormDropDownButton(
                  label: 'Gender',
                  items: genderItems,
                  valueController: model.gender,
                  width: MediaQuery.of(context).size.width,
                  suffix: '',
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
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          'username': nameController.text,
                          'userId': FirebaseAuth.instance.currentUser!.uid,
                          'weight': model.weight,
                          'height': model.height,
                          'age': model.age,
                          'gender': model.gender,
                          'customer': 'yes',
                        });
                      } on FirebaseException catch (e) {
                        snackBar(context, e.message.toString());
                      }
                    }
                  },
                  child: const SizedBox(
                    width: 50.0,
                    child: Center(
                      child: Text(
                        'Save',
                        style: TextStyle(
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
    );
  }
}
