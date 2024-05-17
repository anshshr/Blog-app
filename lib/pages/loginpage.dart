// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables,non_constant_identifier_names, avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_signup_authentication/pages/dashboard_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../my widgets/my_button.dart';
import '../my widgets/my_textfield.dart';
import 'registerpage.dart';

class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool islogin = false;

  Future<void> login() async {
    var login_user = {
      'email': email.text,
      'passowrd': password.text,
    };
    var response = await http.post(
      Uri.parse('http://192.168.162.230:3000/api/signin'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(login_user),
    );

    if (response.statusCode == 200) {
      var json_response = jsonDecode(response.body);
      var my_token = json_response['token'];

      if (my_token != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Dashboard(token: my_token),
            ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Text(
              'Login Here',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            my_textfield(
                controller: email,
                display_text: "Enter your email here",
                obs_text: false,
                icon: Icon(Icons.person)),
            const SizedBox(
              height: 15,
            ),
            my_textfield(
                controller: password,
                display_text: "Enter your password",
                obs_text: true,
                icon: Icon(Icons.password)),
            SizedBox(
              height: 20,
            ),
            my_button(
                text: 'L O G I N',
                color: Colors.purple[300],
                ontap: () async {
                  await login();
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Don't have an account , ",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => register_page(),
                        ));
                  },
                  child: Text(
                    'register here',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.red[300]),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
