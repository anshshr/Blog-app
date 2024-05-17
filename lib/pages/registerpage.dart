// ignore_for_file: camel_case_types, prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_signup_authentication/my%20widgets/my_textfield.dart';
import 'package:login_signup_authentication/pages/loginpage.dart';
import '../my widgets/my_button.dart';
import 'package:http/http.dart' as http;

class register_page extends StatefulWidget {
  const register_page({super.key});

  @override
  State<register_page> createState() => _register_pageState();
}

class _register_pageState extends State<register_page> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void register() async {
    var register_user = {
      'name': name.text,
      'email': email.text,
      'password': password.text
    };

    var response =
        await http.post(Uri.parse("http://192.168.162.230:3000/api/signup"),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(register_user));
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.network(
                'https://cdn-icons-png.flaticon.com/512/3456/3456426.png',
                height: 200,
                width: MediaQuery.of(context).size.width * 0.8,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Welcome Buddy !!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 30,
              ),
              my_textfield(
                  controller: name,
                  display_text: "Enter your name here",
                  obs_text: false,
                  icon: Icon(Icons.person)),
              SizedBox(
                height: 10,
              ),
              my_textfield(
                  controller: email,
                  display_text: "Enter your email",
                  obs_text: false,
                  icon: Icon(Icons.email)),
              SizedBox(
                height: 10,
              ),
              my_textfield(
                  controller: password,
                  display_text: "Enter your password",
                  obs_text: true,
                  icon: Icon(Icons.password)),
              SizedBox(
                height: 10,
              ),
              my_button(
                text: 'R E G I S T E R',
                color: Colors.deepPurple[300],
                ontap: () {
                  register();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'already had an account , ',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => login_page(),
                          ));
                    },
                    child: Text(
                      'login',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.red),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
