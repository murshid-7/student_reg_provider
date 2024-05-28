// ignore_for_file: must_be_immutable, camel_case_types, use_key_in_widget_constructors, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:student_reg/function/function.dart';
import 'package:student_reg/model/model.dart';
import 'package:student_reg/screens/list_student.dart';

class EditStudent extends StatefulWidget {
  var name;
  var age;
  var edu;
  var address;
  int index;
  dynamic imagePath;

  EditStudent({
    required this.index,
    required this.name,
    required this.age,
    required this.edu,
    required this.address,
    required this.imagePath,
  });

  @override
  State<EditStudent> createState() => _edit_studentState();
}

class _edit_studentState extends State<EditStudent> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _eduController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _ageController = TextEditingController(text: widget.age);
    _eduController = TextEditingController(text: widget.edu);
    _addressController = TextEditingController(text: widget.address);
    _selectedImage = widget.imagePath != '' ? File(widget.imagePath) : null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 238, 239),
      appBar: AppBar(
        title: Text(
          "Edit",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                CircleAvatar(
                  radius: 80,
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : AssetImage("") as ImageProvider,
                ),
                ElevatedButton.icon(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () {
                      imagefromgalle();
                    },
                    icon: const Icon(Icons.image, color: Colors.white),
                    label: const Text(
                      "GALLERY",
                      style: TextStyle(color: Colors.white),
                    )),
                ElevatedButton.icon(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () {
                      imagefromgalle();
                    },
                    icon: const Icon(Icons.camera_alt, color: Colors.white),
                    label: const Text("CAMERA",
                        style: TextStyle(color: Colors.white))),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Name",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _ageController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Age',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _eduController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Education',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _addressController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Address',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          onPressed: () {
                            updateall();
                          },
                          icon: const Icon(
                            Icons.done,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Update",
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }

  Future<void> updateall() async {
    final name = _nameController.text;
    final age = _ageController.text;
    final edu = _eduController.text;
    final address = _addressController.text;
    final image = _selectedImage!.path;

    if (name.isEmpty ||
        age.isEmpty ||
        edu.isEmpty ||
        address.isEmpty ||
        image.isEmpty) {
      return;
    } else {
      final update = StudentModel(
          name: name, age: age, edu: edu, address: address, image: image);

      editstudent(widget.index, update);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const ListStudent()));
    }
  }
   Future imagefromgalle() async {
    final returnImage = await ImagePicker().pickImage(source:ImageSource.camera );

    if (returnImage == null) {
      return;
    }

    setState(() {
      _selectedImage = File(returnImage.path);
    });
  }

  Future imagefromcam() async {
    final returnImage = await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnImage == null) {
      return;
    }

    setState(() {
      _selectedImage = File(returnImage.path);
    });
  }
}
