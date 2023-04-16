import 'package:flutter/material.dart';

import '../constants/styles.dart';

class IconBottomBar extends StatelessWidget {
  const IconBottomBar({
    super.key,
    required this.icon,
    required this.selected,
    required this.onPressed,
  });
  final IconData icon;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 40,
            color: selected ? Style.kActivated : Style.kInActivated,
          ),
        ),
      ],
    );
  }
}
