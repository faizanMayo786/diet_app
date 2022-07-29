// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_suggestion_app/src/screens/admin_pannel/upload_plan.dart';

import '/src/screens/message/inbox_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  List<String> label = ['Upload Diet Plan', 'Queries'];
  List body(BuildContext context) {
    return [
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            button('Upload Diet Plan'),
            Text(
              'Current Plans',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width > 600 ? 500 : 500,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('diet-plan')
                      .orderBy(
                        'type',
                      )
                      .snapshots(),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot,
                  ) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isNotEmpty) {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data!.docs[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 12, top: 12, bottom: 12),
                                child: Container(
                                  width: MediaQuery.of(context).size.width > 600
                                      ? 400
                                      : 400,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          // offset: Offset(2, 2),
                                          blurRadius: 5,
                                          spreadRadius: 2),
                                    ],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0,
                                        right: 12,
                                        top: 12,
                                        bottom: 12),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Diet Plan for Patients with ${data['type']} ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(
                                                width: 60,
                                                child: Text(
                                                  'Pre-Breakfast',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                            const VerticalDivider(),
                                            SizedBox(
                                              width: 350,
                                              child: Text(data['prebreakfast']),
                                            )
                                          ],
                                        ),
                                        const Divider(),
                                        Row(
                                          children: [
                                            const SizedBox(
                                                width: 60,
                                                child: Text(
                                                  'Breakfast',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                            const VerticalDivider(),
                                            SizedBox(
                                              width: 350,
                                              child: Text(data['breakfast']),
                                            )
                                          ],
                                        ),
                                        const Divider(),
                                        Row(
                                          children: [
                                            const SizedBox(
                                                width: 60,
                                                child: Text(
                                                  'Snacks',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                            const VerticalDivider(),
                                            SizedBox(
                                              width: 350,
                                              child: Text(data['snacks']),
                                            )
                                          ],
                                        ),
                                        const Divider(),
                                        Row(
                                          children: [
                                            const SizedBox(
                                                width: 60,
                                                child: Text(
                                                  'Lunch',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                            const VerticalDivider(),
                                            SizedBox(
                                                width: 350,
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
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const VerticalDivider(),
                                            SizedBox(
                                              width: 350,
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
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const VerticalDivider(),
                                            SizedBox(
                                                width: 350,
                                                child: Text(data['bedtime']))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Center(child: Text('No Diet Plan Upladed'));
                      }
                    }
                    return Center(child: Text('Something Went Wrong!'));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      const InboxScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Queries',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      appBar: AppBar(
        title: Text(label[_selectedIndex]),
        leading: const SizedBox(),
        centerTitle: true,
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
                          HapticFeedback.lightImpact();

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
              ))
        ],
      ),
      body: body(context)[_selectedIndex],
    );
  }

  button(String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UploadPlanScreen()));
      },
      child: Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width > 600 ? 400 : 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.orange,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              // offset: Offset(2, 2),
              blurRadius: 5,
              spreadRadius: 2,
            )
          ],
        ),
        height: 65,
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
