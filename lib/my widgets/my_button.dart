// ignore_for_file: camel_case_types, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';

class my_button extends StatelessWidget {
  String text;
  Color? color;
  VoidCallback ontap;
  my_button({super.key, required this.text, required this.color,required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          alignment: Alignment.center,
          height: 40,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
           color: color,
           borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
