import 'package:campus_pro/src/DATA/MODELS/feeTypeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/getPopupAlertListModel.dart';
import 'package:campus_pro/src/DATA/MODELS/getPopupMessageListModel.dart';
import 'package:campus_pro/src/DATA/MODELS/resultAnnounceClassModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../../globalBlocProvidersFile.dart';

class PopUpConfigureAdmin extends StatefulWidget {
  static const routeName = "/pop-up-configure-admin";
  const PopUpConfigureAdmin({Key? key}) : super(key: key);

  @override
  _PopUpConfigureAdminState createState() => _PopUpConfigureAdminState();
}

class _PopUpConfigureAdminState extends State<PopUpConfigureAdmin> {
  TabController? tabController;

  int _currentIndex = 0;
  List<GetPopupMessageListModel>? messageList;
  List<GetPopupAlertListModel>? alertList;

  void tabIndexChange(int tabIndex) {
    setState(() {
      _currentIndex = tabIndex;
    });
  }

  getPopupMessageList() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userdata = await UserUtils.userTypeFromCache();

    final sendingDataForpopup = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userdata!.organizationId,
      "Schoolid": userdata.schoolId,
      "SessionId": userdata.currentSessionid,
      "EmpId": userdata.stuEmpId,
      "UserType": userdata.ouserType,
    };

    print('sending data for getpopupList $sendingDataForpopup');
    context
        .read<GetPopupMessageListCubit>()
        .getPopupMessageListCubitCall(sendingDataForpopup);
  }

  getPopupAlertList() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userdata = await UserUtils.userTypeFromCache();

    final sendingDataForpopup = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userdata!.organizationId,
      "Schoolid": userdata.schoolId,
      "SessionId": userdata.currentSessionid,
      "EmpId": userdata.stuEmpId,
      "UserType": userdata.ouserType,
    };

    print('sending data for popUpAlertList $sendingDataForpopup');
    context
        .read<GetPopupAlertListCubit>()
        .getPopupAlertListCubitCall(sendingDataForpopup);
  }

  deleteMessageList({String? messageid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userdata = await UserUtils.userTypeFromCache();

    final sendingDataForDelete = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userdata!.organizationId,
      "Schoolid": userdata.schoolId,
      "SessionId": userdata.currentSessionid,
      "EmpId": userdata.stuEmpId,
      "UserType": userdata.ouserType,
      "MessageId": messageid,
      "Status": "0",
    };

    print('sending data for popup message delete $sendingDataForDelete');
    context
        .read<DeleteMessagePopupCubit>()
        .deleteMessagePopupCubitCall(sendingDataForDelete);
  }

  deleteAlertList({String? alertid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userdata = await UserUtils.userTypeFromCache();

    final sendingDataForDelete = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userdata!.organizationId,
      "Schoolid": userdata.schoolId,
      "SessionId": userdata.currentSessionid,
      "EmpId": userdata.stuEmpId,
      "UserType": userdata.ouserType,
      "AlertId": alertid,
      "Status": "0",
    };

    print('sending data for popup message delete $sendingDataForDelete');
    context
        .read<DeleteAlertPopupCubit>()
        .deleteAlertPopupCubitCall(sendingDataForDelete);
  }

  @override
  void initState() {
    super.initState();
    getPopupMessageList();
    getPopupAlertList();
    // print(DateTime.now().microsecondsSinceEpoch);
  }

  Future<void> _refresh1() async {
    await Future.delayed(Duration(seconds: 1)).then((value) {
      getPopupMessageList();
      // getPopupAlertList();
    });
  }

  Future<void> _refresh2() async {
    await Future.delayed(Duration(seconds: 1)).then((value) {
      // getPopupMessageList();
      getPopupAlertList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Pop-up Configure"),
      floatingActionButton: buildBottomBar(),
      body: MultiBlocListener(
        listeners: [
          BlocListener<GetPopupMessageListCubit, GetPopupMessageListState>(
              listener: (context, state) {
            if (state is GetPopupMessageListLoadSuccess) {
              setState(() {
                messageList = state.popupList;
              });
            } else if (state is GetPopupMessageListLoadFail) {
              if (state.failReason == 'false') {
                UserUtils.unauthorizedUser(context);
              } else {
                setState(() {
                  messageList = [];
                });
              }
            }
          }),
          BlocListener<GetPopupAlertListCubit, GetPopupAlertListState>(
              listener: (context, state) {
            if (state is GetPopupAlertListLoadSuccess) {
              setState(() {
                alertList = state.popupList;
              });
            } else if (state is GetPopupAlertListLoadFail) {
              if (state.failReason == 'false') {
                UserUtils.unauthorizedUser(context);
              } else {
                setState(() {
                  alertList = [];
                });
              }
            }
          }),
          BlocListener<DeleteMessagePopupCubit, DeleteMessagePopupState>(
              listener: (context, state) {
            if (state is DeleteMessagePopupLoadSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                commonSnackBar(
                    title: 'Popup Message Deleted',
                    duration: Duration(seconds: 1)),
              );
              getPopupMessageList();
            } else if (state is DeleteMessagePopupLoadFail) {
              if (state.failReason == 'false') {
                UserUtils.unauthorizedUser(context);
              }
            }
          }),
          BlocListener<DeleteAlertPopupCubit, DeleteAlertPopupState>(
              listener: (context, state) {
            if (state is DeleteAlertPopupLoadSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                commonSnackBar(
                    title: 'Popup Alert Deleted',
                    duration: Duration(seconds: 1)),
              );
              getPopupAlertList();
            } else if (state is DeleteAlertPopupLoadFail) {
              if (state.failReason == 'false') {
                UserUtils.unauthorizedUser(context);
              }
            }
          }),
        ],
        child: DefaultTabController(
          initialIndex: _currentIndex,
          length: 2,
          child: Column(
            children: [
              // SizedBox(height: 20),
              buildTabBar(context),
              Expanded(
                child: TabBarView(
                  // physics: NeverScrollableScrollPhysics(),
                  children: [
                    BlocBuilder<GetPopupMessageListCubit,
                        GetPopupMessageListState>(builder: (context, state) {
                      if (state is GetPopupMessageListLoadInProgress) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                        // return Container(child: LinearProgressIndicator());
                      } else if (state is GetPopupMessageListLoadSuccess) {
                        return checkMessageList(messageList: messageList);
                      } else if (state is GetPopupMessageListLoadFail) {
                        return checkMessageList(error: state.failReason);
                      } else {
                        return Container();
                      }
                    }),
                    //buildMessages(context),
                    BlocBuilder<GetPopupAlertListCubit, GetPopupAlertListState>(
                        builder: (context, state) {
                      if (state is GetPopupAlertListLoadInProgress) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is GetPopupAlertListLoadSuccess) {
                        return checkAlertList(alertList: alertList);
                      } else if (state is GetPopupAlertListLoadFail) {
                        return checkAlertList(error: state.failReason);
                      } else {
                        return Container();
                      }
                    }),
                    //buildAlerts(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget checkMessageList(
      {List<GetPopupMessageListModel>? messageList, String? error}) {
    if (messageList == null || messageList.isEmpty) {
      if (error == null || error.isEmpty) {
        return Center(
          child: Text(
            'Wait',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        );
      } else {
        return Center(
          child: Text(
            '$error',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        );
      }
    } else {
      return buildMessages(context, messageList: messageList);
    }
  }

  Widget buildMessages(BuildContext context,
      {List<GetPopupMessageListModel>? messageList}) {
    return RefreshIndicator(
      onRefresh: _refresh1,
      child: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 40),
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(height: 10),
          shrinkWrap: true,
          itemCount: messageList!.length,
          itemBuilder: (context, i) {
            var item = messageList[i];
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffECECEC)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.groupName}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('Delete Group');
                          deleteMessageList(
                              messageid: item.messageId.toString());
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Html(
                          data: item.message,
                          style: {
                            "body": Style(
                              fontSize: FontSize(14.0),
                              fontWeight: FontWeight.w600,
                            ),
                          },
                        ),
                      ),
                      // Text(
                      //   '${item.message}',
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      Flexible(
                        flex: 1,
                        child: Text(
                          '${item.tillDate}',
                          style: TextStyle(
                            fontSize: 13,
                            // fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget checkAlertList(
      {List<GetPopupAlertListModel>? alertList, String? error}) {
    if (alertList == null || alertList.isEmpty) {
      if (error == null || error.isEmpty) {
        return Center(
          child: Text(
            'Wait',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        );
      } else {
        return Center(
          child: Text(
            '$error',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        );
      }
    } else {
      return buildAlerts(context, alertList: alertList);
    }
  }

  Widget buildAlerts(BuildContext context,
      {List<GetPopupAlertListModel>? alertList}) {
    return RefreshIndicator(
      onRefresh: _refresh2,
      child: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 40),
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(height: 10),
          shrinkWrap: true,
          itemCount: alertList!.length,
          itemBuilder: (context, i) {
            var item = alertList[i];
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffECECEC)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.groupName}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('Delete Alert');
                          deleteAlertList(alertid: item.alertId.toString());
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Alert Limit : ${item.alertLimit1}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Restrict Limit : ${item.alertLimit2}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Html(
                          data: item.message,
                          shrinkWrap: true,
                          style: {
                            "body": Style(
                              fontSize: FontSize(14.0),
                              fontWeight: FontWeight.w600,
                            ),
                          },
                        ),
                      ),
                      // Text(
                      //   '${item.message}',
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      Flexible(
                        flex: 1,
                        child: Text(
                          '${item.tillDate}',
                          style: TextStyle(
                            fontSize: 13,
                            // fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Container buildTabBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0),
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor)),
      child: TabBar(
        unselectedLabelColor: Theme.of(context).primaryColor,
        labelColor: Colors.white,
        indicator: BoxDecoration(
          // gradient: customGradient,
          color: Theme.of(context).primaryColor,
        ),
        physics: ClampingScrollPhysics(),
        onTap: (int tabIndex) {
          print("tabIndex: $tabIndex");
          switch (tabIndex) {
            case 0:
              tabIndexChange(tabIndex);
              // getSample();
              break;
            case 1:
              tabIndexChange(tabIndex);
              break;
            default:
              tabIndexChange(tabIndex);
              // getSample();
              break;
          }
        },
        tabs: [
          buildTabs(title: 'Popup Messages', index: 0),
          buildTabs(title: 'Popup Alerts', index: 1),
        ],
        controller: tabController,
      ),
    );
  }

  GestureDetector buildBottomBar() {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return BlocProvider<SavePopupAlertCubit>(
              create: (_) => SavePopupAlertCubit(
                  SavePopupAlertRepository(SavePopupAlertApi())),
              child: BlocProvider<SavePopupMessageCubit>(
                create: (_) => SavePopupMessageCubit(
                    SavePopupMessageRepository(SavePopupMessageApi())),
                child: BlocProvider<FeeTypeCubit>(
                  create: (_) => FeeTypeCubit(FeeTypeRepository(FeeTypeApi())),
                  child: BlocProvider<ResultAnnounceClassCubit>(
                    create: (_) => ResultAnnounceClassCubit(
                        ResultAnnounceClassRepository(
                            ResultAnnounceClassApi())),
                    child: AddNewPopUpConfigureAdmin(),
                  ),
                ),
              ),
            );
          },
        ),
      ),

      ///   in pop up edit the text editor to show in bottom while swipe

      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 0.08),
        ),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Text(
          "Create Pop-up",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Tab buildTabs({String? title, int? index}) {
    return Tab(
      child: Text(title ?? ""),
    );
  }
}

class AddNewPopUpConfigureAdmin extends StatefulWidget {
  static const routeName = "/add-new-pop-up-configure-admin";
  const AddNewPopUpConfigureAdmin({Key? key}) : super(key: key);

  @override
  _AddNewPopUpConfigureAdminState createState() =>
      _AddNewPopUpConfigureAdminState();
}

class _AddNewPopUpConfigureAdminState extends State<AddNewPopUpConfigureAdmin> {
  //userDropdown
  List<String>? userList = ["Student", "Employee"];
  String? selectedUser = "Student";
  // List<DropdownMenuItem<String>> userDropDown = userList!
  //     .map((e) => DropdownMenuItem(
  //           child: Text('$e'),
  //           value: e,
  //         ))
  //     .toList();
  //

  //Group DropDown
  List<FeeTypeModel> groupDropDown = [];
  List finalGroupDropDown = [];

  //
  TextEditingController _descController = TextEditingController();
  TextEditingController _limitAlertController = TextEditingController();
  TextEditingController _limitRestrictController = TextEditingController();

  //
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

  //multi class dropdown
  List<ResultAnnounceClassModel>? classListMulti = [];
  List finalClassList = [];
  final _classSelectKey = GlobalKey<FormFieldState>();

  //checkbox
  String? checkBoxCurrentValue = "1";
  //
  bool buttonLoader = false;
  //editors
  // QuillController _controller = QuillController.basic();
  // final HtmlEditorController controller = HtmlEditorController();

  Future<void> _selectDate(BuildContext context, {int? index}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFromDate,
      firstDate: DateTime(1990),
      lastDate: DateTime(2200),
      helpText: index == 0 ? "SELECT FROM DATE" : "SELECT TO DATE",
    );
    if (picked != null)
      setState(() {
        if (index == 0) {
          selectedFromDate = picked;
        } else {
          selectedToDate = picked;
        }
      });
  }

  final FocusNode editorFocusNode = FocusNode();

  // Widget getEditor() {
  //   return QuillEditor(
  //     controller: _controller,
  //     scrollable: true,
  //     scrollController: ScrollController(),
  //     focusNode: editorFocusNode,
  //     padding: EdgeInsets.all(5),
  //     autoFocus: true,
  //     readOnly: false,
  //     expands: false,
  //     placeholder: "compose_email",
  //   );
  // }
  //
  // Widget getToolBar() {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: quill.QuillToolbar.basic(
  //       controller: _controller,
  //       showUnderLineButton: false,
  //       showStrikeThrough: false,
  //       showColorButton: false,
  //       showBackgroundColorButton: false,
  //       showListCheck: false,
  //       showIndent: false,
  //     ),
  //   );
  // }

  getFeeType() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final feeTypeData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId!,
      "Schoolid": userData.schoolId!,
      "EmpStuId": userData.stuEmpId!,
      "UserType": userData.ouserType!,
      "ParamType": "Group",
    };
    context.read<FeeTypeCubit>().feeTypeCubitCall(feeTypeData);
  }

  getClassList() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final sendingClassData = {
      "OUserId": uid,
      "Token": token,
      "EmpID": userData!.stuEmpId,
      "OrgId": userData.organizationId,
      "Schoolid": userData.schoolId,
      "usertype": userData.ouserType,
      "classonly": "1",
      "classteacher": "1",
      "SessionId": userData.currentSessionid,
    };

    print('sending class data for class list $sendingClassData');

    context
        .read<ResultAnnounceClassCubit>()
        .resultAnnounceClassCubitCall(sendingClassData);
  }

  saveMessagePopUp(
      {String? toDate,
      String? fromDate,
      String? classids,
      String? groupids,
      String? message}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingMessageData = {
      "UserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "SchoolId": userData.schoolId,
      "Session": userData.currentSessionid,
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "MessageId": DateTime.now().microsecondsSinceEpoch.toString(),
      // "637713730650256401",
      "Classes": classids,
      "Groups": groupids,
      "MessageDate": DateFormat('dd-MMM-yyyy').format(DateTime.now()),
      "FromDate": fromDate,
      "ToDate": toDate,
      "Message": message,
      //"%3cp%3ewhole+school%3c%2fp%3e%0a",
      "forStuEmp": selectedUser == "Student" ? "S" : "E",
    };

    print('sending data for save popup message  $sendingMessageData');

    context
        .read<SavePopupMessageCubit>()
        .savePopupMessageCubitCall(sendingMessageData);
  }

  saveAlertPopUp({
    String? toDate,
    String? fromDate,
    String? classids,
    String? groupids,
    String? message,
    String? limit1,
    String? limit2,
  }) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingAlertData = {
      "UserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "SchoolId": userData.schoolId,
      "Session": userData.currentSessionid,
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "Classes": classids,
      "Groups": groupids,
      "AlertDate": DateFormat('dd-MMM-yyyy').format(DateTime.now()),
      "FromDate": fromDate,
      "ToDate": toDate,
      "Message": message,
      "forStuEmp": selectedUser == "Student" ? "S" : "E",
      "Limit1": limit1,
      "Limit2": limit2,
    };

    print('sending data for save popup alert  $sendingAlertData');

    context
        .read<SavePopupAlertCubit>()
        .savePopupAlertCubitCall(sendingAlertData);
  }

  @override
  void initState() {
    // QuillController _controller = QuillController.basic();
    //QuillToolbar.basic(controller: _controller);
    getFeeType();
    getClassList();
    super.initState();
  }

  @override
  void dispose() {
    // controller.disable();
    _limitRestrictController.dispose();
    _limitAlertController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Create Popup"),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ResultAnnounceClassCubit, ResultAnnounceClassState>(
              listener: (context, state) {
            if (state is ResultAnnounceClassLoadSuccess) {
              setState(() {
                classListMulti = state.classList;
                // finalClassList = state.classList;
              });
            }
            if (state is ResultAnnounceClassLoadFail) {
              if (state.failReason == 'false') {
                UserUtils.unauthorizedUser(context);
              } else {
                classListMulti = [];
              }
            }
          }),
          BlocListener<FeeTypeCubit, FeeTypeState>(listener: (context, state) {
            if (state is FeeTypeLoadSuccess) {
              setState(() {
                groupDropDown = state.feeTypes;
              });
            }
            if (state is FeeTypeLoadFail) {
              if (state.failReason == 'false') {
                UserUtils.unauthorizedUser(context);
              } else {
                groupDropDown = [];
              }
            }
          }),
          BlocListener<SavePopupMessageCubit, SavePopupMessageState>(
              listener: (context, state) async {
            if (state is SavePopupMessageLoadInProgress) {
              setState(() {
                buttonLoader = true;
              });
            }
            if (state is SavePopupMessageLoadSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                commonSnackBar(
                  title: 'Message Sent',
                  duration: Duration(seconds: 1),
                ),
              );
              setState(() {
                finalClassList = [];
                finalGroupDropDown = [];
              });
              setState(() {
                buttonLoader = false;
              });
              // controller.clear();
              getClassList();
              getFeeType();

              ///
              final uid = await UserUtils.idFromCache();
              final token = await UserUtils.userTokenFromCache();
              final userdata = await UserUtils.userTypeFromCache();

              final sendingDataForpopup = {
                "OUserId": uid,
                "Token": token,
                "OrgId": userdata!.organizationId,
                "Schoolid": userdata.schoolId,
                "SessionId": userdata.currentSessionid,
                "EmpId": userdata.stuEmpId,
                "UserType": userdata.ouserType,
              };

              print('sending data for getpopupList $sendingDataForpopup');
              context
                  .read<GetPopupMessageListCubit>()
                  .getPopupMessageListCubitCall(sendingDataForpopup);
            }
            if (state is SavePopupMessageLoadFail) {
              if (state.failReason == 'false') {
                UserUtils.unauthorizedUser(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  commonSnackBar(
                    title: '${state.failReason}',
                    duration: Duration(seconds: 1),
                  ),
                );
                setState(() {
                  buttonLoader = false;
                });
              }
            }
          }),
          BlocListener<SavePopupAlertCubit, SavePopupAlertState>(
              listener: (context, state) async {
            if (state is SavePopupMessageLoadInProgress) {
              setState(() {
                buttonLoader = true;
              });
            }
            if (state is SavePopupAlertLoadSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                commonSnackBar(
                  title: 'Alert Sent',
                  duration: Duration(seconds: 1),
                ),
              );
              setState(() {
                finalClassList = [];
                finalGroupDropDown = [];
                _limitRestrictController.text = "";
                _limitAlertController.text = "";
              });
              setState(() {
                buttonLoader = false;
              });
              // controller.clear();
              getClassList();
              getFeeType();

              ///
              //Todo
              final uid = await UserUtils.idFromCache();
              final token = await UserUtils.userTokenFromCache();
              final userdata = await UserUtils.userTypeFromCache();

              final sendingDataForpopup = {
                "OUserId": uid,
                "Token": token,
                "OrgId": userdata!.organizationId,
                "Schoolid": userdata.schoolId,
                "SessionId": userdata.currentSessionid,
                "EmpId": userdata.stuEmpId,
                "UserType": userdata.ouserType,
              };

              print('sending data for popUpAlertList $sendingDataForpopup');
              context
                  .read<GetPopupAlertListCubit>()
                  .getPopupAlertListCubitCall(sendingDataForpopup);
            }
            if (state is SavePopupAlertLoadFail) {
              if (state.failReason == 'false') {
                UserUtils.unauthorizedUser(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  commonSnackBar(
                    title: '${state.failReason}',
                    duration: Duration(seconds: 1),
                  ),
                );
                setState(() {
                  buttonLoader = false;
                });
              }
            }
          }),
        ],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: 12, right: 12, top: 12, bottom: 2),
                    child: Column(
                      children: [
                        Text(
                          'General Message',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        Checkbox(
                            fillColor: MaterialStateProperty.all(Colors.blue),
                            value: checkBoxCurrentValue == "1" ? true : false,
                            onChanged: (val) {
                              if (checkBoxCurrentValue != "1") {
                                setState(() {
                                  checkBoxCurrentValue = "1";
                                  userList = ["Student", "Employee"];
                                });
                              }
                            }),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 12, right: 12, top: 12, bottom: 2),
                    child: Column(
                      children: [
                        Text(
                          'Fee Alert/Restrict Access',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        Checkbox(
                            fillColor: MaterialStateProperty.all(Colors.blue),
                            value: checkBoxCurrentValue == "2" ? true : false,
                            onChanged: (val) {
                              if (checkBoxCurrentValue != "2") {
                                setState(() {
                                  checkBoxCurrentValue = "2";
                                  selectedUser = "Student";
                                  userList = ["Student"];
                                });
                              }
                            }),
                      ],
                    ),
                  ),
                ],
              ),
              //Choose user
              buildDropDownButton(context),
              SizedBox(
                height: 9,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                child: Text(
                  "${selectedUser == "Student" ? "Class :" : "Group :"}",
                  // style: Theme.of(context).textTheme.headline6,
                ),
              ),
              //Class dropDown
              selectedUser == "Student"
                  ? BlocConsumer<ResultAnnounceClassCubit,
                      ResultAnnounceClassState>(
                      listener: (context, state) {
                        if (state is ResultAnnounceClassLoadSuccess) {
                          setState(() {
                            classListMulti = state.classList;
                            // finalClassList = state.classList;
                          });
                        }
                        if (state is ResultAnnounceClassLoadFail) {
                          if (state.failReason == 'false') {
                            UserUtils.unauthorizedUser(context);
                          } else {
                            classListMulti = [];
                          }
                        }
                      },
                      builder: (context, state) {
                        if (state is ResultAnnounceClassLoadInProgress) {
                          return testContainer();
                        } else if (state is ResultAnnounceClassLoadSuccess) {
                          return buildClassMultiSelect(context);
                        } else if (state is ResultAnnounceClassLoadFail) {
                          return buildClassMultiSelect(context);
                        } else {
                          return Container();
                        }
                      },
                    )
                  //buildClassMultiSelect(context)
                  : BlocConsumer<FeeTypeCubit, FeeTypeState>(
                      listener: (context, state) {
                      if (state is FeeTypeLoadSuccess) {
                        setState(() {
                          groupDropDown = state.feeTypes;
                        });
                      }
                      if (state is FeeTypeLoadFail) {
                        if (state.failReason == 'false') {
                          UserUtils.unauthorizedUser(context);
                        } else {
                          groupDropDown = [];
                        }
                      }
                    }, builder: (context, state) {
                      if (state is FeeTypeLoadInProgress) {
                        return testContainer();
                      } else if (state is FeeTypeLoadSuccess) {
                        return buildGroupMultiSelect(context);
                      } else if (state is FeeTypeLoadFail) {
                        return buildGroupMultiSelect(context);
                      } else {
                        return Container();
                      }
                    }),
              //: buildGroupMultiSelect(context),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Text(
                  'Description :',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              SizedBox(
                height: 9,
              ),
              // getToolBar(),
              //quill.QuillToolbar.basic(controller: _controller),
              // buildHtmlEditor(),
              SizedBox(
                height: 5,
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 12),
              //   padding: EdgeInsets.all(6),
              //   decoration: BoxDecoration(
              //     border: Border.all(width: 0.1),
              //   ),
              //   child: QuillEditor.basic(
              //     controller: _controller,
              //     // scrollable: true,
              //     // scrollController: ScrollController(),
              //     // focusNode: editorFocusNode,
              //     // padding: EdgeInsets.all(5),
              //     // autoFocus: false,
              //     readOnly: false,
              //     // expands: false,
              //     // placeholder: "Description",
              //     // maxHeight: 120,
              //   ),
              // ),
              //buildDescriptionTextField(context),
              SizedBox(height: 20),
              checkBoxCurrentValue != "1"
                  ? Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(
                                'Enter Limit For Alert :',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            SizedBox(
                              height: 9,
                            ),
                            buildLimitTextField(context,
                                controller: _limitAlertController),
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(
                                'Enter Limit For Restrict :',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            SizedBox(
                              height: 9,
                            ),
                            buildLimitTextField(context,
                                controller: _limitRestrictController),
                          ],
                        )
                      ],
                    )
                  : Container(),
              SizedBox(
                height: checkBoxCurrentValue == "1" ? 2.0 : 14.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildLabels(label: "From Date"),
                          SizedBox(height: 8),
                          buildDateSelector(
                            index: 0,
                            selectedDate: DateFormat("dd-MMM-yyyy")
                                .format(selectedFromDate),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildLabels(label: "To Date"),
                          SizedBox(height: 8),
                          buildDateSelector(
                            index: 1,
                            selectedDate: DateFormat("dd-MMM-yyyy")
                                .format(selectedToDate),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: buttonLoader == false
                    ? buildSubmitButton(context)
                    : CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget buildHtmlEditor() {
  //   return Column(
  //     children: [
  //       Container(
  //         // height: MediaQuery.of(context).size.height * 0.2,
  //         margin: EdgeInsets.symmetric(horizontal: 10),
  //         child: HtmlEditor(
  //           controller: controller,
  //           htmlEditorOptions: HtmlEditorOptions(
  //             hint: 'Your text here...',
  //             shouldEnsureVisible: true,
  //             //initialText: "<p>text content initial, if any</p>",
  //           ),
  //           htmlToolbarOptions: HtmlToolbarOptions(
  //             toolbarPosition: ToolbarPosition.aboveEditor, //by default
  //             toolbarType: ToolbarType.nativeGrid, //by default
  //             // onButtonPressed:
  //             //     (ButtonType type, bool? status, Function()? updateStatus) {
  //             //   // print(
  //             //   //     "button '${describeEnum(type)}' pressed, the current selected status is $status");
  //             //   return true;
  //             // },
  //             onDropdownChanged: (DropdownType type, dynamic changed,
  //                 Function(dynamic)? updateSelectedItem) {
  //               print("dropdown '${describeEnum(type)}' changed to $changed");
  //               return true;
  //             },
  //             mediaLinkInsertInterceptor: (String url, InsertFileType type) {
  //               print(url);
  //               return true;
  //             },
  //             mediaUploadInterceptor:
  //                 (PlatformFile file, InsertFileType type) async {
  //               print(file.name); //filename
  //               print(file.size); //size in bytes
  //               print(file.extension); //file extension (eg jpeg or mp4)
  //               return true;
  //             },
  //           ),
  //           otherOptions: OtherOptions(height: 350),
  //           // callbacks: Callbacks(onBeforeCommand: (String? currentHtml) {
  //           //   print('html before change is $currentHtml');
  //           // }, onChangeContent: (String? changed) {
  //           //   print('content changed to $changed');
  //           // }, onChangeCodeview: (String? changed) {
  //           //   print('code changed to $changed');
  //           // }, onChangeSelection: (EditorSettings settings) {
  //           //   print('parent element is ${settings.parentElement}');
  //           //   print('font name is ${settings.fontName}');
  //           // }, onDialogShown: () {
  //           //   print('dialog shown');
  //           // }, onEnter: () {
  //           //   print('enter/return pressed');
  //           // }, onFocus: () {
  //           //   print('editor focused');
  //           // }, onBlur: () {
  //           //   print('editor unfocused');
  //           // }, onBlurCodeview: () {
  //           //   print('codeview either focused or unfocused');
  //           // }, onInit: () {
  //           //   print('init');
  //           // },
  //           //this is commented because it overrides the default Summernote handlers
  //           /*onImageLinkInsert: (String? url) {
  //                         print(url ?? "unknown url");
  //                       },
  //                       onImageUpload: (FileUpload file) async {
  //                         print(file.name);
  //                         print(file.size);
  //                         print(file.type);
  //                         print(file.base64);
  //                       },*/
  //           //     onImageUploadError:
  //           //         (FileUpload? file, String? base64Str, UploadError error) {
  //           //   print(describeEnum(error));
  //           //   print(base64Str ?? '');
  //           //   if (file != null) {
  //           //     print(file.name);
  //           //     print(file.size);
  //           //     print(file.type);
  //           //   }
  //           // }, onKeyDown: (int? keyCode) {
  //           //   print('$keyCode key downed');
  //           //   // print(
  //           //   //     'current character count: ${controller.characterCount}');
  //           // }, onKeyUp: (int? keyCode) {
  //           //   print('$keyCode key released');
  //           // }, onMouseDown: () {
  //           //   print('mouse downed');
  //           // }, onMouseUp: () {
  //           //   print('mouse released');
  //           // },
  //           //     // onNavigationRequestMobile: (String url) {
  //           //     //   print(url);
  //           //     //   return NavigationActionPolicy.ALLOW;
  //           //     // },
  //           //     onPaste: () {
  //           //   print('pasted into editor');
  //           // }, onScroll: () {
  //           //   print('editor scrolled');
  //           // }),
  //           // plugins: [
  //           //   SummernoteAtMention(
  //           //       getSuggestionsMobile: (String value) {
  //           //         var mentions = <String>['test1', 'test2', 'test3'];
  //           //         return mentions
  //           //             .where((element) => element.contains(value))
  //           //             .toList();
  //           //       },
  //           //       mentionsWeb: ['test1', 'test2', 'test3'],
  //           //       onSelect: (String value) {
  //           //         print(value);
  //           //       }),
  //           // ],
  //         ),
  //       ),

  //       ///
  //       // Padding(
  //       //   padding: const EdgeInsets.all(8.0),
  //       //   child: Row(
  //       //     mainAxisAlignment: MainAxisAlignment.center,
  //       //     children: <Widget>[
  //       //       TextButton(
  //       //         style: TextButton.styleFrom(backgroundColor: Colors.blueGrey),
  //       //         onPressed: () {
  //       //           controller.undo();
  //       //         },
  //       //         child: Text('Undo', style: TextStyle(color: Colors.white)),
  //       //       ),
  //       //       SizedBox(
  //       //         width: 16,
  //       //       ),
  //       //       TextButton(
  //       //         style: TextButton.styleFrom(backgroundColor: Colors.blueGrey),
  //       //         onPressed: () {
  //       //           controller.clear();
  //       //         },
  //       //         child: Text('Reset', style: TextStyle(color: Colors.white)),
  //       //       ),
  //       //       // SizedBox(
  //       //       //   width: 16,
  //       //       // ),
  //       //       // TextButton(
  //       //       //   style: TextButton.styleFrom(
  //       //       //       backgroundColor: Theme.of(context).accentColor),
  //       //       //   onPressed: () async {
  //       //       //     var txt = await controller.getText();
  //       //       //     if (txt.contains('src=\"data:')) {
  //       //       //       txt =
  //       //       //       '<text removed due to base-64 data, displaying the text could cause the app to crash>';
  //       //       //     }
  //       //       //     setState(() {
  //       //       //       result = txt;
  //       //       //     });
  //       //       //   },
  //       //       //   child: Text(
  //       //       //     'Submit',
  //       //       //     style: TextStyle(color: Colors.white),
  //       //       //   ),
  //       //       // ),
  //       //       SizedBox(
  //       //         width: 16,
  //       //       ),
  //       //       TextButton(
  //       //         style: TextButton.styleFrom(
  //       //             backgroundColor: Theme.of(context).accentColor),
  //       //         onPressed: () {
  //       //           controller.redo();
  //       //         },
  //       //         child: Text(
  //       //           'Redo',
  //       //           style: TextStyle(color: Colors.white),
  //       //         ),
  //       //       ),
  //       //     ],
  //       //   ),
  //       // ),
  //       // // Padding(
  //       // //   padding: const EdgeInsets.all(8.0),
  //       // //   child: Text(result),
  //       // // ),
  //       // Padding(
  //       //   padding: const EdgeInsets.all(8.0),
  //       //   child: Row(
  //       //     mainAxisAlignment: MainAxisAlignment.center,
  //       //     children: <Widget>[
  //       //       TextButton(
  //       //         style: TextButton.styleFrom(backgroundColor: Colors.blueGrey),
  //       //         onPressed: () {
  //       //           controller.disable();
  //       //         },
  //       //         child: Text('Disable', style: TextStyle(color: Colors.white)),
  //       //       ),
  //       //       SizedBox(
  //       //         width: 16,
  //       //       ),
  //       //       TextButton(
  //       //         style: TextButton.styleFrom(
  //       //             backgroundColor: Theme.of(context).accentColor),
  //       //         onPressed: () async {
  //       //           controller.enable();
  //       //         },
  //       //         child: Text(
  //       //           'Enable',
  //       //           style: TextStyle(color: Colors.white),
  //       //         ),
  //       //       ),
  //       //     ],
  //       //   ),
  //       // ),
  //       // SizedBox(height: 16),
  //       // Padding(
  //       //   padding: const EdgeInsets.all(8.0),
  //       //   child: Row(
  //       //     mainAxisAlignment: MainAxisAlignment.center,
  //       //     children: <Widget>[
  //       //       TextButton(
  //       //         style: TextButton.styleFrom(
  //       //             backgroundColor: Theme.of(context).accentColor),
  //       //         onPressed: () {
  //       //           controller.insertText('Google');
  //       //         },
  //       //         child:
  //       //             Text('Insert Text', style: TextStyle(color: Colors.white)),
  //       //       ),
  //       //       SizedBox(
  //       //         width: 16,
  //       //       ),
  //       //       TextButton(
  //       //         style: TextButton.styleFrom(
  //       //             backgroundColor: Theme.of(context).accentColor),
  //       //         onPressed: () {
  //       //           controller.insertHtml(
  //       //               '''<p style="color: blue">Google in blue</p>''');
  //       //         },
  //       //         child:
  //       //             Text('Insert HTML', style: TextStyle(color: Colors.white)),
  //       //       ),
  //       //     ],
  //       //   ),
  //       // ),
  //       // Padding(
  //       //   padding: const EdgeInsets.all(8.0),
  //       //   child: Row(
  //       //     mainAxisAlignment: MainAxisAlignment.center,
  //       //     children: <Widget>[
  //       //       TextButton(
  //       //         style: TextButton.styleFrom(
  //       //             backgroundColor: Theme.of(context).accentColor),
  //       //         onPressed: () async {
  //       //           controller.insertLink(
  //       //               'Google linked', 'https://google.com', true);
  //       //         },
  //       //         child: Text(
  //       //           'Insert Link',
  //       //           style: TextStyle(color: Colors.white),
  //       //         ),
  //       //       ),
  //       //       SizedBox(
  //       //         width: 16,
  //       //       ),
  //       //       TextButton(
  //       //         style: TextButton.styleFrom(
  //       //             backgroundColor: Theme.of(context).accentColor),
  //       //         onPressed: () {
  //       //           controller.insertNetworkImage(
  //       //               'https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png',
  //       //               filename: 'Google network image');
  //       //         },
  //       //         child: Text(
  //       //           'Insert network image',
  //       //           style: TextStyle(color: Colors.white),
  //       //         ),
  //       //       ),
  //       //     ],
  //       //   ),
  //       // ),
  //       // SizedBox(height: 16),
  //       // Padding(
  //       //   padding: const EdgeInsets.all(8.0),
  //       //   child: Row(
  //       //     mainAxisAlignment: MainAxisAlignment.center,
  //       //     children: <Widget>[
  //       //       TextButton(
  //       //         style: TextButton.styleFrom(backgroundColor: Colors.blueGrey),
  //       //         onPressed: () {
  //       //           controller.addNotification(
  //       //               'Info notification', NotificationType.info);
  //       //         },
  //       //         child: Text('Info', style: TextStyle(color: Colors.white)),
  //       //       ),
  //       //       SizedBox(
  //       //         width: 16,
  //       //       ),
  //       //       TextButton(
  //       //         style: TextButton.styleFrom(backgroundColor: Colors.blueGrey),
  //       //         onPressed: () {
  //       //           controller.addNotification(
  //       //               'Warning notification', NotificationType.warning);
  //       //         },
  //       //         child: Text('Warning', style: TextStyle(color: Colors.white)),
  //       //       ),
  //       //       SizedBox(
  //       //         width: 16,
  //       //       ),
  //       //       TextButton(
  //       //         style: TextButton.styleFrom(
  //       //             backgroundColor: Theme.of(context).accentColor),
  //       //         onPressed: () async {
  //       //           controller.addNotification(
  //       //               'Success notification', NotificationType.success);
  //       //         },
  //       //         child: Text(
  //       //           'Success',
  //       //           style: TextStyle(color: Colors.white),
  //       //         ),
  //       //       ),
  //       //       SizedBox(
  //       //         width: 16,
  //       //       ),
  //       //       TextButton(
  //       //         style: TextButton.styleFrom(
  //       //             backgroundColor: Theme.of(context).accentColor),
  //       //         onPressed: () {
  //       //           controller.addNotification(
  //       //               'Danger notification', NotificationType.danger);
  //       //         },
  //       //         child: Text(
  //       //           'Danger',
  //       //           style: TextStyle(color: Colors.white),
  //       //         ),
  //       //       ),
  //       //     ],
  //       //   ),
  //       // ),
  //       // SizedBox(height: 16),
  //       // Padding(
  //       //   padding: const EdgeInsets.all(8.0),
  //       //   child: Row(
  //       //     mainAxisAlignment: MainAxisAlignment.center,
  //       //     children: <Widget>[
  //       //       TextButton(
  //       //         style: TextButton.styleFrom(backgroundColor: Colors.blueGrey),
  //       //         onPressed: () {
  //       //           controller.addNotification(
  //       //               'Plaintext notification', NotificationType.plaintext);
  //       //         },
  //       //         child: Text('Plaintext', style: TextStyle(color: Colors.white)),
  //       //       ),
  //       //       SizedBox(
  //       //         width: 16,
  //       //       ),
  //       //       TextButton(
  //       //         style: TextButton.styleFrom(
  //       //             backgroundColor: Theme.of(context).accentColor),
  //       //         onPressed: () async {
  //       //           controller.removeNotification();
  //       //         },
  //       //         child: Text(
  //       //           'Remove',
  //       //           style: TextStyle(color: Colors.white),
  //       //         ),
  //       //       ),
  //       //     ],
  //       //   ),
  //       // ),
  //     ],
  //   );
  // }

  Container buildDescriptionTextField(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(
        controller: _descController,
        validator: FieldValidators.globalValidator,
        maxLines: 5,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          //counterText: "",
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(18.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffECECEC),
            ),
            gapPadding: 0.0,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffECECEC),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          hintText: "type here",
          hintStyle: TextStyle(color: Color(0xffA5A5A5)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        ),
      ),
    );
  }

  Container buildLimitTextField(BuildContext context,
      {TextEditingController? controller}) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      width: MediaQuery.of(context).size.width * 0.3,
      child: TextFormField(
        controller: controller,
        validator: FieldValidators.globalValidator,
        maxLines: 1,
        maxLength: 8,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          counterText: "",
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(18.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffECECEC),
            ),
            gapPadding: 0.0,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffECECEC),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          hintText: "type here",
          hintStyle: TextStyle(color: Color(0xffA5A5A5)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        ),
      ),
    );
  }

  InkWell buildDateSelector({String? selectedDate, int? index}) {
    return InkWell(
      onTap: () => _selectDate(context, index: index),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 4,
              child: Text(
                selectedDate!,
                overflow: TextOverflow.visible,
                maxLines: 1,
              ),
            ),
            Icon(Icons.today, color: Theme.of(context).primaryColor)
          ],
        ),
      ),
    );
  }

  Widget buildClassMultiSelect(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: MultiSelectBottomSheetField<ResultAnnounceClassModel>(
          autovalidateMode: AutovalidateMode.disabled,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffECECEC)),
          ),
          key: _classSelectKey,
          initialChildSize: 0.7,
          maxChildSize: 0.95,
          title: Text("All Classes/Groups",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18)),
          buttonText: Text(
              "${finalClassList.length > 0 ? "Class Selected : ${finalClassList.length}" : "All Selected"}"),
          items: classListMulti!
              .map((classList) =>
                  MultiSelectItem(classList, classList.className!))
              .toList(),
          searchable: false,
          validator: (values) {
            // _classSelectKey.currentState!.validate();
            // if (finalClassList == null || finalClassList!.isEmpty) {
            //   return "Required";
            // }
            // return null;
          },
          onConfirm: (values) {
            setState(() {
              finalClassList = [];
            });

            values.forEach((element) {
              setState(() {
                finalClassList.add(element.id);
              });
            });
          },
          chipDisplay: MultiSelectChipDisplay.none()
          //   shape: RoundedRectangleBorder(),
          //   textStyle: TextStyle(
          //       fontWeight: FontWeight.w900,
          //       color: Theme.of(context).primaryColor),
          // ),
          ),
    );
  }

  Widget buildGroupMultiSelect(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: MultiSelectBottomSheetField<FeeTypeModel>(
          autovalidateMode: AutovalidateMode.disabled,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffECECEC)),
          ),
          //key: _classSelectKey,
          initialChildSize: 0.7,
          maxChildSize: 0.95,
          title: Text("All Classes/Groups",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18)),
          buttonText: Text(
              "${finalGroupDropDown.length > 0 ? "Group Selected : ${finalGroupDropDown.length}" : "All Selected"}"),
          items: groupDropDown
              .map((classList) =>
                  MultiSelectItem(classList, classList.paramname!))
              .toList(),
          searchable: false,
          validator: (values) {
            // _classSelectKey.currentState!.validate();
            // if (finalClassList == null || finalClassList!.isEmpty) {
            //   return "Required";
            // }
            // return null;
          },
          onConfirm: (values) {
            setState(() {
              finalGroupDropDown = [];
            });
            setState(() {
              values.forEach((element) {
                finalGroupDropDown.add(element.iD);
              });
              //  finalGroupDropDown = values;
            });
          },
          chipDisplay: MultiSelectChipDisplay.none()
          //   shape: RoundedRectangleBorder(),
          //   textStyle: TextStyle(
          //       fontWeight: FontWeight.w900,
          //       color: Theme.of(context).primaryColor),
          // ),
          ),
    );
  }

  Padding buildDropDownButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Choose User :",
              // style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
              // borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<String>(
                isDense: true,
                value: selectedUser,
                key: UniqueKey(),
                isExpanded: true,
                underline: Container(),
                onChanged: (val) {
                  setState(() {
                    selectedUser = val;
                  });
                  if (val == 'Student') {
                    getClassList();
                  } else {
                    getFeeType();
                  }
                },
                items: userList!
                    .map((e) => DropdownMenuItem(
                          child: Text('$e'),
                          value: e,
                        ))
                    .toList()),
          ),
        ],
      ),
    );
  }

  Container buildSubmitButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      child: GestureDetector(
        onTap: () async {
          // print(controller.getText());
          // final txt = await controller.getText();
          final txt = "";
          print(Uri.encodeFull(txt));
          if (txt != "") {
            if (checkBoxCurrentValue == "1") {
              saveMessagePopUp(
                toDate: DateFormat('dd-MMM-yyyy').format(selectedToDate),
                fromDate: DateFormat('dd-MMM-yyyy').format(selectedFromDate),
                classids: selectedUser == "Student"
                    ? finalClassList.length > 0
                        ? finalClassList.join(",")
                        : ""
                    : "",
                groupids: selectedUser == "Student"
                    ? ""
                    : finalGroupDropDown.length > 0
                        ? finalGroupDropDown.join(",")
                        : "",
                // message: _controller.document.toDelta().toString(),
                message: Uri.encodeFull(txt),
              );
            } else {
              if (_limitAlertController.text != "" &&
                  _limitRestrictController.text != "") {
                saveAlertPopUp(
                    toDate: DateFormat('dd-MMM-yyyy').format(selectedToDate),
                    fromDate:
                        DateFormat('dd-MMM-yyyy').format(selectedFromDate),
                    classids: finalClassList.length > 0
                        ? finalClassList.join(",")
                        : "",
                    groupids: "",
                    // message: _controller.document.toDelta().toString(),
                    message: Uri.encodeFull(txt),
                    limit1: _limitAlertController.text,
                    limit2: _limitRestrictController.text);
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(commonSnackBar(title: "Enter Limit"));
              }
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(commonSnackBar(
                title: "Enter Description", duration: Duration(seconds: 1)));
          }
        },
        child: Text(
          "Create Message",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  Text buildLabels({String? label, Color? color}) {
    return Text(
      label!,
      style: TextStyle(
        color: color ?? Color(0xff313131),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Container testContainer() {
    return Container(
      child: Text("All Selected"),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(border: Border.all(width: 0.05)),
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.055,
    );
  }
}
