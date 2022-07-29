// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_suggestion_app/src/screens/admin_pannel/upload_plan.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../core/util/logo_widget.dart';
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

  mood(double value) {
    if (value == 0.0) {
      return const Icon(
        Icons.sentiment_very_dissatisfied,
        color: Colors.red,
      );
    }
    if (value == 0.25) {
      return Icon(
        Icons.sentiment_dissatisfied,
        color: Colors.red.shade300,
      );
    }
    if (value == 0.5) {
      return const Icon(
        Icons.sentiment_neutral,
        color: Colors.grey,
      );
    }
    if (value == 0.75) {
      return Icon(
        Icons.sentiment_satisfied_outlined,
        color: Colors.green.shade200,
      );
    }
    if (value == 1) {
      return const Icon(
        Icons.mood,
        color: Colors.green,
      );
    }
  }

  List<String> label = ['Users Progess', 'Upload Diet Plan', 'Queries'];
  List body(BuildContext context) {
    return [
      Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Users Progress Details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width > 600 ? 400 : 400,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var object = snapshot.data!.docs[index];
                          return object['progress'] != null
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width > 600
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
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      'Name:   ${object['username']}'),
                                                  Text(
                                                      'Gender:   ${object['gender']}'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    'Progress',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child:
                                                          LinearPercentIndicator(
                                                        animation: true,
                                                        trailing: mood(
                                                            object['progress']),
                                                        lineHeight: 20.0,
                                                        animationDuration: 500,
                                                        percent:
                                                            object['progress'],
                                                        center: Text(
                                                          "${snapshot.data!.docs[index]['progress'] * 100} %",
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        barRadius: const Radius
                                                            .circular(15),
                                                        progressColor:
                                                            Colors.orange,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      'Age:   ${object['age']}'),
                                                  Text(
                                                      'Weight:   ${object['weight']}'),
                                                  Text(
                                                      'Height:   ${object['height']}'),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container();
                        },
                      );
                    } else if (snapshot.hasError) {
                      return const Text('Something Went Wrong');
                    } else {
                      return const Text('No Progress of Users');
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            button('Upload Diet Plan'),
            const Text(
              'Current Plans',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Expanded(
              child: SizedBox(
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
                                            style: const TextStyle(
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
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width >
                                                      600
                                                  ? 350
                                                  : 250,
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
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width >
                                                      600
                                                  ? 350
                                                  : 250,
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
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width >
                                                      600
                                                  ? 350
                                                  : 250,
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
                                                width: MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                        600
                                                    ? 350
                                                    : 250,
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
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width >
                                                      600
                                                  ? 350
                                                  : 250,
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
                                                width: MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                        600
                                                    ? 350
                                                    : 250,
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
                        return const Center(
                            child: Text('No Diet Plan Upladed'));
                      }
                    }
                    return const Center(
                        child: Text('Something Went Wrong!'));
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          label[_selectedIndex],
          style: const TextStyle(color: Colors.black),
        ),
        leading: const Padding(
          padding: EdgeInsets.only(
            left: 10,
            bottom: 10,
            top: 10,
          ),
          child: Logo(
            width: 50,
            height: 50,
          ),
        ),
        actions: [
          SizedBox(
            width: 430,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        _onItemTapped(0);
                      },
                      child: Text(
                        'Users Progress',
                        style: TextStyle(
                          color: _selectedIndex == 0
                              ? Colors.orange
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        _onItemTapped(1);
                      },
                      child: Text(
                        'Upload Plan',
                        style: TextStyle(
                          color: _selectedIndex == 1
                              ? Colors.orange
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        _onItemTapped(2);
                      },
                      child: Text(
                        'User Queries',
                        style: TextStyle(
                          color: _selectedIndex == 2
                              ? Colors.orange
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
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
                          color: Colors.black,
                        )),
                  )
                ],
              ),
            ),
          ),
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
