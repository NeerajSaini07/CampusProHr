import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:flutter/material.dart';

noRecordFound() {
  return Center(
      child: Text(
    NO_RECORD_FOUND,
    style: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
    ),
  ));
}

errorWidget() {
  return Center(child: Text(SOMETHING_WENT_WRONG));
}
