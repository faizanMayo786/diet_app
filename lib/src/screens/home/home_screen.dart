// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_suggestion_app/src/screens/info/Information_edit_screen.dart';
import '/src/screens/message/message_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../model/item.dart';
import '../../model/user.dart';
import '../../widget/item_card.dart';
import '../../widget/text_form_field.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  TextEditingController diseaseController = TextEditingController();
  TextEditingController occuranceController = TextEditingController();
  TextEditingController symptomsController = TextEditingController();
  TextEditingController prohibitedFoodController = TextEditingController();
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<String> label = ['Diet Plans', 'Account'];
  List body() => [
        Container(
          //
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Progress',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 24.0,
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
                        child: const Text(
                          "Update",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16.0,
                              color: Colors.white),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      width: 180.0,
                      height: 40.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                        ),
                        child: const Center(
                          child: const Text(
                            "Generate Meal Plan",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 16.0,
                                color: Colors.white),
                          ),
                        ),
                        onPressed: () async {
                          print(await FirebaseAuth.instance.currentUser!.uid);
                        },
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyTextFormField(
                    hintText: 'What disease do you have?',
                    onSaved: () {},
                    controller: diseaseController,
                  ),
                  MyTextFormField(
                    hintText: 'How much time do you have this disease?',
                    controller: occuranceController,
                    onSaved: () {},
                  ),
                  MyTextFormField(
                    hintText: 'What are the symptoms of this disease?',
                    controller: symptomsController,
                    onSaved: () {},
                  ),
                  MyTextFormField(
                    hintText: 'What food is prohibited?',
                    controller: prohibitedFoodController,
                    onSaved: () {},
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('health')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .set({
                          'disease': diseaseController.text,
                          'occurance': occuranceController.text,
                          'prohibitedFood': prohibitedFoodController.text,
                          'symptoms': symptomsController.text,
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: const Text('Medical Details Submitted!'),
                          ),
                        );
                      },
                      child: const Text('Submit')),
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
          child: const Icon(
            Icons.chat,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: const Text('Chat'),
                    centerTitle: true,
                  ),
                  body: MessageScreen(
                    user: FirebaseAuth.instance.currentUser!.uid,
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
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
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InformationEditScreen()));
            },
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Confirm"),
                    content: const Text('You want to Sign-Out?'),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          Navigator.of(context).pop();

                          await FirebaseAuth.instance.signOut();
                        },
                        child: const Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('No'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(
                Icons.logout,
              ),
            )
          ],
          centerTitle: true,
          title: Text(label[_selectedIndex]),
        ),
        body: body()[_selectedIndex]));
  }
}
