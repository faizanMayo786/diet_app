// ignore_for_file: unnecessary_cast

import 'package:flutter/material.dart';

import '../model/user_provider.dart';

// ignore: must_be_immutable
class FormDropDownButton extends StatefulWidget {
  FormDropDownButton({
    Key? key,
    required this.items,
    required this.label,
    required this.width,
    required this.valueController,
    required this.suffix,
  }) : super(key: key);
  final String label;
  String valueController;
  final List<DropdownMenuItem<String>> items;
  final double width;
  final String suffix;
  @override
  State<FormDropDownButton> createState() => _FormDropDownButtonState();
}

class _FormDropDownButtonState extends State<FormDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: DropdownButtonFormField<String>(
        // controller: controller,
        value: widget.valueController.toString(),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          fillColor: Colors.grey.shade100,
          filled: true,
          enabledBorder: InputBorder.none,
          hintStyle: Theme.of(context).textTheme.labelMedium,
          border: const OutlineInputBorder(),
          suffix: Text(
            widget.suffix,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),
          ),
        ),

        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Theme.of(context).colorScheme.primary,
        ),
        elevation: 16,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
        validator: (value) {
          if (widget.valueController.toString() == 'Weight') {
            return 'Choose Weight';
          }
          if (widget.valueController.toString() == 'Height') {
            return 'Choose Height';
          }
          if (widget.valueController.toString() == 'Age') return 'Choose Age';
          if (widget.valueController.toString() == 'Gender') {
            return 'Choose Gender';
          }
          return null;
        },
        menuMaxHeight: 200.0,
        onChanged: (dynamic newValue) {
          setState(
            () {
              setState(() {});
              widget.valueController = newValue;

              if (widget.label == 'Weight') model.weight = newValue;
              if (widget.label == 'Height') model.height = newValue;
              if (widget.label == 'Age') {
                model.age = newValue;
              }
              if (widget.label == 'Gender') model.gender = newValue;
            },
          );
        },
        items: widget.items as List<DropdownMenuItem<String>>,
      ),
    );
  }
}
