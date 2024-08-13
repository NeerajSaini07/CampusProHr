import 'package:flutter/material.dart';

class DrawerColorDummy {
  static MaterialColor? onSelected(BuildContext context, {String? menuId}) {
    switch (menuId) {
      //-----------------STUDENT DRAWER-----------------------------------------//
      case "1":
        return Colors.green;
      case "4":
        return Colors.green;
      case "3":
        return Colors.green;
      case "5":
        return Colors.grey;
      case "13":
        return Colors.green;
      case "7":
        return Colors.green;
      case "8":
        return Colors.green;
      case "30":
        return Colors.green;
      case "43":
        return Colors.green;
      case "48":
        return Colors.grey;
      case "27":
        return Colors.green;
      case "37":
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  static MaterialColor getSubMenu(BuildContext context, {String? subMenu}) {
    switch (subMenu) {
      case "1":
        return Colors.green;
      case "2":
        return Colors.green;
      case "3":
        return Colors.green;
      case "7":
        return Colors.green;
      case "5":
        return Colors.green;
      case "6":
        return Colors.grey;
      case "4":
        return Colors.green;
      case "53":
        return Colors.green;
      case "54":
        return Colors.green;
      case "11":
        return Colors.orange;
      case "10":
        return Colors.orange;
      case "14":
        return Colors.green;
      case "20":
        return Colors.green;
      case "52":
        return Colors.green;
      case "75":
        return Colors.green;
      case "16":
        return Colors.green;
      case "17":
        return Colors.green;
      case "26":
        return Colors.orange;
      case "70":
        return Colors.orange;
      case "28":
        return Colors.orange;
      case "29":
        return Colors.orange;
      case "30":
        return Colors.orange;
      case "21":
        return Colors.green;
      case "23":
        return Colors.orange;
      case "24":
        return Colors.orange;
      case "37":
        return Colors.orange;
      case "38":
        return Colors.orange;
      case "50":
        return Colors.orange;
      case "45":
        return Colors.orange;
      default:
        return Colors.red;
    }
  }
}
