import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../model/user.dart';
import '../../widget/drop_down_button.dart';

Model model = Model(
  weight: 'Weight',
  height: 'Height',
  age: 'Age',
  gender: 'Gender',
  disease: '',
  registerDate: '',
);

class InformationEditScreen extends StatefulWidget {
  const InformationEditScreen({Key? key}) : super(key: key);

  @override
  State<InformationEditScreen> createState() => _InformationEditScreenState();
}

class _InformationEditScreenState extends State<InformationEditScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    ageItems.addAll(
      List.generate(250, (index) => index.toString())
          .map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          );
        },
      ).toList(),
    );
    weightItems.addAll(
      List.generate(150, (index) => index.toString())
          .map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          );
        },
      ).toList(),
    );
    heightItems.addAll(
      List.generate(100, (index) => index.toString())
          .map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Column(
            children: [
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
              Container(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormDropDownButton(
                        label: model.weight,
                        items: weightItems,
                        valueController: model.weight,
                        width: MediaQuery.of(context).size.width * 0.45,
                        suffix: 'kg',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormDropDownButton(
                        label: model.height,
                        items: heightItems,
                        valueController: model.height,
                        width: MediaQuery.of(context).size.width * 0.45,
                        suffix: 'cm',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormDropDownButton(
                  label: model.age,
                  items: ageItems,
                  valueController: model.age,
                  width: MediaQuery.of(context).size.width,
                  suffix: '',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormDropDownButton(
                  label: model.gender,
                  items: genderItems,
                  valueController: model.gender,
                  width: MediaQuery.of(context).size.width,
                  suffix: '',
                ),
              ),
            ],
          )),
    );
  }
}
