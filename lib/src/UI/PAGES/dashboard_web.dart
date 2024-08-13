import 'dart:convert';
import 'dart:developer';

import 'package:campus_pro/src/CONSTANTS/themeData.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/header_token_cubit/header_token_cubit.dart';
import 'package:campus_pro/src/UI/PAGES/account_type_screen.dart';
import 'package:campus_pro/src/globalBlocProvidersFile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../DATA/MODELS/notifyCounterModel.dart';
import '../../DATA/MODELS/userTypeModel.dart';
import '../../DATA/userUtils.dart';
import '../../UTILS/appImages.dart';
import '../WIDGETS/commonAppBar.dart';
import '../WIDGETS/drawerWidget.dart';
import 'package:permission_handler/permission_handler.dart';

class DashboardWeb extends StatefulWidget {
  final String? url;

  // final String? userType;

  DashboardWeb({
    Key? key,
    this.url,
  }) : super(key: key);

  @override
  State<DashboardWeb> createState() => _DashboardWebState();
}

class _DashboardWebState extends State<DashboardWeb> {
  String? user = "";
  int? notiBadge = 0;
  int totalCount = 0;

  final GlobalKey<ScaffoldState>? _scaffoldKey = new GlobalKey<ScaffoldState>();

  String? userType = "";
  List<NotifyCounterModel> notifyList = [];

  void getUserType() async {
    final accountTypeData = await UserUtils.accountTypeFromCache();
    setState(() {
      userType = accountTypeData!.userType;
    });
  }

  getPermission() async {
    await Permission.camera.request();
    await Permission.microphone.request();
  }

  InAppWebViewController? webViewController;

  @override
  void initState() {
    _setupInteractedMessage();
    getDrawerItems();
    getUserType();
    getPermission();
    // getDashboardData();
    // getDashboardEmpData();
    super.initState();
  }

  getDrawerItems() async {
    await context.read<FcmTokenStoreCubit>().fcmTokenStoreCubitCall();
    final userData = await UserUtils.accountTypeFromCache();
    final userId = await UserUtils.idFromCache();
    final userToken = await UserUtils.userTokenFromCache();
    setState(() {
      user = userData!.userType;
    });

    final tokenBody = {
      "OUserId": userId!,
      'EmpId': userData!.employId,
      "OrgId": userData.organizationId,
      "CompanyId": userData.companyId,
      "UserType": userData.userType,
      'Token': userToken!,
    };

    await context.read<HeaderTokenCubit>().getHeaderTokenCubitCall(tokenBody);

    final headerToken = await UserUtils.headerTokenFromCache();

    final drawerData = {
      "OrgId": userData.organizationId,
      "CompanyId": userData.companyId,
      "UserType": userData.userType,
    };
    print("Sending drawer items $drawerData");
    context.read<DrawerCubit>().drawerCubitCall(drawerData, headerToken!);
    // if (userData.userType.toLowerCase() == "s")
    //   getNotifyCounterList(
    //     "S",
    //   );
  }

