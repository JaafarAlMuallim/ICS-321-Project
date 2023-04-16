import 'package:flutter/material.dart';
// import 'package:kfupm_soc/constants.dart';

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
      onTap: onPress,
      child: Container(
        constraints: const BoxConstraints(maxHeight: 300, maxWidth: 400),
        width: 300,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.purple.shade400,
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.3),
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
