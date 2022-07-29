// ignore_for_file: unused_import, use_build_context_synchronously, unnecessary_null_comparison

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_suggestion_app/core/constants/constants.dart';
import 'package:diet_suggestion_app/src/screens/detail/desease_form.dart';
import 'package:diet_suggestion_app/src/screens/info/information_edit_screen.dart';
import '../../widget/drop_down_button.dart';
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
  const HomeScreen({
    Key? key,
    this.index = 0,
  }) : super(key: key);
  final index;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String disease = 'Diabetes 1';
  String username = '';
  String currentDisease = '';
  var _selectedIndex = 0;
  String status = 'No Plan Generated';
  @override
  initState() {
    super.initState();

    getDietPlan();
    _selectedIndex = widget.index;
  }

  getName() async {
    var name = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = name.data()!['username'].toString();
      currentDisease = name.data()!['disease'].toString();
    });
  }

  var data;
  getDietPlan() async {
    setState(() {
      _isLoading = true;
    });
    getName();
    var id = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (id.data()!['dietplanId'].toString().trim() != '' &&
        id.data()!['dietplanId'] != null) {
      var snapshot = await FirebaseFirestore.instance
          .collection('diet-plan')
          .doc(id.data()!['dietplanId'])
          .get();
      if (snapshot.data() == null) {
        setState(() {
          _isLoading = false;
        });
      }
      data = snapshot.data();
    } else {
      data = null;
    }
    if (id.data()!['status'] != null) {
      status = id.data()!['status'];
    }
    setState(() {
      _isLoading = false;
    });
  }

  List buttonNames = [
    'Diabetes I',
    'Diabetes II',
    'Liver',
    'Heart Disease',
    'Stomach Disease'
  ];
  bool _isLoading = false;
  List<String> label = ['Diet Plans', 'Disease'];
  body() => [
        Container(
          //
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Status: $status',
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18.0,
                  ),
                ),
                // CircularPercentIndicator(
                //   radius: 100.0,
                //   lineWidth: 8.0,
                //   animation: true,
                //   percent: 0.73,
                //   center: const Text(
                //     "70.0%",
                //     style: TextStyle(
                //       fontWeight: FontWeight.w300,
                //       fontSize: 48.0,
                //     ),
                //   ),
                //   circularStrokeCap: CircularStrokeCap.round,
                //   progressColor: Colors.orange,
                // ),
                Container(
                  height: 500,
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : data != null
                          ? Center(
                              child: SingleChildScrollView(
                                  child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Divider(),
                                    Row(
                                      children: [
                                        const SizedBox(
                                            width: 60,
                                            child: Text('Pre-Breakfast')),
                                        const VerticalDivider(),
                                        SizedBox(
                                          width: 250,
                                          child: Text(data['prebreakfast']),
                                        )
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      children: [
                                        const SizedBox(
                                            width: 60,
                                            child: Text('Breakfast')),
                                        const VerticalDivider(),
                                        SizedBox(
                                          width: 250,
                                          child: Text(data['breakfast']),
                                        )
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      children: [
                                        const SizedBox(
                                            width: 60, child: Text('Snacks')),
                                        const VerticalDivider(),
                                        SizedBox(
                                          width: 250,
                                          child: Text(data['snacks']),
                                        )
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      children: [
                                        const SizedBox(
                                            width: 60, child: Text('Lunch')),
                                        const VerticalDivider(),
                                        SizedBox(
                                            width: 250,
                                            child: Text(data['lunch']))
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 60,
                                          child: Text(
                                            'Dinner',
                                          ),
                                        ),
                                        const VerticalDivider(),
                                        SizedBox(
                                          width: 250,
                                          child: Text(
                                            data['dinner'].toString(),
                                            maxLines: 3,
                                          ),
                                        )
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 60,
                                          child: Text(
                                            'Bed Time',
                                            maxLines: 3,
                                            softWrap: false,
                                            style: TextStyle(),
                                          ),
                                        ),
                                        const VerticalDivider(),
                                        SizedBox(
                                            width: 250,
                                            child: Text(data['bedtime']))
                                      ],
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              )),
                            )
                          : const Center(
                              child: Text(
                                  'Tap on Generate Button to Generate Plan'),
                            ),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: 160.0,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: _isLoading ? Colors.grey : Colors.orange,
                        ),
                        onPressed: _isLoading
                            ? () {}
                            : () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                String uid =
                                    FirebaseAuth.instance.currentUser!.uid;
                                String newstatus = 'No Plan Generated';
                                if (status == 'No Plan Generated' ||
                                    status == 'Completed') {
                                  var snapshot = await FirebaseFirestore
                                      .instance
                                      .collection('diet-plan')
                                      .where('type', isEqualTo: currentDisease)
                                      .get();
                                  if (snapshot.docs.isEmpty) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    ScaffoldMessenger.of(context)
                                      ..removeCurrentSnackBar()
                                      ..showSnackBar(
                                        const SnackBar(
                                          duration: Duration(seconds: 1),
                                          content: Text(
                                            'You didn\'t specified any disease!',
                                            style: TextStyle(
                                              color: Colors.orange,
                                            ),
                                          ),
                                        ),
                                      );
                                    return;
                                  }
                                  newstatus = 'In Progress';
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(uid)
                                      .update({
                                    'status': newstatus,
                                    'dietplanId': snapshot
                                        .docs[Random()
                                            .nextInt(snapshot.docs.length)]
                                        .id,
                                  });
                                } else if (status == 'In Progress') {
                                  newstatus = 'Completed';
                                  setState(() {
                                    status = newstatus;
                                  });
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(uid)
                                      .update(
                                    {'status': newstatus, 'dietplanId': ''},
                                  );
                                }

                                await getDietPlan();
                                setState(() {
                                  _isLoading = false;
                                });
                              },
                        child: Center(
                          child: Text(
                            status == 'No Plan Generated' ||
                                    status == 'Completed'
                                ? "Generate Meal Plan"
                                : "Mark as Completed",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hey $username',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Choose the disease you have...',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            // Container(
            //   margin: const EdgeInsets.all(15.0),
            //   padding: const EdgeInsets.all(8.0),
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     border: Border.all(color: Colors.orange),
            //     color: Colors.white,
            //     boxShadow: const [
            //       BoxShadow(
            //         color: Colors.grey,
            //         offset: Offset(2, 2),
            //         blurRadius: 2,
            //       )
            //     ],
            //   ),
            //   child: DropdownButtonHideUnderline(
            //     child: DropdownButton(
            //       value: disease,
            //       style: const TextStyle(color: Colors.orange),
            //       menuMaxHeight: 150,
            //       items: diseaseItem,
            //       elevation: 2,
            //       borderRadius: BorderRadius.circular(10),
            //       onChanged: (String? value) {
            //         Navigator.of(context)
            //             .push(
            //               MaterialPageRoute(
            //                 builder: (context) => DiseaseForm(
            //                   diseaseName: value!,
            //                 ),
            //               ),
            //             )
            //             .then(
            //               (value) => setState(() => _selectedIndex = 0),
            //             );
            //       },
            //     ),
            //   ),
            // ),

            button(0),
            button(1),
            button(2),
            button(3),
            button(4),
          ],
        )
      ];
  button(int i) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (context) => DiseaseForm(
                  diseaseName: buttonNames[i],
                ),
              ),
            )
            .then(
              (value) => setState(() => _selectedIndex = 0),
            );
      },
      child: Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.orange,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: const Offset(2, 2),
              blurRadius: 2,
            )
          ],
        ),
        height: 65,
        alignment: Alignment.center,
        child: Text(
          buttonNames[i],
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Plans',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Disease',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      floatingActionButton: floatingButton(context),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const InformationEditScreen(),
              ),
            );
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
      body: body()[_selectedIndex],
    ));
  }

  FloatingActionButton floatingButton(BuildContext context) {
    return FloatingActionButton(
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
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}
