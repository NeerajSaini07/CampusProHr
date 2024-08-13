import 'dart:io' show Platform, SocketException;
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../CONSTANTS/stringConstants.dart';
import '../../UTILS/api_endpoints.dart';
import '../userUtils.dart';

class Auth {
  static Future<bool> updateDeviceId(String deviceId) async {
    String? uid = await UserUtils.idFromCache();
    var resBody = {};
    resBody["user_id"] = uid;
    resBody["device_type"] = Platform.isAndroid ? "android" : "ios";
    resBody["fcm_token"] = deviceId;

    try {
      print("===>>>" + resBody.toString());
      http.Response resp = await http.post(
        Uri.parse(ApiEndpoints.saveFcmToken),
        body: resBody,
        headers: headers,
        encoding: encoding,
      );

      print(resp.statusCode);

      if (resp.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (resp.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      Map<String, dynamic> respMap = json.decode(resp.body);
      print("FCM API Response data: $respMap");
      print(respMap['message']);
      bool status = respMap['status'] as bool;
      if (status) {
        return status;
      }
      throw respMap['message'] as String;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('Update error $e');
      return false;
    }
  }
}
