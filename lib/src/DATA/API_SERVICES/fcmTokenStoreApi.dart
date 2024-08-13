import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class FcmTokenStoreApi {
  Future<bool> storeToken() async {
    try {
      final uid = await UserUtils.idFromCache();
      final fcmToken = await FirebaseMessaging.instance.getToken();
      final accountTypeData = await UserUtils.accountTypeFromCache();
      final isMasterPwd = await UserUtils.isMasterPwdFromCache();
      final deviceType = Platform.operatingSystem.toUpperCase();
      final fcmTokenData = {
        'OUserId': uid,
        'OrgId': accountTypeData!.organizationId,
        'UserType': accountTypeData.userType,
        'CompanyId': accountTypeData.companyId,
        'EmpId': accountTypeData.employId,
        'FcmToken': fcmToken,
        "IsMstPwd": isMasterPwd.toString(),
        "DeviceType": deviceType,
        "IsUpdateToken": "N",
      };

      print("FcmTokenStore before API: $fcmTokenData");
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.saveFcmToken),
        body: fcmTokenData,
        headers: headers,
        encoding: encoding,
      );

      print("FcmTokenStore Status Code: ${response.statusCode}");
      print("FcmTokenStore API Body: ${response.body}");
      Map<String, dynamic> respMap = json.decode(response.body);

      if (response.statusCode == 200) {
        if (respMap['Data'] != []) {
          final token = respMap['Data'][0]['Token'] as String;
          await UserUtils.cacheUserToken(token);
          return true;
        }
      }
      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON FcmTokenStore API: $e");
      throw "$e";
    }
  }
}
