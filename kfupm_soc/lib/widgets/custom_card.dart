// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:kfupm_soc/constants/app_theme.dart';

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
        decoration: const BoxDecoration(
          color: CustomColors.enabled,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: CustomColors.secondaryColor,
              offset: Offset(0, 3),
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
