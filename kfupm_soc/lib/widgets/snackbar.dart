import 'package:flutter/material.dart';
import 'package:kfupm_soc/constants/styles.dart';

class ShowSnackBar {
  static showSnackbar(
      BuildContext context, message, textAction, action, color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 5,
      duration: const Duration(seconds: 5),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.error_outline,
            size: 70,
            color: Colors.white,
          ),
          Text(
            message,
            style: Style.bottomSheetText
                .copyWith(color: Colors.white, fontSize: 15),
            maxLines: 4,
          ),
          TextButton(
              onPressed: action,
              child: Text(
                textAction,
                style: Style.bottomSheetText.copyWith(
                    fontSize: 15,
                    color: Colors.white,
                    decoration: TextDecoration.underline),
              ))
        ],
      ),
      padding: Style.padding,
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
    ));
  }
}
