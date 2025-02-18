import 'package:flutter/material.dart';
import '../style/colors.dart';
import '../style/custom_text.dart';

void showSnack(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: black,
      elevation: 10,
      content: Center(
        child: CustomText(
          text: text,
          color: white,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 3),
    ),
  );
}
