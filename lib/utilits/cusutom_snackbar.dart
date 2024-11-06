import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(BuildContext context,
      {required String label,
        required Color bgColor,
        required SnackBarType snackBarType}) {
    final snackBar = SnackBar(
      content: Text(label),
      backgroundColor: bgColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

enum SnackBarType { success, fail }
