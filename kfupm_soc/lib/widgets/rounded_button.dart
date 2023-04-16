// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Roundedbutton extends StatelessWidget {
  Roundedbutton({
    required this.color,
    required this.onPressed,
    required this.title,
    super.key,
  });
  Color color;
  String title;
  VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(30.0),
        ),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
