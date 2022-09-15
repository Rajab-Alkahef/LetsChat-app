import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message, Color colors) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: colors,
      content: Text(message),
    ),
  );
}
