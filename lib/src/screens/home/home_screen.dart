// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../model/item.dart';
import '../../model/user.dart';
import '../../widget/item_card.dart';
import '../../widget/text_form_field.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<String> label = ['Diet Plans', 'Account'];
  List body = [
    Container(
      //
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                color: Colors.white,
              ),
            ),
            CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 8.0,
              animation: true,
              percent: 0.73,
              center: const Text(
                "70.0%",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 48.0,
                  color: Colors.white,
                ),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.orange,
            ),
            Column(
              children: [

                SizedBox(
                  width: 180.0,
                  height: 40.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                    ),
                    child: Text(
                      "Update",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 20.0,
                          color: Colors.white),
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 10.0,),
                SizedBox(
                  width: 180.0,
                  height: 40.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                    ),
                    child: Center(
                      child: Text(
                        "Generate Meal Plan",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16.0,
                            color: Colors.white),
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    Container(
      child: Center(
        child: Form(
          child: Column(
            children: [
              MyTextFormField(
                hintText: 'What disease do you have?',
                onSaved: () {},
              ),
              MyTextFormField(
                hintText: 'How much time do you have this disease?',
                onSaved: () {},
              ),
              MyTextFormField(
                hintText: 'What are the symptoms of this disease?',
                onSaved: () {},
              ),
              MyTextFormField(
                hintText: 'What food is prohibited?',
                onSaved: () {},
              ),
            ],
          ),
        ),
      ),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          child: Icon(Icons.chat),
          onPressed: () {},
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 52, 52, 52),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Plans',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Account',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ), 
        backgroundColor: const Color.fromARGB(255, 52, 52, 52),
        appBar: AppBar( leading: SizedBox(), 
        actions: [Icon(Icons.logout_rounded)],
          centerTitle: true,
          title: Text(label[_selectedIndex]),
          backgroundColor: const Color.fromARGB(255, 52, 52, 52),
          elevation: 0,
        ),
        body: body[_selectedIndex]));
  }
}
