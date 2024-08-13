import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UI/WIDGETS/toast.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

class FileDownload extends StatefulWidget {
  final String? fileUrl;
  final String? fileName;
  final Widget? downloadWidget;

  const FileDownload(
      {Key? key, this.fileUrl, this.fileName, this.downloadWidget})
      : super(key: key);
  @override
  _FileDownloadState createState() => _FileDownloadState();
}

class _FileDownloadState extends State<FileDownload> {
  String? _fileUrl;

  String? _fileName;
  final Dio _dio = Dio();

  String _progress = "-";

  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  @override
  void initState() {
    _fileUrl = widget.fileUrl!;
    _fileName = widget.fileName!;
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // final android = AndroidInitializationSettings("@mipmap/new_icon_trans");
    final android =
        AndroidInitializationSettings("$notificationTransparentIcon");
    // final iOS = IOSInitializationSettings();
    final initSettings = InitializationSettings(android: android, );

    // flutterLocalNotificationsPlugin!
    //     .initialize(initSettings, onSelectNotification: _onSelectNotification);

    flutterLocalNotificationsPlugin!
        .initialize(initSettings,);

    super.initState();
  }

  Future<void> _onSelectNotification(String? json) async {
    final obj = jsonDecode(json!);

    if (obj['isSuccess']) {
      OpenFile.open(obj['filePath']);
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('${obj['error']}'),
        ),
      );
    }
  }

  void _onReceiveProgress(int received, int total) {
    if (total != -1) {
      setState(() {
        _progress = (received / total * 100).toStringAsFixed(0) + "%";
      });
    }
  }

  showLocalNotification() async {
    var android = new AndroidNotificationDetails(
        'id', 'channel ', 
        priority: Priority.high, importance: Importance.max);
    // var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android);
    await flutterLocalNotificationsPlugin!.show(
        0, 'Flutter devs', 'Flutter Local Notification Demo', platform,
        payload: 'Welcome to the Local Notification demo ');
  }

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => _download(),
      child: widget.downloadWidget,
    );
  }

  Future<void> _download() async {
    final dir = await _getDownloadDirectory();
    final isPermissionStatusGranted = await _requestPermissions();

    if (isPermissionStatusGranted) {
      final savePath = path.join(dir.path, _fileName);
      if (await File(savePath).exists()) {
        print("File exists");
        toastAlertNotification(
            'File already downloaded. Please check your phone directory at $savePath');
        print(savePath);
        OpenFile.open(savePath);
      } else {
        print("File don't exists. Start Downloading...");
        await _startDownload(savePath);
      }
    } else {
      toastAlertNotification('Download Permission is denied!');
    }
  }

  Future<bool> _requestPermissions() async {
    var permission = await Permission.storage.status;

    if (permission != PermissionStatus.granted) {
      await Permission.storage.request();
      permission = await Permission.storage.status;
    }

    return permission == PermissionStatus.granted;
  }

  Future<void> _startDownload(String savePath) async {
    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'error': null,
    };

    try {
      print("Download _fileUrl : $_fileUrl & savePath : $savePath");
      final response = await _dio.download(_fileUrl!, savePath);
      // final response = await _dio.download(_fileUrl!, savePath,
      //     onReceiveProgress: _onReceiveProgress);
      result['isSuccess'] = response.statusCode == 200;
      result['filePath'] = savePath;
    } catch (ex) {
      result['error'] = ex.toString();
      print("error on FileDownloader : $ex");
    } finally {
      await _showPushNotification(result);
    }
  }

  Future<void> _showPushNotification(
      Map<String, dynamic> downloadStatus) async {
    final android = AndroidNotificationDetails(
      'channel id',
      'channel name',
      // 'channel description',
      priority: Priority.high,
      importance: Importance.max,
      // icon: "@mipmap/new_icon_trans",
      icon: "$notificationTransparentIcon",
    );
    // final iOS = IOSNotificationDetails();
    final platform = NotificationDetails(
      android: android,
      // iOS: iOS,
    );
    final json = jsonEncode(downloadStatus);
    final isSuccess = downloadStatus['isSuccess'];

    await flutterLocalNotificationsPlugin!.show(
      0, // notification id
      isSuccess ? '${widget.fileName}' : '${widget.fileName}',
      // isSuccess ? 'Success' : 'Failure',
      isSuccess
          // ? 'File has been downloaded successfully!'
          ? 'Download complete'
          : 'Download Failed, File URL is Invalid.',
      platform,
      payload: json,
    );
  }

  Future<Directory> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      // final path = await DownloadsPathProvider.downloadsDirectory;
      Directory? directory = Directory('/storage/emulated/0/Download');
      // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
      // ignore: avoid_slow_async_io
      if (!await directory.exists())
        directory = await getExternalStorageDirectory();
      return directory!;
    }

    // in this example we are using only Android and iOS so I can assume
    // that you are not trying it for other platforms and the if statement
    // for iOS is unnecessary

    // iOS directory visible to user
    return await getApplicationDocumentsDirectory();
  }
}

// class FileDownload extends StatefulWidget {
//   final String? fileUrl;
//   final String? fileName;
//   final Widget? downloadWidget;

