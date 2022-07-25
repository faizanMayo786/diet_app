import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF4F4F4F);
const kBackgroundColor = Color(0xFF333333);
const kRedColor = Color(0xFFEB5757);

const kDefaultPadding = 20.0;

snackBar(BuildContext context, String message) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.orange,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: context.size!.width * 0.7,
              child: Text(
                message.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );



List<DropdownMenuItem<String>> ageItems = [
  const DropdownMenuItem<String>(
    value: 'Age',
    child: Text(
      'Age',
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    ),
  )
];

List<DropdownMenuItem<String>> weightItems = [
  const DropdownMenuItem<String>(
    value: 'Weight',
    child: Text(
      'Weight',
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    ),
  )
];

List<DropdownMenuItem<String>> heightItems = [
  const DropdownMenuItem<String>(
    value: 'Height',
    child: Text(
      'Height',
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    ),
  )
];

List<DropdownMenuItem<String>> genderItems = [
  const DropdownMenuItem<String>(
    value: 'Gender',
    child: Text(
      'Gender',
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    ),
  ),
  const DropdownMenuItem<String>(
    value: 'Single',
    child: Text(
      'Male',
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    ),
  ),
  const DropdownMenuItem<String>(
    value: 'Female',
    child: Text(
      'Female',
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    ),
  ),
];
