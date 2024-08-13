import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:flutter/material.dart';

final Color accentColor = Color(0xff7292CF);
// final Color primaryColor = Color(0xff2855ae);
final Color primaryColor = Color(0xFF1A495B);
//Color(0xff100a0a);

final customGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      accentColor,
      primaryColor,
    ]);

final buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      accentColor,
      primaryColor,
    ]);

final buildBackgroundImage = Container(
  decoration: BoxDecoration(
      image: DecorationImage(
          image: AssetImage(AppImages.backgroundImage), fit: BoxFit.fill)),
);
