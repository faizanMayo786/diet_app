// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import '../../model/item.dart';
import '../../model/user.dart';
import '../../widget/item_card.dart';
import '../../widget/text_form_field.dart';

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
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Find the Best\nHealth for You',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: demoItems.length,
              // physics: sc(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ItemCard(item: demoItems[index], index: index);
              },
            ),
          ),
        ],
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
                onSaved: () {},            ),
            ],
          ),
        ),
      ),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
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
        appBar: AppBar(
          centerTitle: true,
          title: Text(label[_selectedIndex]),
          backgroundColor: const Color.fromARGB(255, 52, 52, 52),
          elevation: 0,
        ),
        body: body[_selectedIndex]));
  }
}
