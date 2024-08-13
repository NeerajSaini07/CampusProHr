import 'dart:io';

import 'package:campus_pro/src/DATA/BLOC_CUBIT/ONLINE_TEST_STUDENT_CUBIT/online_test_student_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/OPEN_MARKSHEET_CUBIT/open_marksheet_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/markSheetModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UI/WIDGETS/noRecordFound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

//TODO - Delete This Class in Future
class OpenMarksheet extends StatefulWidget {
  static const routeName = "/open-marksheet";
  final MarkSheetStudentModel? marksheet;
  const OpenMarksheet({Key? key, this.marksheet}) : super(key: key);

  @override
  _OpenMarksheetState createState() => _OpenMarksheetState();
}

class _OpenMarksheetState extends State<OpenMarksheet> {
  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    getMarksheetUrl();
    super.initState();
  }

  getMarksheetUrl() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final stuInfo = await UserUtils.stuInfoDataFromCache();
    final testData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId!,
      "Schoolid": userData.schoolId!,
      "SessionId": userData.currentSessionid!,
      "StuEmpId": userData.stuEmpId!,
      "UserType": userData.ouserType!,
      "AppUrl": userData.appUrl!,
      "Flag": "F",
      "MarksheetId": widget.marksheet!.tempMarkSheetId!,
    };
    print("Sending OpenMarksheet data => $testData");
    context.read<OpenMarksheetCubit>().openMarksheetCubitCall(testData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "Marksheet"),
      body: BlocConsumer<OpenMarksheetCubit, OpenMarksheetState>(
        listener: (context, state) {
          if (state is OpenMarksheetLoadFail) {
            Navigator.pop(context);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is OpenMarksheetLoadInProgress) {
            return Center(child: CircularProgressIndicator());
          } else if (state is OpenMarksheetLoadSuccess) {
            return buildMarksheet(context, state.marksheetURL);
          } else if (state is OpenMarksheetLoadFail) {
            return noRecordFound();
          } else {
            return noRecordFound();
          }
        },
      ),
    );
  }

  Widget buildMarksheet(BuildContext context, String? marksheetURL) {
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: marksheetURL,
    );
  }
}
