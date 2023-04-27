// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

class CustomBubble extends StatelessWidget {
  const CustomBubble(
      {super.key,
      required this.containerContent,
      required this.onPress,
      required this.color});
  final Widget? containerContent;
  final VoidCallback? onPress;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
        ),
        width: 130.0,
        height: 50.0,
        margin: const EdgeInsets.all(10),
        child: containerContent,
      ),
      onTap: onPress,
    );
  }
}
