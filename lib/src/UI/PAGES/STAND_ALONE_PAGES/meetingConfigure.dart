import 'package:campus_pro/src/DATA/BLOC_CUBIT/EMPLOYEE_INFO_FOR_SEARCH_CUBIT/employee_info_for_search_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_EMPLOYEE_ONLINE_CLASS_CRED_CUBIT/get_employee_online_cred_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SET_PLATFORM_CUBIT/set_platform_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/employeeInfoForSearchModel.dart';
import 'package:campus_pro/src/DATA/MODELS/meetingPlatformsModel.dart';
import 'package:campus_pro/src/DATA/MODELS/searchEmployeeFromRecordsCommonModel.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UI/WIDGETS/searchEmployeeFromRecordsCommon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/MEETING_PLATFORMS_CUBIT/meeting_platforms_cubit.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:flutter/material.dart';

class MeetingConfigure extends StatefulWidget {
  static const routeName = "/meeting-configure-admin";
  const MeetingConfigure({Key? key}) : super(key: key);

  @override
  _MeetingConfigureState createState() => _MeetingConfigureState();
}

class _MeetingConfigureState extends State<MeetingConfigure> {
  TextEditingController searchEmployeeController = TextEditingController();
  TextEditingController employeeNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController hostEmailIdController = TextEditingController();
  TextEditingController hostPasswordController = TextEditingController();
  TextEditingController apiKeyController = TextEditingController();
  TextEditingController secreteKeyController = TextEditingController();
  TextEditingController tokenController = TextEditingController();

  List<bool> platFormBool = [false, false, false, false, false, false];
  List<String> platFormValues = [
    "Zoom",
    "Google Meet",
    "Microsoft Teams",
    "Jio Meeting",
    "Vidoly",
    "Cisco WebEx"
  ];

  String selectedMode = "0";

  //platform
  //SetPlateformModel? selectedPlatFormStudent;
  //Todo:use
  String selectedPlatFormStudent = "CampusPro App";
  List selectedPlatFormStudentList = [
    'CampusPro App',
    'Zoom/Meet PlatForm',
  ];

  String selectedPlatFormEmployee = "CampusPro App";
  List selectedPlatFormEmployeeList = [
    'CampusPro App',
    'Zoom/Meet PlatForm',
  ];

  // String selectedPlatform = 'Select Platform';
  // List<String> platformDropdown = ['Select Platform', 'Zoom', 'Google Meet'];

  EmployeeInfoForSearchModel? selectedEmployee;

  MeetingPlatformsModel? _selectedPlatform;
  List<MeetingPlatformsModel>? platformDropDown = [];