//   const FileDownload(
//       {Key? key, this.fileUrl, this.fileName, this.downloadWidget})
//       : super(key: key);
//   @override
//   _FileDownloadState createState() => _FileDownloadState();
// }

// class _FileDownloadState extends State<FileDownload> {
//   String? _fileUrl;
//   // final String _fileUrl =
//   //     "https://images.unsplash.com/photo-1533450718592-29d45635f0a9?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8anBnfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80";
//   String? _fileName;
//   final Dio _dio = Dio();

//   String _progress = "-";

//   FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

//   @override
//   void initState() {
//     _fileUrl = widget.fileUrl!;
//     _fileName = widget.fileName!;
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//     final android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     final iOS = IOSInitializationSettings();
//     final initSettings = InitializationSettings(android: android, iOS: iOS);

//     flutterLocalNotificationsPlugin!
//         .initialize(initSettings, onSelectNotification: _onSelectNotification);

//     super.initState();
//   }

//   Future<void> _onSelectNotification(String? json) async {
//     final obj = jsonDecode(json!);

//     if (obj['isSuccess']) {
//       OpenFile.open(obj['filePath']);
//     } else {
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           title: Text('Error'),
//           content: Text('${obj['error']}'),
//         ),
//       );
//     }
//   }

//   void _onReceiveProgress(int received, int total) {
//     if (total != -1) {
//       setState(() {
//         _progress = (received / total * 100).toStringAsFixed(0) + "%";
//       });
//     }
//   }

//   showLocalNotification() async {
//     var android = new AndroidNotificationDetails(
//         'id', 'channel ', 'description',
//         priority: Priority.high, importance: Importance.max);
//     var iOS = new IOSNotificationDetails();
//     var platform = new NotificationDetails(android: android, iOS: iOS);
//     await flutterLocalNotificationsPlugin!.show(
//         0, 'Flutter devs', 'Flutter Local Notification Demo', platform,
//         payload: 'Welcome to the Local Notification demo ');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkResponse(
//       onTap: () => _download(),
//       child: widget.downloadWidget,
//       // child: Row(
//       //   children: [
//       //     Text('$_progress'),
//       //     Icon(Icons.file_download, color: Theme.of(context).primaryColor),
//       //   ],
//       // ),
//     );
//   }

//   Future<void> _download() async {
//     final dir = await _getDownloadDirectory();
//     final isPermissionStatusGranted = await _requestPermissions();

//     if (isPermissionStatusGranted) {
//       final savePath = path.join(dir.path, _fileName);
//       // if (await File(savePath).exists()) {
//       //   print("File exists");
//       //   toastAlertNotification(
//       //       'File already downloaded. Please check your phone directory.');
//       // } else {
//       print("File don't exists. Start Downloading...");
//       await _startDownload(savePath);
//       // }
//     } else {
//       // handle the scenario when user declines the permissions
//     }
//   }

//   Future<bool> _requestPermissions() async {
//     var permission = await Permission.storage.status;

//     if (permission != PermissionStatus.granted) {
//       await Permission.storage.request();
//       permission = await Permission.storage.status;
//     }

//     return permission == PermissionStatus.granted;
//   }

//   Future<void> _startDownload(String savePath) async {
//     Map<String, dynamic> result = {
//       'isSuccess': false,
//       'filePath': null,
//       'error': null,
//     };

//     try {
//       print("before");
//       final response = await _dio.download(_fileUrl!, savePath,
//           onReceiveProgress: _onReceiveProgress);
//       print("response : ${response}");
//       print("response.statusCode : ${response.statusCode}");
//       result['isSuccess'] = response.statusCode == 200 ? "Success" : "Failure";
//       result['filePath'] = savePath;
//       print("isSuccess : $result");
//     } catch (ex) {
//       print("error : $ex");
//       result['error'] = ex.toString();
//     } finally {
//       print("result : $result");
//       await _showPushNotification(result);
//       // showLocalNotification();
//     }
//   }

//   Future<void> _showPushNotification(
//       Map<String, dynamic> downloadStatus) async {
//     final android = AndroidNotificationDetails(
//         'channel id', 'channel name', 'channel description',
//         priority: Priority.high, importance: Importance.max);
//     final iOS = IOSNotificationDetails();
//     final platform = NotificationDetails(android: android, iOS: iOS);
//     final json = jsonEncode(downloadStatus);
//     final isSuccess = downloadStatus['isSuccess'];

//     await flutterLocalNotificationsPlugin!.show(
//         0, // notification id
//         isSuccess ? 'Success' : 'Failure',
//         isSuccess
//             // ? 'File has been downloaded successfully!'
//             ? '${widget.fileName}'
//             : 'There was an error while downloading the file.',
//         platform,
//         payload: json);
//   }

//   Future<Directory> _getDownloadDirectory() async {
//     if (Platform.isAndroid) {
//       final path = await DownloadsPathProvider.downloadsDirectory;
//       return path!;
//     }

//     // in this example we are using only Android and iOS so I can assume
//     // that you are not trying it for other platforms and the if statement
//     // for iOS is unnecessary

//     // iOS directory visible to user
//     return await getApplicationDocumentsDirectory();
//   }
// }
