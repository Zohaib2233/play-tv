import 'package:flutter/material.dart';

dynamic showSnackNotification(String message,
    {bool isError = true, required BuildContext context}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: isError ? Colors.red : Colors.green,
  ));
}
