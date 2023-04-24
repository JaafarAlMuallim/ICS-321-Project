// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {super.key,
      required this.containerContent,
      required this.onPress,
      required this.height});
  final Widget? containerContent;
  final VoidCallback? onPress;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade600,
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.5),
              offset: const Offset(0, 3),
              blurRadius: 7,
              spreadRadius: 5,
            ),
          ],
        ),
        constraints: BoxConstraints(maxWidth: 400, maxHeight: height ?? 430),
        margin: const EdgeInsets.all(10),
        child: containerContent,
      ),
      onTap: onPress,
    );
  }
}
