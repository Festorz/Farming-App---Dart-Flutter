import 'package:flutter/material.dart';

class Appsnackbar {
  static void snackbar(context, String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
      elevation: 0,
    ));
  }
}
