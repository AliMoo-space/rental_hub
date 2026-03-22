import 'package:flutter/material.dart';

void showMsg(String? msg, BuildContext context, {bool isError = false}) {
  if (msg != null && msg.isNotEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 3),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }
}
