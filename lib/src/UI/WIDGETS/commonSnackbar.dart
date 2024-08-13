import 'package:flutter/material.dart';

SnackBar commonSnackBar({Duration? duration, @required String? title}) {
  return SnackBar(
    content: Text(
      '$title',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
    duration: duration ?? Duration(seconds: 2),
    backgroundColor: Colors.black,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );
}
