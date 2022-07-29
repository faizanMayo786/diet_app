// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';

class UploadPlanScreen extends StatefulWidget {
  const UploadPlanScreen({Key? key}) : super(key: key);

  @override
  State<UploadPlanScreen> createState() => _UploadPlanScreenState();
}

class _UploadPlanScreenState extends State<UploadPlanScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController preBreakFastController = TextEditingController();
  TextEditingController breakFastController = TextEditingController();
  TextEditingController snackController = TextEditingController();
  TextEditingController lunchController = TextEditingController();
  TextEditingController dinnerController = TextEditingController();
  TextEditingController bedTimeController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  bool _loading = false;
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();

    firebaseData();
  }

  firebaseData() async {
    typeController.text = 'Diabetes I';
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Plan'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'assets/images/${Random().nextInt(4) + 1}.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                DietTextField(
                  label: 'Pre-BreakFast',
                  maxLine: 3,
                  controller: preBreakFastController,
                ),
                DietTextField(
                  label: 'BreakFast',
                  maxLine: 3,
                  controller: breakFastController,
                ),
                DietTextField(
                  label: 'Snacks',
                  maxLine: 3,
                  controller: snackController,
                ),
                DietTextField(
                  label: 'Lunch',
                  maxLine: 3,
                  controller: lunchController,
                ),
                DietTextField(
                  label: 'Dinner',
                  maxLine: 3,
                  controller: dinnerController,
                ),
                DietTextField(
                  label: 'Bed Time',
                  maxLine: 3,
                  controller: bedTimeController,
                ),
                Container(
                  margin: const EdgeInsets.all(12.0),
                  padding: const EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width > 600 ? 400 : 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                    color: Colors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: typeController.text,
                      style: const TextStyle(color: Colors.black),
                      menuMaxHeight: 150,
                      items: diseaseItem,
                      elevation: 2,
                      borderRadius: BorderRadius.circular(10),
                      onChanged: (String? value) {
                        setState(() => typeController.text = value!);
                      },
                    ),
                  ),
                ),
                _loading
                    ? const SizedBox(
                        height: 50,
                        width: 50,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : button('Upload')
              ],
            ),
          ),
        ),
      ),
    );
  }

  button(String title) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          _loading = true;
        });
        if (typeController.text.trim() != '' &&
            breakFastController.text.trim() != '' &&
            preBreakFastController.text.trim() != '' &&
            snackController.text.trim() != '' &&
            lunchController.text.trim() != '' &&
            bedTimeController.text.trim() != '' &&
            dinnerController.text.trim() != '') {
          try {
            await FirebaseFirestore.instance.collection('diet-plan').add({
              'prebreakfast': preBreakFastController.text.trim(),
              'breakfast': breakFastController.text.trim(),
              'snacks': snackController.text.trim(),
              'lunch': lunchController.text.trim(),
              'dinner': dinnerController.text.trim(),
              'bedtime': bedTimeController.text.trim(),
              'type': typeController.text.trim(),
            });
            Navigator.pop(context);
            setState(() {
              _loading = false;
            });
          } catch (e) {
            setState(() {
              _loading = false;
            });
          }
        }
        setState(() {
          _loading = false;
        });
      },
      child: Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width > 600 ? 400 : 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.orange,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(2, 2),
              blurRadius: 2,
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

class DietTextField extends StatelessWidget {
  const DietTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.maxLine,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final int maxLine;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width > 600 ? 400 : 400,
        child: TextField(
          decoration: InputDecoration(
            label: Text(label),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          controller: controller,
          maxLines: maxLine,
        ),
      ),
    );
  }
}
