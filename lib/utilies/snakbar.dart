import 'package:flutter/material.dart';

class SnackbarUtils {
  static void showSnackbar(BuildContext context, String message, {required bool isSuccess}) {
    final color = isSuccess ? Colors.green : Colors.red;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
