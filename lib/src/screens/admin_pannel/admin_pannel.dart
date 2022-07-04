// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:io';

import 'package:diet_suggestion_app/src/model/item.dart';
import 'package:diet_suggestion_app/src/screens/home/home_screen.dart';
import 'package:diet_suggestion_app/src/widget/detail_vitamin.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  File? imageFile;
  Color color = Colors.orange;

  final _formKey = GlobalKey<FormState>();
  Item model = Item(
      id: 0,
      name: '',
      description: '',
      image: '',
      rating: 0.0,
      ratingCount: 0,
      price: 0.0,
      color: 0,
      vitamins: [],
      ingrediants: []);

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  List<String> label = ['Add Diet Item', 'Queries'];
  List body(BuildContext context) {
    return [
      Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  //
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 200.0,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _getFromGallery();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                      ),
                                      child: const Text(
                                        "Gallery",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200.0,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _getFromCamera();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                      ),
                                      child: const Text(
                                        "Camera",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: imageFile == null
                                ? Image.asset(
                                    'assets/images/user.png',
                                    fit: BoxFit.cover,
                                  )
                                : SizedBox(
                                    child: Image.file(
                                      imageFile!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                        Positioned(
                          right: 0.0,
                          bottom: 0.0,
                          child: Icon(
                            Icons.camera,
                            color: Colors.orange,
                            size: 30.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                MyTextFormField(
                  hintText: 'Name',
                ),

                MyTextFormField(
                  hintText: 'Rating',
                ),
                MyTextFormField(
                  hintText: 'Price',
                ),
               MyTextFormField(
                  hintText: 'Description', //
                  line: 3,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onTap: () {
                      openFilterDialog();
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: selectedList.toString(),
                      contentPadding: const EdgeInsets.all(15.0),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        hintText: "Ingredients",
                        contentPadding: const EdgeInsets.all(15.0),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      value: "1",
                      items: [
                        DropdownMenuItem(
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/icons/ingredient1.svg"),
                              SizedBox(width: 20.0),
                              Text("Apple"),
                            ],
                          ),
                          value: "1",
                        ),
                        DropdownMenuItem(
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/icons/ingredient2.svg"),
                              SizedBox(width: 20.0),
                              const Text("Avocado"),
                            ],
                          ),
                          value: "2",
                        ),
                        DropdownMenuItem(
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/icons/ingredient3.svg"),
                              SizedBox(width: 20.0),
                              Text("Orange"),
                            ],
                          ),
                          value: "3",
                        ),
                        DropdownMenuItem(
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/icons/ingredient4.svg"),
                              SizedBox(width: 20.0),
                              Text("Strawberry"),
                            ],
                          ),
                          value: "4",
                        ),
                      ],
                      onChanged: (value) {
                        print(value);
                      }),
                ),
                RaisedButton(
                  color: Colors.blueAccent,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => HomeScreen()),
                          ),
                          (route) => false);
                    }
                  },
                  child: const SizedBox(
                    height: 50.0,
                    width: 90.0,
                    child: Center(
                      child: Text(
                        'Add Form',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(
        child: Center(
          child: Text('Query'),
        ),
      ),
    ];
  }

  int tag = 1;
  List<String> options = ['A', 'B', 'C', 'D', 'E'];
  List<String> selectedList = [];
  void openFilterDialog() async {
    await FilterListDialog.display<String>(
      context,
      listData: options,
      selectedListData: selectedList,
      choiceChipLabel: (opt) => opt,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (opt, query) {
        return opt.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedList = List.from(list!);
        });
        Navigator.pop(context);
      }, 
    );
  }

  Future<Color> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor!.color;
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(
        () {
          imageFile = File(pickedFile.path);
        },
      );
      color = await getImagePalette(FileImage(imageFile!));
      setState(() {});
    }
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(
        () {
          imageFile = File(pickedFile.path);
        },
      );
      color = await getImagePalette(FileImage(imageFile!));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 52, 52, 52),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Query',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      backgroundColor: const Color.fromARGB(255, 52, 52, 52),
      appBar: AppBar(
        title: Text(label[_selectedIndex]),
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 52, 52, 52),
      ),
      body: body(context)[_selectedIndex],
    );
  }
}

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final bool isEmail;
  final int line;
  MyTextFormField({
    required this.hintText,
    this.isPassword = false,
    this.isEmail = false,
    this.line = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLines: line,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        obscureText: isPassword ? true : false,
        keyboardType: line > 1 ? TextInputType.multiline : TextInputType.text,
      ),
    );
  }
}
