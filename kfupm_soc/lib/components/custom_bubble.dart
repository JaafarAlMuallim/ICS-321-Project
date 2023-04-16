import 'package:flutter/material.dart';
// import 'package:kfupm_soc/constants.dart';

class CustomBubble extends StatelessWidget {
  const CustomBubble({
    super.key,
    required this.containerContent,
    required this.onPress,
  });
  final Widget? containerContent;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 130.0,
        height: 50.0,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.purple.shade400,
        ),
        child: containerContent,
      ),
    );
  }
}
