import 'dart:io' show Platform;

class Secret {
  static const ANDROID_CLIENT_ID =
      "541512065440-id08im1l8q7q0bikf8lmse9qu2558ure.apps.googleusercontent.com";
  // "441219070451-8ib3add0kjr9i7hl132igp43tgeq7n7q.apps.googleusercontent.com";
  static const IOS_CLIENT_ID =
      "441219070451-kel9n6id7tllc2286hlgmbisb0h82p83.apps.googleusercontent.com";
  static String getId() =>
      Platform.isAndroid ? Secret.ANDROID_CLIENT_ID : Secret.IOS_CLIENT_ID;
}
