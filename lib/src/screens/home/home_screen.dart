// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import '../../model/item.dart';
import '../../model/user.dart';
import '../../widget/item_card.dart';
class HomeScreen extends StatelessWidget {
  HomeScreen();

  @override
  Widget build(BuildContext context) {
    return (Scaffold(

      backgroundColor: const Color.fromARGB(255, 52, 52, 52),
      appBar: AppBar(
        title: const Text('Diet Plans'),
        backgroundColor: const Color.fromARGB(255, 52, 52, 52),
        elevation: 0,
      ),
      body: Container(
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
    ));
  }
}
