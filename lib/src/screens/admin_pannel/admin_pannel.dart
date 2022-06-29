// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:diet_suggestion_app/src/model/item.dart';
import 'package:diet_suggestion_app/src/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final _formKey = GlobalKey<FormState>();
  Item model = Item(
      id: 0,
      name: '',
      description: '',
      image: '',
      rating: 0.0,
      ratingCount: 0,
      price: 0.0,
      color: 0,
      vitamins: [],
      ingrediants: []);

  int index = 1;

  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 52, 52, 52),
          currentIndex: index,
          onTap: (value) {
            setState(() {
              value = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: 'add',
              icon: Icon(
                Icons.car_crash,
              ),
            ),
            BottomNavigationBarItem(
              label: 'query',
              icon: Icon(
                Icons.car_crash,
              ),
            )
          ]),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topCenter,
                        width: halfMediaWidth,
                        child: MyTextFormField(
                          hintText: 'id',
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        width: halfMediaWidth,
                        child: MyTextFormField(
                          hintText: 'name',
                        ),
                      ),
                    ],
                  ),
                ),
                MyTextFormField(
                  hintText: 'descrription',
                  // isEmail: true,
                ),
                MyTextFormField(
                  hintText: 'image',
                  // isPassword: true,
                ),
                MyTextFormField(
                  hintText: 'rating',
                  // isPassword: true,
                ),
                MyTextFormField(
                  hintText: 'ratingCount',
                  // isPassword: true,
                ),
                MyTextFormField(
                  hintText: 'price',
                  // isPassword: true,
                ),
                MyTextFormField(
                  hintText: 'color',
                  // isPassword: true,
                ),
                MyTextFormField(
                  hintText: 'vitamins',
                  // isPassword: true,
                ),
                MyTextFormField(
                  hintText: 'ingredients',
                  // isPassword: true,
                ),
                RaisedButton(
                  color: Colors.blueAccent,
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
                        'Add Form',
                        style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
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
