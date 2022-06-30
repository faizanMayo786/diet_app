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

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<String> label = ['Add Diet Item', 'Queries'];
  List body() {
    return [
      Center(
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
                MyTextFormField(
                  hintText: 'Name',
                ),

                // MyTextFormField(
                //   hintText: 'Image',// we dont need this image field we will add image picker instead try to add
                //   // isPassword: true,
                // ),
                MyTextFormField(
                  hintText: 'Rating',
                  // isPassword: true,
                ),
                // MyTextFormField(
                //   hintText: 'ratingCount',
                //   // isPassword: true,
                // ),
                MyTextFormField(
                  hintText: 'Price',
                  // isPassword: true,
                ),
                // MyTextFormField(
                //   hintText: 'color',
                //   // isPassword: true,
                // ), also wee  will try to add color picker
                MyTextFormField(
                  hintText: 'Description', //
                  line: 3,
                  // isEmail: true, // or ui me symmetry mean HCI concepts ka kheyal rkha kro yeh kro then baki dekhte
                ),
                MyTextFormField(
                  hintText: 'Vitamins',
                  line: 3,
                  // isPassword: true,
                ),
                MyTextFormField(
                  hintText: 'Ingredients',
                  line: 3,
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
                            fontSize: 20.0,
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
      Container(
        child: Center(child: Text('Query')),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 52, 52, 52),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Query',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      backgroundColor: const Color.fromARGB(255, 52, 52, 52),
      appBar: AppBar(
        title: Text(label[_selectedIndex]),
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 52, 52, 52),
      ),
      body: body()[_selectedIndex],
    );
  }
}

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final bool isEmail;
  final int line;
  MyTextFormField({
    required this.hintText,
    this.isPassword = false,
    this.isEmail = false,
    this.line = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLines: line,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        obscureText: isPassword ? true : false,
        keyboardType: line > 1 ? TextInputType.multiline : TextInputType.text,
      ),
    );
  }
}