  getMeetingPlatforms() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingDataForMeeting = await UserUtils.userTypeFromCache();
    final platformData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData.schoolId,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };
    print("Sending Meeting Platform Data => $platformData");
    context
        .read<MeetingPlatformsCubit>()
        .meetingPlatformsCubitCall(platformData);
  }

  getEmployeeOnlineClass(
      {String? platformid,
      String? apikey,
      String? secretkey,
      String? jwttoken,
      String? emial,
      String? pass,
      String? mode,
      String? empidSearch}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingDataForGetClass = {
      "UserId": uid,
      "Token": token,
      "OrgID": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "PlateformID": platformid != null ? platformid : "",
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "APIKEY": apikey == null ? "" : apikey,
      "SECRETEKEY": secretkey != null ? secretkey : "",
      "JWTTOKEN": jwttoken != null ? jwttoken : "",
      "HostEmail": emial != null ? emial : "",
      "HostPass": pass != null ? pass : "",
      "Mode": mode != null ? mode : "",
      "SearchEmpId": empidSearch != null ? empidSearch : "",
    };

    print(
        'sending data for get employee sms meeting config $sendingDataForGetClass');
    context
        .read<GetEmployeeOnlineCredCubit>()
        .getEmployeeOnlineCredCubitCall(sendingDataForGetClass, mode!);
  }

  setPlatform({String? ddlstudent, String? ddlemployee, String? mode}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final setPlatformValue = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "ddlStudent": ddlstudent != null ? ddlstudent : "",
      "ddlEmp": ddlemployee != null ? ddlemployee : "",
      "Mode": mode,
    };

    print('sending data for set platform $setPlatformValue');

    context.read<SetPlatformCubit>().setPlatformCubitCall(setPlatformValue);
  }

  @override
  void initState() {
    super.initState();
    _selectedPlatform = MeetingPlatformsModel(plateformid: -1, name: "");
    platformDropDown = [];
    getMeetingPlatforms();
  }

  @override
  void dispose() {
    searchEmployeeController.dispose();
    employeeNameController.dispose();
    phoneController.dispose();
    hostEmailIdController.dispose();
    hostPasswordController.dispose();
    apiKeyController.dispose();
    secreteKeyController.dispose();
    tokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "Meeting Configure"),
      body: MultiBlocListener(
        listeners: [
          BlocListener<EmployeeInfoForSearchCubit, EmployeeInfoForSearchState>(
            listener: (context, state) {
              if (state is EmployeeInfoForSearchLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is EmployeeInfoForSearchLoadSuccess) {
                setState(() {
                  selectedEmployee = state.employeeInfoData;
                });
                setState(() {
                  selectedMode = "0";
                });

                getEmployeeOnlineClass(
                  mode: selectedMode,
                  empidSearch: selectedEmployee!.empId.toString(),
                  platformid: _selectedPlatform!.plateformid.toString(),
                );
              }
            },
          ),
          BlocListener<GetEmployeeOnlineCredCubit, GetEmployeeOnlineCredState>(
              listener: (context, state) {
            if (state is GetEmployeeOnlineCredLoadSuccess) {
              setState(() {
                if (selectedMode == "0") {
                  employeeNameController.text = state.result[0].name;
                  phoneController.text = state.result[0].mobileNo;
                  hostEmailIdController.text = state.result[0].hostEmail;
                  hostPasswordController.text = state.result[0].hostPass;
                  apiKeyController.text = state.result[0].aPIKEY;
                  secreteKeyController.text = state.result[0].aPISECRET;
                  tokenController.text = state.result[0].jWtToken;
                } else {
                  setState(() {
                    employeeNameController.text = "";
                    phoneController.text = "";
                    hostEmailIdController.text = "";
                    hostPasswordController.text = "";
                    apiKeyController.text = "";
                    secreteKeyController.text = "";
                    tokenController.text = "";
                    selectedEmployee = null;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    commonSnackBar(
                      title: 'Saved',
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              });
            }
            if (state is GetEmployeeOnlineCredLoadFail) {
              if (state.failReason == 'false') {
                UserUtils.unauthorizedUser(context);
              } else {}
            }
          }),
          BlocListener<SetPlatformCubit, SetPlatformState>(
              listener: (context, state) {
            if (state is SetPlatformLoadFail) {
              if (state.failReason == 'false') {
                UserUtils.unauthorizedUser(context);
              }
            }
            if (state is SetPlatformLoadSuccess) {
              if (state.result != 'Success') {
                print(state.result[0].empJoinOnPlatformApp);
                setState(() {
                  selectedPlatFormEmployee =
                      state.result[0].empJoinOnPlatformApp == 0
                          ? selectedPlatFormEmployeeList[0]
                          : selectedPlatFormEmployeeList[1];
                  selectedPlatFormStudent =
                      state.result[0].stuJoinOnPlatformApp == 0
                          ? selectedPlatFormStudentList[0]
                          : selectedPlatFormStudentList[1];
                });
                buildSetPlatForm(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  commonSnackBar(
                    title: 'Meeting Saved',
                    duration: Duration(seconds: 1),
                  ),
                );
              }
            }
          }),
        ],
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLabels("Meeting Platform"),
                buildPlatformDropdown(context),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildLabels("Search Employee"),
                    GestureDetector(
                      onTap: () async {
                        var employeeData = await Navigator.pushNamed(context,
                                SearchEmployeeFromRecordsCommon.routeName)
                            as SearchEmployeeFromRecordsCommonModel;

                        final uid = await UserUtils.idFromCache();
                        final token = await UserUtils.userTokenFromCache();
                        final userData = await UserUtils.userTypeFromCache();

                        if (employeeData.empId! != "") {
                          final data = {
                            "OUserId": uid!,
                            "Token": token!,
                            "OrgId": userData!.organizationId!,
                            "Schoolid": userData.schoolId!,
                            "EmployeeId": employeeData.empId!,
                            "SessionId": userData.currentSessionid!,
                            "StuEmpId": userData.stuEmpId!,
                            "UserType": userData.ouserType!,
                          };
                          print("Sending EmployeeInfoForSearch Data => $data");
                          context
                              .read<EmployeeInfoForSearchCubit>()
                              .employeeInfoForSearchCubitCall(data);
                        }
                      },
                      child: Container(
                        // height: 40,
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Text("search employee here..."),
                      ),
                    ),
                    SizedBox(
                      height: selectedEmployee != null ? 2 : 7,
                    ),
                    if (selectedEmployee != null)
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Text(
                            "● ${selectedEmployee!.name!} - ${selectedEmployee!.mobileNo!}",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor)),
                      ),
                  ],
                ),
                // buildLabels("Search Employee"),
                // buildTextField(
                //   controller: searchEmployeeController,
                //   validator: FieldValidators.globalValidator,
                // ),
                buildLabels("Employee Name"),
                buildTextField(
                  controller: employeeNameController,
                  //  validator: FieldValidators.globalValidator,
                ),
                SizedBox(
                  height: 7,
                ),
                buildLabels("Mobile No"),
                buildTextField(
                  controller: phoneController,
                  //  validator: FieldValidators.mobileValidator,
                ),
                SizedBox(
                  height: 7,
                ),
                buildLabels("Host Email ID"),
                buildTextField(
                  controller: hostEmailIdController,
                  //validator: FieldValidators.globalValidator,
                ),
                SizedBox(
                  height: 7,
                ),
                buildLabels("Host Password"),
                buildTextField(
                  controller: hostPasswordController,
                  // validator: FieldValidators.passwordValidator,
                ),
                SizedBox(
                  height: 7,
                ),
                buildLabels("API KEY"),
                buildTextField(
                  controller: apiKeyController,
                  //validator: FieldValidators.globalValidator,
                ),
                SizedBox(
                  height: 7,
                ),
                buildLabels("SECRETE KEY"),
                buildTextField(
                  controller: secreteKeyController,
                  //validator: FieldValidators.globalValidator,
                ),
                SizedBox(
                  height: 7,
                ),
                buildLabels("TOKEN"),
                buildTextField(
                  controller: tokenController,
                  // validator: FieldValidators.globalValidator,
                  maxLines: 5,
                ),
                // SizedBox(height: 20),
                Center(child: buildSearchButton()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      buildButton(title: "Save"),
                      SizedBox(width: 12.0),
                      buildButton(title: "Reset"),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildPlatformDropdown(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          BlocConsumer<MeetingPlatformsCubit, MeetingPlatformsState>(
            listener: (context, state) {
              if (state is MeetingPlatformsLoadSuccess) {
                setState(() {
                  _selectedPlatform = state.platformList[0];
                  platformDropDown = state.platformList;
                });
              }
              if (state is MeetingPlatformsLoadFail) {
                if (state.failReason == 'false') {
                  UserUtils.unauthorizedUser(context);
                } else {
                  _selectedPlatform =
                      MeetingPlatformsModel(plateformid: -1, name: "");
                  platformDropDown = [];
                }
              }
            },
            builder: (context, state) {
              if (state is MeetingPlatformsLoadInProgress) {
                return buildMeetingDropDown();
              } else if (state is MeetingPlatformsLoadSuccess) {
                return buildMeetingDropDown();
              } else if (state is MeetingPlatformsLoadFail) {
                return buildMeetingDropDown();
              } else {
                return Container();
              }
            },
          ),
          // IconButton(
          //   // splashColor: Colors.transparent,
          //   onPressed: () {
          //     buildShowDialog(context);
          //   },
          //   icon: Icon(Icons.add_box,
          //       size: 40, color: Theme.of(context).primaryColor),
          // ),
        ],
      ),
    );
  }

  Expanded buildMeetingDropDown() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffECECEC)),
          // borderRadius: BorderRadius.circular(4),
        ),
        child: DropdownButton<MeetingPlatformsModel>(
          isDense: true,
          value: _selectedPlatform,
          key: UniqueKey(),
          isExpanded: true,
          underline: Container(),
          items: platformDropDown!
              .map(
                (item) => DropdownMenuItem<MeetingPlatformsModel>(
                    child: Text(
                      '${item.name}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    value: item),
              )
              .toList(),
          onChanged: (val) {
            setState(() {
              _selectedPlatform = val!;
              print("selectedPlatform: $val");
            });
          },
        ),
      ),
    );
  }

  Future<dynamic> buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          // return Column(
          //   children: [
          //     Center(
          //       child: Text(
          //         'Add Meeting Platform',
          //         style: TextStyle(
          //           fontWeight: FontWeight.w600,
          //           fontSize: 20,
          //         ),
          //       ),
          //     ),
          //     Expanded(
          //       child: ListView.builder(
          //           shrinkWrap: true,
          //           itemCount: platFormBool.length,
          //           itemBuilder: (BuildContext context, index) {
          //             return CheckboxListTile(
          //               value: platFormBool[index],
          //               title: Text('${platFormValues[index]}'),
          //               onChanged: (val) {
          //                 setState(() {
          //                   platFormBool[index] = val!;
          //                 });
          //               },
          //             );
          //           }),
          //     )
          //   ],
          // );
          return AlertDialog(
            elevation: 20,
            title: Center(
              child: Text(
                'Add Meeting Platform',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
            content: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              // height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Expanded(
                  //   child: ListView.builder(
                  //       shrinkWrap: true,
                  //       itemCount: platFormBool.length,
                  //       itemBuilder: (BuildContext _, index) {
                  //         return CheckboxListTile(
                  //           value: platFormBool[index],
                  //           title: Text('${platFormValues[index]}'),
                  //           onChanged: (val) {
                  //             setState(() {
                  //               platFormBool[index] = val!;
                  //             });
                  //             Navigator.pop(context);
                  //             buildShowDialog(context);
                  //           },
                  //         );
                  //       }),
                  // )

                  CheckboxListTile(
                    value: platFormBool[0],
                    title: Text('Google Meet'),
                    onChanged: (val) {
                      setState(() {
                        platFormBool[0] = val!;
                      });
                      Navigator.pop(context);
                      buildShowDialog(context);
                    },
                  ),

                  CheckboxListTile(
                    value: platFormBool[1],
                    title: Text('Microsoft Teams'),
                    onChanged: (val) {
                      setState(() {
                        platFormBool[1] = val!;
                      });
                      Navigator.pop(context);
                      buildShowDialog(context);
                    },
                  ),
                  CheckboxListTile(
                    value: platFormBool[2],
                    title: Text('Jio Meeting'),
                    onChanged: (val) {
                      setState(() {
                        platFormBool[2] = val!;
                      });
                      Navigator.pop(context);
                      buildShowDialog(context);
                    },
                  ),
                  CheckboxListTile(
                    value: platFormBool[3],
                    title: Text('Vidoly'),
                    onChanged: (val) {
                      setState(() {
                        platFormBool[3] = val!;
                      });
                      Navigator.pop(context);
                      buildShowDialog(context);
                    },
                  ),
                  CheckboxListTile(
                    value: platFormBool[4],
                    title: Text('Zoom'),
                    onChanged: (val) {
                      setState(() {
                        platFormBool[4] = val!;
                      });
                      Navigator.pop(context);
                      buildShowDialog(context);
                    },
                  ),
                  CheckboxListTile(
                    value: platFormBool[5],
                    title: Text('Cisco WebEx'),
                    onChanged: (val) {
                      setState(() {
                        platFormBool[5] = val!;
                      });
                      Navigator.pop(context);
                      buildShowDialog(context);
                    },
                  ),
                ],
              ),
            ),
            actions: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    print(platFormBool);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 0.1),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Expanded buildButton({String? title}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (title == "Save") {
            if (selectedEmployee != null) {
              setState(() {
                selectedMode = "1";
              });
              getEmployeeOnlineClass(
                mode: selectedMode,
                empidSearch: selectedEmployee!.empId.toString(),
                platformid: _selectedPlatform!.plateformid.toString(),
                emial: hostEmailIdController.text,
                pass: hostPasswordController.text,
                apikey: apiKeyController.text,
                secretkey: secreteKeyController.text,
                jwttoken: tokenController.text,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                commonSnackBar(
                  title: 'Enter Employee First',
                  duration: Duration(seconds: 1),
                ),
              );
            }
          } else {
            setState(() {
              employeeNameController.text = "";
              phoneController.text = "";
              hostEmailIdController.text = "";
              hostPasswordController.text = "";
              apiKeyController.text = "";
              secreteKeyController.text = "";
              tokenController.text = "";
              selectedEmployee = null;
            });
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Center(
            child: Text(
              title!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector buildSearchButton() {
    return GestureDetector(
      onTap: () {
        setPlatform(mode: "0");
        //buildSetPlatForm(context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        padding: EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Center(
          child: Text(
            "Set Platform",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> buildSetPlatForm(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                elevation: 20,
                title: Center(
                  child: Text(
                    'Set User PlatForm',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
                content: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  // height: MediaQuery.of(context).size.height * 0.6,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'For Employee',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffECECEC)),
                          // borderRadius: BorderRadius.circular(4),
                        ),
                        child: DropdownButton<String>(
                          //isExpanded: true,
                          underline: Container(),
                          isDense: true,
                          items: selectedPlatFormEmployeeList
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          value: selectedPlatFormEmployee,
                          onChanged: (val) {
                            setState(() {
                              selectedPlatFormEmployee = val!;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'For Student',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffECECEC)),
                          // borderRadius: BorderRadius.circular(4),
                        ),
                        child: DropdownButton<String>(
                          //isExpanded: true,
                          underline: Container(),
                          isDense: true,
                          items: selectedPlatFormStudentList
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          value: selectedPlatFormStudent,
                          onChanged: (val) {
                            setState(() {
                              selectedPlatFormStudent = val!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        setPlatform(
                            mode: "1",
                            ddlemployee:
                                selectedPlatFormEmployee == "CampusPro App"
                                    ? "0"
                                    : "1",
                            ddlstudent:
                                selectedPlatFormStudent == "CampusPro App"
                                    ? "0"
                                    : "1");
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 8, bottom: 8),
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 0.1),
                        ),
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        });
  }

  Padding buildLabels(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Text(
        label,
        style: TextStyle(
          // color: Theme.of(context).primaryColor,
          color: Color(0xff313131),
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Container buildTextField({
    int? maxLines = 1,
    String? Function(String?)? validator,
    @required TextEditingController? controller,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        // obscureText: !obscureText ? false : true,
        maxLines: maxLines,
        controller: controller,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
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
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
          // suffixIcon: suffixIcon
          //     ? InkWell(
          //         onTap: () {
          //           setState(() {
          //             _showPassword = !_showPassword;
          //           });
          //         },
          //         child: !_showPassword
          //             ? Icon(Icons.remove_red_eye_outlined)
          //             : Icon(Icons.remove_red_eye),
          //       )
          //     : null,
        ),
      ),
    );
  }
}
