// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';

class ViewStudentScreen extends StatelessWidget {
  final String name;
  final String age;
  final String place;
  final String phone;
  final String imagePath;

  const ViewStudentScreen({
    Key? key,
    required this.name,
    required this.age,
    required this.place,
    required this.phone,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: FileImage(File(imagePath)),
            ),
            SizedBox(height: 30),
            CardItem('Name', name),
            CardItem('Age', age),
            CardItem('Education', place),
            CardItem('Address', phone),
          ],
        ),
      ),
    );
  }

  Widget CardItem(String title, String content) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
