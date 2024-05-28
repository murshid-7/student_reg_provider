// ignore_for_file: file_names, prefer_const_constructors, avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_reg/main.dart';
import 'package:student_reg/screens/list_student.dart';
import 'package:student_reg/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> gotologin() async {
    await Future.delayed(Duration(seconds: 6), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  void initState() {
    checkUserLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              'assets/Animation - 1707826298159.json',
              fit: BoxFit.cover,
            ),
          ),
          Text(
            'loading please wait..',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  checkUserLogin() async {
    final sharedpref = await SharedPreferences.getInstance();
    final userLogin = sharedpref.getBool(login_key);
    if (userLogin == null || userLogin == false) {
      gotologin();
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ListStudent()));
    }
  }
}
