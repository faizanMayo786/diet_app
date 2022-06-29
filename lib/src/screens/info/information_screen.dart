// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:diet_suggestion_app/src/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import '../../model/user.dart';
import '../../widget/drop_down_button.dart';

Model model = Model(
  weight: 'Weight',
  height: 'Height',
  age: 'Age',
  gender: 'Gender',
  disease: '',
  registerDate: '',
);
class BasicInfoForm extends StatefulWidget {
  @override
  _BasicInfoFormState createState() => _BasicInfoFormState();
}

class _BasicInfoFormState extends State<BasicInfoForm> {
  final _formKey = GlobalKey<FormState>();
  

  List<DropdownMenuItem> ageItems = [
    const DropdownMenuItem(
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
  List<DropdownMenuItem> weightItems = [
    const DropdownMenuItem(
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
  List<DropdownMenuItem> heightItems = [
    const DropdownMenuItem(
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
  List<DropdownMenuItem> genderItems = [
    const DropdownMenuItem(
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
    const DropdownMenuItem(
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
    const DropdownMenuItem(
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
  Widget build(BuildContext context) {
    // final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 52, 52, 52),
      appBar: AppBar(
        title: const Text('Basic Information'),
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 52, 52, 52),
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => HomeScreen()),
                            ),
                            (route) => false);
                      }
                    },
                    child: const SizedBox(
                      height: 50.0,
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

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final bool isEmail;

  MyTextFormField({
    required this.hintText,
    this.isPassword = false,
    this.isEmail = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        obscureText: isPassword ? true : false,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}
