import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../DATA/userUtils.dart';

FlutterTts flutterTts = FlutterTts();

class NotificationService {
  Future initialize() async {
    await Firebase.initializeApp();
    FirebaseMessaging.instance.requestPermission(
        alert: true, badge: true, carPlay: true, sound: true);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
  }
}

void prompt(String url) async {
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  } else {
    throw 'Could not launch $url';
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.data}');

  // print(message.data);
  // flutterLocalNotificationsPlugin.show(
  //     message.data.hashCode,
  //     message.data['title'],
  //     message.data['body'],
  //     // "Notification",
  //     NotificationDetails(
  //       iOS: DarwinNotificationDetails(
  //           presentSound: true, presentAlert: true, presentBadge: true),
  //       android: AndroidNotificationDetails(
  //         channel.id,
  //         channel.name,
  //         icon: "@mipmap/icon",
  //         largeIcon: DrawableResourceAndroidBitmap("@mipmap/launcher_icon"),
  //       ),
  //     ));
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  // 'This channel is used for important notifications.', // description
  importance: Importance.high,
);
// final IOSFlutterLocalNotificationsPlugin iosChannel=IOSFlutterLocalNotificationsPlugin();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

initializeNotification() async {
  final initialzationSettingsAndroid =
      AndroidInitializationSettings('$notificationTransparentIcon');

  //******IOs notification settings */
  final DarwinInitializationSettings iosInitializationSettings =
      DarwinInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,
    onDidReceiveLocalNotification: onDidReceiveLocalNotification,
  );

  final initializationSettings = InitializationSettings(
    android: initialzationSettingsAndroid,
    iOS: iosInitializationSettings,
  );

  // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onSelectNotification: selectNotification);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null) {
      print("Notification Title : ${notification.title}");
      print("Notification Body : ${notification.body}");
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            iOS: DarwinNotificationDetails(
                presentSound: true, presentAlert: true, presentBadge: true),
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // icon: "@mipmap/icon",
              // icon: "@mipmap/new_icon_trans",
              icon: "$notificationTransparentIcon",
              // largeIcon: DrawableResourceAndroidBitmap("@mipmap/launcher_icon"),
              // largeIcon: DrawableResourceAndroidBitmap("@mipmap/new_icon"),
              largeIcon:
                  DrawableResourceAndroidBitmap("$notificationTransparentIcon"),

              // User For Providing expanded button in notification such that to show all body text
              styleInformation: BigTextStyleInformation(''),
            ),
          ));

      //Todo:Speaking service
      flutterTts.speak(notification.title!);
    }
  });
  getToken();
}

Future selectNotification(String? payload) async {
  if (payload != null) {
    debugPrint('notification payload: $payload');
  }
}

Future onDidReceiveLocalNotification(
    int? id, String? title, String? body, String? payload) async {
  // display a dialog with the notification details, tap ok to go to another page
  // showDialog(
  //   context: context,
  //   builder: (BuildContext context) => CupertinoAlertDialog(
  //     title: Text(title),
  //     content: Text(body),
  //     actions: [
  //       CupertinoDialogAction(
  //         isDefaultAction: true,
  //         child: Text('Ok'),
  //         onPressed: () async {
  //           Navigator.of(context, rootNavigator: true).pop();
  //           await Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => SecondScreen(payload),
  //             ),
  //           );
  //         },
  //       )
  //     ],
  //   ),
  // );
}

getToken() async {
  final token = await FirebaseMessaging.instance.getToken();
  print("FCM Token generated => $token");
  await UserUtils.cacheFcmToken(token);
}

Future instantNofitication() async {
  var android = AndroidNotificationDetails(
    "id",
    "channel",
    // "description",
    // icon: "@mipmap/icon",
    // icon: "@mipmap/new_icon_trans",
    icon: "$notificationTransparentIcon",
    // largeIcon: DrawableResourceAndroidBitmap("@mipmap/launcher_icon"),
    // largeIcon: DrawableResourceAndroidBitmap("@mipmap/new_icon"),
    // largeIcon: DrawableResourceAndroidBitmap("$notificationLargeIcon"),
    largeIcon: DrawableResourceAndroidBitmap("$notificationTransparentIcon"),

    // User For Providing expanded button in notification such that to show all body text
    styleInformation: BigTextStyleInformation(''),
  );

  var ios = DarwinNotificationDetails(
      presentAlert: true, presentBadge: true, presentSound: true);

  var platform = new NotificationDetails(android: android, iOS: ios);

  await flutterLocalNotificationsPlugin.show(
      0, "Instant notification", "Tap to do something", platform,
      payload: "Welcome to app");
}

