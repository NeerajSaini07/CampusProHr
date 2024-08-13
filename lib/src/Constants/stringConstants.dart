import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:flutter/material.dart';

const IMAGE_URL = "https://mobileweb.eiterp.com/";
const SOMETHING_WENT_WRONG = "Something went wrong!";
const NO_RECORD_FOUND = "No Record Found!";
const UNAUTHORIZED_USER = "false";
const RUPEES = "\u{20B9}";
const googleApiKey = "AIzaSyDvoRtb4WZ9Kb9svm1pbQSWNt6QsULBRto";

const STATUS_LOADING = "PAYMENT_LOADING";
const STATUS_SUCCESSFUL = "PAYMENT_SUCCESSFUL";
const STATUS_PENDING = "PAYMENT_PENDING";
const STATUS_FAILED = "PAYMENT_FAILED";
const STATUS_CHECKSUM_FAILED = "PAYMENT_CHECKSUM_FAILED";
const NO_INTERNET = "NO INTERNET";
//
const UnderConstruction = "App_Under_Maintenance";

extension CapExtension on String {
  //first letter only
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  //all letter in string
  String get allInCaps => this.toUpperCase();
  //all letter in string
  String get allInLower => this.toLowerCase();
  //first letter for each word in a string
  String get capitalizeFirstofEach => this
      .split(' ')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');
}

const schoolName = "Campus HR";
var schoolImage = "${AppImages.logo}";
const notificationLargeIcon = "@mipmap/ic_launcher";
const notificationTransparentIcon = "@mipmap/ic_launcher";

//Style
const splashScreenTextStyle = const TextStyle(
    color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18);

const commonStyleForText = const TextStyle(fontSize: 16);
