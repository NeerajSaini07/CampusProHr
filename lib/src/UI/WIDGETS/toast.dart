import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

toast(String msg) {
  BotToast.showText(text: msg);
}

toastAlertNotification(String msg, {int seconds = 3}) {
  BotToast.showSimpleNotification(
      title: "$msg",
      backgroundColor: Colors.orange[400],
      titleStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      duration: Duration(seconds: seconds));
}

toastSuccessNotification(String msg, {int seconds = 3}) {
  BotToast.showSimpleNotification(
      title: "$msg",
      backgroundColor: Colors.green,
      titleStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      duration: Duration(seconds: seconds));
}

toastFailedNotification(String msg, {int seconds = 5}) {
  BotToast.showSimpleNotification(
      title: "Alert!",
      subTitle: "$msg",
      backgroundColor: Colors.red[400],
      closeIcon: Icon(Icons.close, color: Colors.white),
      titleStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w900,
        fontSize: 18,
      ),
      subTitleStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      duration: Duration(seconds: seconds));
}
