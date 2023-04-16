// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.containerContent,
    required this.onPress,
  });
  final Widget? containerContent;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.purple.shade400,
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.3),
              offset: const Offset(0, 3),
              blurRadius: 7,
              spreadRadius: 5,
            ),
          ],
        ),
        width: 300,
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 300),
        margin: const EdgeInsets.all(10),
        child: containerContent,
      ),
      onTap: onPress,
    );
  }
}
