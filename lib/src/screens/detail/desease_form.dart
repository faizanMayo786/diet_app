// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widget/text_form_field.dart';

class DiseaseForm extends StatefulWidget {
  const DiseaseForm({Key? key, required this.diseaseName}) : super(key: key);
  final String diseaseName;
  @override
  State<DiseaseForm> createState() => _DiseaseFormState();
}

class _DiseaseFormState extends State<DiseaseForm> {
  TextEditingController diseaseController = TextEditingController();
  TextEditingController occuranceController = TextEditingController();
  TextEditingController symptomsController = TextEditingController();
  TextEditingController prohibitedFoodController = TextEditingController();
  @override
  initState() {
    super.initState();
    firebaseFetch();
  }

  firebaseFetch() async {
    try {
      diseaseController.text = widget.diseaseName;
      String uid = FirebaseAuth.instance.currentUser!.uid;
      var snapshot = await FirebaseFirestore.instance
          .collection('health')
          .doc(uid)
          .collection(widget.diseaseName)
          .doc(uid)
          .get();
      if (snapshot.data() != null) {
        occuranceController.text = snapshot.data()!['occurance'];
        symptomsController.text = snapshot.data()!['prohibitedFood'];
        prohibitedFoodController.text = snapshot.data()!['symptoms'];
      }
    } on Exception catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.diseaseName),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  right: 8.0,
                  left: 8,
                  top: 15,
                  bottom: 2,
                ),
                child: Text(
                  'What disease do you have?',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              MyTextFormField(
                hintText: 'What disease do you have?',
                onSaved: () {},
                controller: diseaseController,
                readOnly: true,
              ),
              const Padding(
                padding: EdgeInsets.only(
                  right: 8.0,
                  left: 8,
                  top: 15,
                  bottom: 2,
                ),
                child: Text(
                  'How much time do you have this disease?',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              MyTextFormField(
                hintText: 'How much time do you have this disease?',
                controller: occuranceController,
                onSaved: () {},
              ),
              const Padding(
                padding: EdgeInsets.only(
                  right: 8.0,
                  left: 8,
                  top: 15,
                  bottom: 2,
                ),
                child: Text(
                  'What are the symptoms of this disease?',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              MyTextFormField(
                hintText: 'What are the symptoms of this disease?',
                controller: symptomsController,
                onSaved: () {},
              ),
              const Padding(
                padding: EdgeInsets.only(
                  right: 8.0,
                  left: 8,
                  top: 15,
                  bottom: 2,
                ),
                child: Text(
                  'What food is prohibited?',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              MyTextFormField(
                hintText: 'What food is prohibited?',
                controller: prohibitedFoodController,
                onSaved: () {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          String uid =
                              FirebaseAuth.instance.currentUser!.uid.toString();
                          await FirebaseFirestore.instance
                              .collection('health')
                              .doc(uid)
                              .collection(widget.diseaseName)
                              .doc(uid)
                              .set({
                            'occurance': occuranceController.text,
                            'prohibitedFood': prohibitedFoodController.text,
                            'symptoms': symptomsController.text,
                          });
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(uid)
                              .update({
                            'disease': widget.diseaseName,
                          });
                          Navigator.pop(context);
                        } on FirebaseException catch (e) {
                          print(e.message.toString());
                        }
                      },
                      child: const Text('Submit')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
