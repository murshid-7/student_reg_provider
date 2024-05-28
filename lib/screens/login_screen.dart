// import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_reg/main.dart';
import 'package:student_reg/screens/list_student.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(17.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Title(
                    color: Colors.black,
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'username',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'username is empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'password is empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Color.fromARGB(255, 48, 116, 189),
                            ),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              checkLogin(context);
                            } else {
                              print('data empty');
                            }
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void checkLogin(BuildContext context) async {
    final userName = usernameController.text;
    final passWord = passwordController.text;

    if (userName == passWord) {
      final _sharedpref = await SharedPreferences.getInstance();
      await _sharedpref.setBool(login_key, true);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ListStudent()),
      );
    } else {
      final error1 = 'username and password doesn\'t match';

      showDialog(
        context: context,
        builder: (context1) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(error1),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context1).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }
}
