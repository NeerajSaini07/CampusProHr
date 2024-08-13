import 'dart:io';

import 'package:campus_pro/src/DATA/BLOC_CUBIT/ONLINE_TEST_STUDENT_CUBIT/online_test_student_cubit.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UI/WIDGETS/noRecordFound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OnlineTestStudent extends StatefulWidget {
  static const routeName = "/online-test-student";
  const OnlineTestStudent();

  @override
  _OnlineTestStudentState createState() => _OnlineTestStudentState();
}

class _OnlineTestStudentState extends State<OnlineTestStudent> {
  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    getOnlineTestUrl();
    super.initState();
  }

  getOnlineTestUrl() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final stuInfo = await UserUtils.stuInfoDataFromCache();
    final testData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId!,
      "Schoolid": userData.schoolId!,
      "StuEmpId": userData.stuEmpId!,
      "Mobile": stuInfo!.mobile!,
      "TestUrl": userData.testUrl!,
      "UserType": userData.ouserType!,
    };
    print("Sending OnlineTestStudent data => $testData");
    context.read<OnlineTestStudentCubit>().onlineTestStudentCubitCall(testData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "Online Test"),
      body: BlocConsumer<OnlineTestStudentCubit, OnlineTestStudentState>(
        listener: (context, state) {
          if (state is OnlineTestStudentLoadFail) {
            if (state.failReason == "false") {
              UserUtils.unauthorizedUser(context);
            } else {
              Navigator.pop(context);
              Navigator.pop(context);
            }
          }
        },
        builder: (context, state) {
          if (state is OnlineTestStudentLoadInProgress) {
            return Center(child: CircularProgressIndicator());
          } else if (state is OnlineTestStudentLoadSuccess) {
            return buildOnlineTest(context, state.onlineTestURL);
          } else if (state is OnlineTestStudentLoadFail) {
            return noRecordFound();
          } else {
            return noRecordFound();
          }
        },
      ),
    );
  }

  Widget buildOnlineTest(BuildContext context, String? onlineTestURL) {
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: onlineTestURL,
    );
  }
}