  getNotifyCounterList(String flag) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final stuInfo = await UserUtils.stuInfoDataFromCache();
    print("stuInfo stuInfo  $stuInfo");
    final requestPayload = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData.schoolId,
      'SessionId': userData.currentSessionid,
      'ClassId': stuInfo!.classId,
      'SectionId': stuInfo.classSectionId,
      'StreamId': stuInfo.streamId,
      'YearId': stuInfo.yearId,
      'StuEmpId': userData.stuEmpId,
      'Flag': flag,
      'UserType': userData.ouserType,
    };
    context.read<NotifyCounterCubit>().notificationCubitCall(requestPayload);
  }

  getDashboardData() async {
    final uid = await UserUtils.idFromCache();
    final userToken = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final studentData = {
      "OUserId": uid!,
      "Token": userToken!,
      "OrgId": userData!.organizationId!,
      "Schoolid": userData.schoolId!,
      "StudentId": userData.stuEmpId!,
      "SessionId": userData.currentSessionid!,
      "UserType": userData.ouserType!,
    };
    print("Student info data $studentData");
    context.read<StudentInfoCubit>().studentInfoCubitCall(studentData);
  }

  getDashboardEmpData() async {
    String? uid = '';
    String? token = '';
    UserTypeModel? userData;
    uid = await UserUtils.idFromCache();
    token = await UserUtils.userTokenFromCache();
    userData = await UserUtils.userTypeFromCache();
    final employeeData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId!,
      "Schoolid": userData.schoolId!,
      "EmpId": userData.stuEmpId!,
      "SessionId": userData.currentSessionid!,
      "SearchEmpId": userData.stuEmpId!,
      "UserType": userData.ouserType!,
    };
    print('Sending Employee Info Data $employeeData');
    context.read<EmployeeInfoCubit>().employeeInfoCubitCall(employeeData);
  }

  Future<bool> _goBack() async {
    if (webViewController != null && await webViewController!.canGoBack()) {
      webViewController?.goBack();
      return false;
    } else {
      await webViewController?.reload();
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _goBack,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: BlocProvider<UserSchoolDetailCubit>(
          create: (_) => UserSchoolDetailCubit(
              UserSchoolDetailRepository(UserSchoolDetailApi())),
          child: BlocProvider<EmployeeInfoCubit>(
            create: (_) =>
                EmployeeInfoCubit(EmployeeInfoRepository(EmployeeInfoApi())),
            child: BlocProvider<StudentInfoCubit>(
              create: (_) =>
                  StudentInfoCubit(StudentInfoRepository(StudentInfoApi())),
              child: BlocProvider<GotoWebAppCubit>(
                create: (_) =>
                    GotoWebAppCubit(GotoWebAppRepository(GotoWebAppApi())),
                child: DrawerWidget(),
              ),
            ),
          ),
        ),
        key: _scaffoldKey,
        appBar: commonAppBar(
          context,
          onTap: _goBack,
          centerTitle: true,
          scaffoldKey: _scaffoldKey,
          showMenuIcon: false,
          shadowColor: Colors.transparent,
          backgroundColor: primaryColor,
          title: "RUGERP",
          style: GoogleFonts.quicksand(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
          icon2: IconButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context, AccountTypeScreen.routeName, (route) => false),
            icon: Container(
              height: 20,
              width: 20,
              child: Image.asset(AppImages.switchUser,
                  fit: BoxFit.cover, color: Colors.white),
            ),
          ),
          icon: user!.toLowerCase() == "s" || user!.toLowerCase() == "f"
              ? totalCount > 0
                  ? GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: ListView.builder(
                                      itemCount: notifyList.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        var item = notifyList[index];
                                        return GestureDetector(
                                            onTap: () {
                                              if (item.title
                                                      .split("Count")[0]
                                                      .toLowerCase() ==
                                                  "homework") {
                                                setState(() {
                                                  notifyList.removeAt(index);
                                                  notiBadge =
                                                      notiBadge! - item.count;
                                                  totalCount =
                                                      totalCount - item.count;
                                                });
                                                getNotifyCounterList(
                                                  "homework",
                                                );

                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return BlocProvider<
                                                      HomeWorkStudentCubit>(
                                                    create: (_) => HomeWorkStudentCubit(
                                                        HomeWorkStudentRepository(
                                                            HomeWorkStudentApi())),
                                                    child: HomeWorkStudent(),
                                                  );
                                                })).then((value) =>
                                                    Navigator.pop(context));
                                              }
                                              if (item.title
                                                      .split("Count")[0]
                                                      .toLowerCase() ==
                                                  "classroom") {
                                                setState(() {
                                                  notifyList.removeAt(index);
                                                  notiBadge =
                                                      notiBadge! - item.count;
                                                  totalCount =
                                                      totalCount - item.count;
                                                });
                                                getNotifyCounterList(
                                                  "classroom",
                                                );
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return BlocProvider<
                                                      ClassRoomsStudentCubit>(
                                                    create: (_) =>
                                                        ClassRoomsStudentCubit(
                                                            ClassRoomsStudentRepository(
                                                                ClassRoomsStudentApi())),
                                                    child: BlocProvider<
                                                        ClassEndDrawerLocalCubit>(
                                                      create: (_) =>
                                                          ClassEndDrawerLocalCubit(),
                                                      child: BlocProvider<
                                                          TeachersListCubit>(
                                                        create: (_) =>
                                                            TeachersListCubit(
                                                                TeachersListRepository(
                                                                    TeachersListApi())),
                                                        child: BlocProvider<
                                                            SendCustomClassRoomCommentCubit>(
                                                          create: (_) =>
                                                              SendCustomClassRoomCommentCubit(
                                                                  SendCustomClassRoomCommentRepository(
                                                                      SendCustomClassRoomCommentApi())),
                                                          child:
                                                              ClassRoomsStudent(),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                })).then((value) =>
                                                    Navigator.pop(context));
                                                // Navigator.pushNamed(
                                                //         context,
                                                //         ClassRoomsStudent
                                                //             .routeName)
                                                //     .then((value) =>
                                                //         Navigator.pop(context));
                                              }
                                              if (item.title
                                                      .split("Count")[0]
                                                      .toLowerCase() ==
                                                  "circular") {
                                                setState(() {
                                                  notifyList.removeAt(index);
                                                  notiBadge =
                                                      notiBadge! - item.count;
                                                  totalCount =
                                                      totalCount - item.count;
                                                });
                                                getNotifyCounterList(
                                                    "circular");
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return BlocProvider<
                                                      CircularStudentCubit>(
                                                    create: (_) => CircularStudentCubit(
                                                        CircularStudentRepository(
                                                            CircularStudentApi())),
                                                    child: CircularStudent(),
                                                  );
                                                })).then((value) =>
                                                    Navigator.pop(context));
                                              }
                                              if (item.title
                                                      .split("Count")[0]
                                                      .toLowerCase() ==
                                                  "activity") {
                                                setState(() {
                                                  notifyList.removeAt(index);
                                                  notiBadge =
                                                      notiBadge! - item.count;
                                                  totalCount =
                                                      totalCount - item.count;
                                                });
                                                getNotifyCounterList(
                                                  "activity",
                                                );
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return BlocProvider<
                                                      ActivityForStudentCubit>(
                                                    create: (_) =>
                                                        ActivityForStudentCubit(
                                                            ActivityForStudentRepository(
                                                                ActivityForStudentApi())),
                                                    child: ActivityStudent(),
                                                  );
                                                })).then((value) =>
                                                    Navigator.pop(context));
                                              }
                                              if (item.title
                                                      .split("Count")[0]
                                                      .toLowerCase() ==
                                                  "meeting") {
                                                setState(() {
                                                  notifyList.removeAt(index);
                                                  notiBadge =
                                                      notiBadge! - item.count;
                                                  totalCount =
                                                      totalCount - item.count;
                                                });
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: item.count > 0
                                                ? Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                              getNotificationIcon(
                                                                  item.title.split(
                                                                      "Count")[0]),
                                                              width: 25),
                                                          SizedBox(width: 8.0),
                                                          Text(
                                                            "You have ${item.count} new ${item.title.split("Count")[0]}",
                                                            textScaleFactor:
                                                                1.2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          SizedBox(
                                                            height: 50,
                                                          ),
                                                        ],
                                                      ),
                                                      Divider(),
                                                    ],
                                                  )
                                                : Container());
                                      }),
                                ),
                              );
                            });
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 13, right: 5),
                        child: Stack(
                          children: [
                            Icon(
                              Icons.notifications,
                              color: Colors.white,
                              size: 28,
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: new Container(
                                padding: EdgeInsets.all(2),
                                decoration: new BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 14,
                                  minHeight: 14,
                                ),
                                child: Text(
                                  notiBadge.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 13, right: 5),
                      child: Stack(
                        children: [
                          Icon(
                            Icons.notifications,
                            // color: Theme.of(context).primaryColor,
                            color: Colors.white,
                            size: 28,
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: new Container(
                              padding: EdgeInsets.all(2),
                              decoration: new BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 14,
                                minHeight: 14,
                              ),
                              child: Text(
                                notiBadge.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
              : Container(),
        ),
        body: SafeArea(
          child: MultiBlocListener(
            listeners: [
              BlocListener<NotifyCounterCubit, NotifyCounterState>(
                listener: (context, state) {
                  if (state is NotifyCounterLoadSuccess) {
                    print("testing:${state.notifyList}");
                    print("");

                    state.notifyList.forEach((element) {
                      totalCount += element.count;
                    });
                    print("total Count ");
                    setState(() {
                      notifyList = state.notifyList;
                      notifyList.sort((a, b) => b.count.compareTo(a.count));
                      notifyList.forEach((element) {
                        notiBadge = notiBadge! + element.count;
                      });
                      // for (var i = 0; i < notifyList.length; i++) {
                      //   if (notifyList[i].count > 0) {
                      //     dynamic stateMenu = _menuKey.currentState;
                      //     stateMenu.showButtonMenu();
                      //     break;
                      //   }
                      // }
                      // notifyList.removeWhere((element) => element.count == 0);
                    });
                  }
                  if (state is NotifyCounterLoadFail) {
                    if (state.failReason == "false") {
                      UserUtils.unauthorizedUser(context);
                    } else {
                      setState(() {
                        notifyList.removeWhere((element) => element.count == 0);
                      });
                    }
                  }
                },
              ),
              BlocListener<DrawerCubit, DrawerState>(
                  listener: (context, state) async {
                if (state is DrawerLoadSuccess) {
                  /// Adding data for route to web view
                  var data = [];
                  state.drawerItems.forEach((element) {
                    if (element.subMenu!.length > 0) {
                      element.subMenu!.forEach((ele) {
                        print(ele.subMenuID);
                        data.add({
                          "id": ele.subMenuID,
                          "url": ele.navigateURL,
                          "flag": ele.subMenuFlag,
                          "type": "s",
                          //"murl": ele.menuURL,
                        });
                      });
                    } else {
                      print(element.menuURL);
                      data.add({
                        "id": element.menuID,
                        "url": element.menuURL,
                        "flag": element.menuFlag,
                        "type": "m",
                        //"surl": element.navigateURL,
                      });
                    }
                  });
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  await pref.remove("DrawerItemSave");
                  await pref.setString("DrawerItemSave", jsonEncode(data));
                }
              }),
            ],
            child: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: InAppWebView(
                      initialUrlRequest:
                          URLRequest(url: Uri.parse("${widget.url!}")),
                      initialOptions: InAppWebViewGroupOptions(
                        android: AndroidInAppWebViewOptions(
                          useHybridComposition: true,
                          geolocationEnabled: true,
                          disableDefaultErrorPage: true,
                        ),
                        crossPlatform: InAppWebViewOptions(
                          useOnDownloadStart: true,
                        ),
                      ),
                      onWebViewCreated: (InAppWebViewController controller) {
                        webViewController = controller;
                      },
                      onCloseWindow: (controller) {},
                      onLoadStart:
                          (InAppWebViewController controller, Uri? url) async {
                        log("----------${url.toString()}--------------");
                        if (url != null &&
                            url.toString().contains(
                                "https://appdev.rugerp.com/Login/LoginAccounts")) {
                          // _goBack();
                          Navigator.pushNamedAndRemoveUntil(context,
                              AccountTypeScreen.routeName, (route) => false);
                        }
                      },
                      onLoadStop:
                          (InAppWebViewController controller, Uri? url) async {
                        await controller.evaluateJavascript(
                          source:
                              "window.localStorage.setItem('key', 'localStorage value!')",
                        );
                      },
                      onDownloadStartRequest: (controller, url) async {
                        final String _urlFiles =
                            "${url.url.toString().replaceAll('blob:', '')}";
                        print("onDownloadStart $_urlFiles");
                        try {
                          await launchUrl(
                            Uri.parse(_urlFiles),
                            mode: LaunchMode.inAppWebView,
                            webViewConfiguration: WebViewConfiguration(
                              headers: {
                                "Content-Type": "application/pdf",
                                "Content-Disposition": "attachment",
                                "fileName":
                                    "${DateTime.now().microsecondsSinceEpoch}.pdf",
                              },
                            ),
                          );
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getNotificationIcon(String? smsType) {
    switch (smsType!.toLowerCase()) {
      case "homework":
        return AppImages.homeworkNotifyIcon;
      case "circular":
        return AppImages.bellIcon;
      case "activity":
        return AppImages.commonSmsIcon;
      case "classroom":
        return AppImages.classroomImage;
      default:
        return AppImages.bellIcon;
    }
  }

  Future<void> _setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    // handle the notification data when app is in foreground
    FirebaseMessaging.onMessage.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    print('Notification Data >>>> ${message.data.toString()}');
  }
}
