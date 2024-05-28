// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_reg/function/function.dart';
import 'package:student_reg/model/model.dart';
import 'package:student_reg/screens/add_student.dart';
import 'package:student_reg/screens/edit.dart';
import 'package:student_reg/screens/login_screen.dart';
import 'package:student_reg/screens/details_screen.dart';

class ListStudent extends StatefulWidget {
  const ListStudent({super.key});

  @override
  State<ListStudent> createState() => _ListStudentWidgetState();
}

class _ListStudentWidgetState extends State<ListStudent> {
  String _search = '';
  List<StudentModel> searchedlist = [];
  List<StudentModel> studentList = [];

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:  Center(
            child: Text('STUDENT LIST   ',
                style: TextStyle(color: Colors.white)),
          ),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(0))),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false);
              },
              icon: Icon(
                Icons.exit_to_app_rounded,
                color: Colors.white,
              )),
        ),
        body: Container(
          color: Colors.yellow[200],
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(75),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _search = value;
                    });
                    searchResult();
                  },
                ),
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: studentListNotifier,
                  builder: (BuildContext ctx, List<StudentModel> studentList,
                      Widget? child) {
                    final displayedStudents =
                        searchedlist.isNotEmpty ? searchedlist : studentList;
                    return ListView.separated(
                      itemBuilder: (ctx, index) {
                        final data = displayedStudents[index];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                          child: Card(
                            color: const Color.fromARGB(0, 72, 71, 71),
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ViewStudentScreen(
                                      name: data.name,
                                      age: data.age,
                                      phone: data.edu,
                                      place: data.address,
                                      imagePath: data.image ?? "",
                                    ),
                                  ),
                                );
                              },
                              textColor: Colors.black,
                              title: Text(data.name),
                              subtitle: Text(data.age),
                              leading: CircleAvatar(
                                  backgroundImage: data.image != null
                                      ? FileImage(File(data.image!))
                                      : const AssetImage("") as ImageProvider),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => EditStudent(
                                              index: index,
                                              name: data.name,
                                              age: data.age,
                                              edu: data.edu,
                                              address: data.address,
                                              imagePath: data.image),
                                        ));
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        deleteStudent(index);
                                      },
                                      icon: const Icon(Icons.delete,
                                          color:
                                              Color.fromARGB(255, 255, 17, 0))),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (ctx, index) {
                        return const Divider();
                      },
                      itemCount: displayedStudents.length,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 30,
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddStudentWidget()));
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getAllStudents();

    loadstudent();
  }

  loadstudent() async {
    final allstudents = await getAllStudents();
    studentListNotifier.value = allstudents;
  }

  void searchResult() {
    setState(() {
      searchedlist = studentListNotifier.value
          .where((StudentModel) =>
              StudentModel.name.toLowerCase().contains(_search.toLowerCase()))
          .toList();
    });
  }
}
