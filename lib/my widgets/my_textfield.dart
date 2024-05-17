// ignore_for_file: camel_case_types, must_be_immutable, non_constant_identifier_names, prefer_const_constructors, unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class my_textfield extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  final String display_text;
  final bool obs_text;
  Icon icon;
  my_textfield(
      {super.key,
      required this.controller,
      required this.display_text,
      required this.obs_text,
      required this.icon,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        autocorrect: true,
        minLines: 1,
        maxLines: 200,
        enableSuggestions: true,
        controller: controller,
        obscureText: obs_text,
        decoration: InputDecoration(
            hintText: display_text,
            labelText: display_text,
            prefixIcon: icon,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide:
                    BorderSide(style: BorderStyle.solid, color: Colors.grey))),
      ),
    );
  }
}