// class NotificationService extends ChangeNotifier {
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   //initilize

//   Future initialize() async {
//     await Firebase.initializeApp();

//     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();

//     AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings("@mipmap/launcher_icon");

//     IOSInitializationSettings iosInitializationSettings =
//         IOSInitializationSettings();

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: androidInitializationSettings,
//             iOS: iosInitializationSettings);

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);

//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);

//     final token = await FirebaseMessaging.instance.getToken();
//     print("FCM Token generated => $token");
//     // await UserUtils.cacheUserToken(token);
//     // setState(() {
//     //   token = token;
//     // });
//   }

//   initializeNotification() {
//     AndroidInitializationSettings initialzationSettingsAndroid =
//         AndroidInitializationSettings(AppImages.logo);

//     IOSInitializationSettings iosInitializationSettings =
//         IOSInitializationSettings();

//     InitializationSettings initializationSettings = InitializationSettings(
//         android: initialzationSettingsAndroid, iOS: iosInitializationSettings);

//     _flutterLocalNotificationsPlugin.initialize(initializationSettings);
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       if (notification != null && android != null) {
//         _flutterLocalNotificationsPlugin.show(
//             notification.hashCode,
//             notification.title,
//             notification.body,
//             NotificationDetails(
//               android: AndroidNotificationDetails(
//                 channel.id,
//                 channel.name,
//                 channel.description,
//                 icon: android.smallIcon,
//               ),
//             ));
//       }
//     });
//   }

//   Future<void> _firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//     await Firebase.initializeApp();
//     print('Handling a background message ${message.messageId}');

//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//             'your channel id', 'your channel name', 'your channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker');
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await _flutterLocalNotificationsPlugin.show(
//         0, 'plain title', 'plain body', platformChannelSpecifics,
//         payload: 'item x');

//     print('message.data = ${message.data}');
//   }

//   //Instant Notifications
//   Future instantNofitication() async {
//     var android = AndroidNotificationDetails("id", "channel", "description");

//     var ios = IOSNotificationDetails();

//     var platform = new NotificationDetails(android: android, iOS: ios);

//     await _flutterLocalNotificationsPlugin.show(
//         0, "Demo instant notification", "Tap to do something", platform,
//         payload: "Welcome to demo app");
//   }

//   //Image notification
//   Future imageNotification() async {
//     var bigPicture = BigPictureStyleInformation(
//         DrawableResourceAndroidBitmap("@mipmap/launcher_icon"),
//         largeIcon: DrawableResourceAndroidBitmap("@mipmap/launcher_icon"),
//         contentTitle: "Demo image notification",
//         summaryText: "This is some text",
//         htmlFormatContent: true,
//         htmlFormatContentTitle: true);

//     var android = AndroidNotificationDetails("id", "channel", "description",
//         styleInformation: bigPicture);

//     var platform = new NotificationDetails(android: android);

//     await _flutterLocalNotificationsPlugin.show(
//         0, "Demo Image notification", "Tap to do something", platform,
//         payload: "Welcome to demo app");
//   }

//   //Stylish Notification
//   Future stylishNotification() async {
//     var android = AndroidNotificationDetails("id", "channel", "description",
//         color: Colors.deepOrange,
//         enableLights: true,
//         enableVibration: true,
//         largeIcon: DrawableResourceAndroidBitmap("@mipmap/launcher_icon"),
//         styleInformation: MediaStyleInformation(
//             htmlFormatContent: true, htmlFormatTitle: true));

//     var platform = new NotificationDetails(android: android);

//     await _flutterLocalNotificationsPlugin.show(
//         0, "Demo Stylish notification", "Tap to do something", platform);
//   }

//   //Sheduled Notification

//   Future sheduledNotification() async {
//     var interval = RepeatInterval.everyMinute;
//     var bigPicture = BigPictureStyleInformation(
//         DrawableResourceAndroidBitmap("@mipmap/launcher_icon"),
//         largeIcon: DrawableResourceAndroidBitmap("@mipmap/launcher_icon"),
//         contentTitle: "Demo image notification",
//         summaryText: "This is some text",
//         htmlFormatContent: true,
//         htmlFormatContentTitle: true);

//     var android = AndroidNotificationDetails("id", "channel", "description",
//         styleInformation: bigPicture);

//     var platform = new NotificationDetails(android: android);

//     await _flutterLocalNotificationsPlugin.periodicallyShow(
//         0,
//         "Demo Sheduled notification",
//         "Tap to do something",
//         interval,
//         platform);
//   }

//   //Cancel notification

//   Future cancelNotification() async {
//     await _flutterLocalNotificationsPlugin.cancelAll();
//   }
// }
