import 'package:flutter/material.dart';
// import 'package:kfupm_soc/constants.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
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
        constraints: const BoxConstraints(maxHeight: 750, maxWidth: 400),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.purple.shade400,
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: containerContent,
      ),
    );
  }
}
