// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_typing_uninitialized_variables, constant_identifier_names, unused_local_variable, non_constant_identifier_names, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:login_signup_authentication/pages/dashboard_page.dart';
import 'package:login_signup_authentication/pages/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? user_token = prefs.getString("token");
  
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'shared preferences',
    home: user_token != "" ? Dashboard(token: prefs.getString("token")!) : login_page(),
  ));
}

