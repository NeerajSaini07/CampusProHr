import 'dart:convert';

import 'package:campus_pro/src/DATA/MODELS/appConfigSettingModel.dart';
import 'package:campus_pro/src/DATA/MODELS/employeeInfoModel.dart';
import 'package:campus_pro/src/DATA/MODELS/models.dart';
import 'package:campus_pro/src/DATA/MODELS/studentInfoModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/UI/PAGES/account_type_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserUtils {
  UserUtils._();

  static Future<void> cacheAppConfig(AppConfigSettingModel appConfigData) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("appConfig", jsonEncode(appConfigData.toJson()));
      print("appConfigData Cached!!!");
    } catch (e) {
      print("error on [appConfigData] :- $e ");
    }
  }

  static Future<AppConfigSettingModel?> appConfigFromCache() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? data = pref.getString("appConfig");
      AppConfigSettingModel appConfigData = AppConfigSettingModel.fromJson(jsonDecode(data.toString()));
      return appConfigData;
    } catch (e) {
      print("error on [appConfigFromCache] :- $e ");
      return null;
    }
  }

  static Future<void> cacheStuInfoData(StudentInfoModel stuInfoData) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("stuInfoData", jsonEncode(stuInfoData.toJson()));
      print("stuInfoData Cached!!!");
    } catch (e) {
      print("error on [cacheStuInfoData] :- $e ");
    }
  }

  static Future<StudentInfoModel?> stuInfoDataFromCache() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? data = pref.getString("stuInfoData");
      StudentInfoModel stuInfoData = StudentInfoModel.fromJson(jsonDecode(data.toString()));
      return stuInfoData;
    } catch (e) {
      print("error on [stuInfoDataFromCache] :- $e ");
      return null;
    }
  }

  static Future<void> cacheEmployeeInfoData(EmployeeInfoModel empInfoData) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("empInfoData", jsonEncode(empInfoData.toJson()));
      print("empInfoData Cached!!!");
    } catch (e) {
      print("error on [cacheEmpInfoData] :- $e ");
    }
  }

  static Future<EmployeeInfoModel?> empInfoDataFromCache() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? data = pref.getString("empInfoData");
      EmployeeInfoModel empInfoData = EmployeeInfoModel.fromJson(jsonDecode(data.toString()));
      return empInfoData;
    } catch (e) {
      print("error on [empInfoDataFromCache] :- $e ");
      return null;
    }
  }

  static Future<void> cacheUserTypeData(UserTypeModel userTypeData) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("User_Type_Data", jsonEncode(userTypeData.toJson()));
      print("userTypeData Cached!!!");
    } catch (e) {
      print("error on [cacheUserTypeData] :- $e ");
    }
  }

  static Future<UserTypeModel?> userTypeFromCache() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? data = pref.getString("User_Type_Data");
      UserTypeModel userTypeData =
          UserTypeModel.fromJson(jsonDecode(data.toString()));
      return userTypeData;
    } catch (e) {
      print("error on [userTypeFromCache] :- $e ");
      return null;
    }
  }

  static Future<void> cacheAccountTypeData(AccountType accountTypeData) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("account_type_data", jsonEncode(accountTypeData.toJson()));
      print("AccountTypeData Cached!!!");
    } catch (e) {
      print("error on [cacheAccountTypeData] :- $e ");
    }
  }

  static Future<AccountType?> accountTypeFromCache() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? data = pref.getString("account_type_data");
      AccountType accountTypeData = AccountType.fromJson(jsonDecode(data.toString()));
      return accountTypeData;
    } catch (e) {
      print("error on [accountTypeFromCache] :- $e ");
      return null;
    }
  }

  static Future<void> removeAccountTypesData() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.remove("account_type_data");
      print("RemoveAccountType Removed");
    } catch (e) {
      print("error on [removeAccountType] :- $e ");
    }
  }

  static Future<void> cacheId(String? uid) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("uid", uid!);
      print("Id Cached");
    } catch (e) {
      print("error on [cacheId] :- $e ");
    }
  }

  static Future<String?> idFromCache() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? uid = pref.getString("uid");
      return uid;
    } catch (e) {
      print("error on [idFromCache] :- $e ");
      return null;
    }
  }

  static Future<void> cacheIsMasterPwd(int value) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setInt("isMasterPwd", value);
      print("IsMasterPwd Cached");
    } catch (e) {
      print("error on [cacheIsMasterPwd] :- $e ");
    }
  }

  static Future<int?> isMasterPwdFromCache() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      int? loginToken = pref.getInt("isMasterPwd");
      return loginToken;
    } catch (e) {
      print("error on [isMasterPwdFromCache] :- $e ");
      return null;
    }
  }

  static Future<void> cacheLoginToken(String? loginToken) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("Login_Token", loginToken!);
      print("LoginToken Cached");
    } catch (e) {
      print("error on [cacheLoginToken] :- $e ");
    }
  }

  static Future<String?> loginTokenFromCache() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? loginToken = pref.getString("Login_Token");
      return loginToken;
    } catch (e) {
      print("error on [loginTokenFromCache] :- $e ");
      return null;
    }
  }

  static Future<void> cacheUserToken(String? userToken) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("User_Token", userToken!);
      print("UserToken update in Cached");
    } catch (e) {
      print("error on [cacheUserToken] :- $e ");
    }
  }

  static Future<String?> userTokenFromCache() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? userToken = pref.getString("User_Token");
      return userToken;
    } catch (e) {
      print("error on [userTokenFromCache] :- $e ");
      return null;
    }
  }

  static Future<void> cacheHeaderToken(String? headerToken) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("header_token", headerToken!);
      print("HeaderToken update in Cached");
    } catch (e) {
      print("error on [headerTokenFromCache] :- $e ");
    }
  }

  static Future<String?> headerTokenFromCache() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? headerToken = pref.getString("header_token");
      return headerToken;
    } catch (e) {
      print("error on [headerTokenFromCache] :- $e ");
      return null;
    }
  }

  static Future<void> cacheFcmToken(String? fcmToken) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("Fcm_Token", fcmToken!);
      print("FcmToken Cached");
    } catch (e) {
      print("error on [cacheFcmToken] :- $e ");
    }
  }

  static Future<String?> fcmTokenFromCache() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? fcmToken = pref.getString("Fcm_Token");
      return fcmToken;
    } catch (e) {
      print("error on [fcmTokenFromCache] :- $e ");
      return null;
    }
  }

  static Future<void> removeUserToken() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.remove("User_Token");
      print("UserToken Removed");
    } catch (e) {
      print("error on [removeUserToken] :- $e ");
    }
  }

  static Future<void> unauthorizedUser(BuildContext context) async {
    try {
      await UserUtils.removeAccountTypesData();
      await UserUtils.removeUserToken();
      print("Unauthorized User Found!");
      Navigator.pushNamedAndRemoveUntil(context, AccountTypeScreen.routeName, (route) => false);
    } catch (e) {
      print("error on [removeUserData] :- $e ");
    }
  }

  static Future<void> logout() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.clear();
      print("All Data Cleared");
    } catch (e) {
      print("error on [logout] :- $e ");
    }
  }

  ///

  static Future<void> cachePhoneNoPass({String? noPass}) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("PhoneNumberPass", noPass!);
      print("Number PassWord Cached");
    } catch (e) {
      print("error on number password cache $e");
    }
  }

  //Get Employee and Passwor For Login.

  static Future<String?> phoneNumberPassFromCache() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? noPass = pref.getString("PhoneNumberPass");
      print("Number PassWord Cached");
      return noPass!;
    } catch (e) {
      print("error on get number password cache $e");
      return null;
    }
  }
}
