import 'package:campus_pro/src/CONSTANTS/themeData.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CREATE_USER_EMPLOPYEE_STATUS_CUBIT/create_user_employee_status_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/DELETE_USER_EMPLOYEE_STATUS_CUBIT/delete_user_employee_status_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/EMPLOYEE_INFO_CUBIT/employee_info_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/EMPLOYEE_STATUS_LIST_CUBIT/employee_status_list_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SEND_STUDENT_DETAILS_CUBIT/send_student_details_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/STUDENT_DETAIL_SEARCH_CUBIT/student_detail_search_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/UPDATE_STUDENT_MOBILE_DETAIL_CUBIT/update_student_mobile_no_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/UPDATE_STUDENT_PASSWORD_CUBIT/update_student_password_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/employeeInfoModel.dart';
import 'package:campus_pro/src/DATA/MODELS/employeeStatusListModel.dart';
import 'package:campus_pro/src/DATA/MODELS/searchEmployeeFromRecordsCommonModel.dart';
import 'package:campus_pro/src/DATA/MODELS/studentDetailSearchModel.dart';
import 'package:campus_pro/src/DATA/MODELS/taskManageDummy.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UI/WIDGETS/searchEmployeeFromRecordsCommon.dart';
import 'package:campus_pro/src/UI/WIDGETS/searchStudentFromRecordsCommon.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class EmployeeUserStatus extends StatefulWidget {
  static const routeName = "/employee-user-status";

  const EmployeeUserStatus({Key? key}) : super(key: key);

  @override
  _EmployeeUserStatusState createState() => _EmployeeUserStatusState();
}

class _EmployeeUserStatusState extends State<EmployeeUserStatus> {
  bool activeStatus = false;

  EmployeeInfoModel? selectedEmployee;

  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  bool? selectedType = false;

  List<String> otpList = ["", "", "", "", "", ""];
  List<Data2>? employeeStatusList = [];

  List<ManageUserModel> userRolesList = [
    ManageUserModel(title: "Employee", value: "E", selected: false),
    ManageUserModel(title: "Gate Pass", value: "G", selected: false),
    ManageUserModel(title: "Front Office", value: "O", selected: false),
    ManageUserModel(title: "Wardan", value: "W", selected: false),
    ManageUserModel(title: "Coordinator", value: "C", selected: false),
    ManageUserModel(title: "Library", value: "L", selected: false),
    ManageUserModel(title: "Transport", value: "T", selected: false),
    ManageUserModel(title: "Admin", value: "A", selected: false),
    ManageUserModel(title: "App Manager", value: "M", selected: false),
  ];

  String? uid;
  String? token;
  UserTypeModel? userData;

  String? userId = "";

  @override
  void initState() {
    selectedEmployee = EmployeeInfoModel(
      empId: -1,
      empno: "",
      name: "",
      fatherName: "",
      designation: "",
      grout: "",
      dateOfBirth: "",
      gender: "",
      mobileNo: "",
      department: "",
      sessionID: -1,
      emailid: "",
      groupType: -1,
    );
    getDataFromCache();
    super.initState();
  }

  getDataFromCache() async {
    uid = await UserUtils.idFromCache();
    token = await UserUtils.userTokenFromCache();
    userData = await UserUtils.userTypeFromCache();
  }

  getStatusData() async {
    final empData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData!.schoolId,
      'SessionId': userData!.currentSessionid,
      'EmpId': userData!.stuEmpId,
      'UserType': userData!.ouserType,
      'MobileNo': selectedEmployee!.mobileNo,
    };
    print("Sending StudentDetailSearch Data => $empData");
    context
        .read<EmployeeStatusListCubit>()
        .employeeStatusListCubitCall(empData);
  }

  @override
  void dispose() {
    passwordController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "Employee User Status"),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CreateUserEmployeeStatusCubit,
              CreateUserEmployeeStatusState>(
            listener: (context, state) {
              if (state is CreateUserEmployeeStatusLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is CreateUserEmployeeStatusLoadSuccess) {
                setState(() {
                  otpList = [];
                  employeeStatusList = [];
                  userRolesList.forEach((element) {
                    element.selected = false;
                  });
                });
                getStatusData();
              }
            },
          ),
          BlocListener<DeleteUserEmployeeStatusCubit,
              DeleteUserEmployeeStatusState>(
            listener: (context, state) {
              if (state is DeleteUserEmployeeStatusLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is DeleteUserEmployeeStatusLoadSuccess) {
                setState(() {
                  otpList = [];
                  employeeStatusList = [];
                });
                getStatusData();
              }
            },
          ),
          BlocListener<EmployeeStatusListCubit, EmployeeStatusListState>(
            listener: (context, state) {
              if (state is EmployeeStatusListLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is EmployeeStatusListLoadSuccess) {
                setState(() {
                  otpList = state.employeeStatusList.data1![0].oTP != null &&
                          state.employeeStatusList.data1![0].oTP != -1
                      ? state.employeeStatusList.data1![0].oTP!
                          .toString()
                          .split("")
                          .toList()
                      : ["", "", "", "", "", ""];
                  print("otpList otpList => $otpList");
                  employeeStatusList = state.employeeStatusList.data2;
                });
              }
            },
          ),
          BlocListener<EmployeeInfoCubit, EmployeeInfoState>(
            listener: (context, state) {
              if (state is EmployeeInfoLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is EmployeeInfoLoadSuccess) {
                setState(() {
                  selectedEmployee = state.employeeInfo;
                  passwordController.text = "";
                  mobileController.text = "";
                });
                getStatusData();
              }
            },
          ),
          BlocListener<UpdateStudentPasswordCubit, UpdateStudentPasswordState>(
            listener: (context, state) {
              if (state is UpdateStudentPasswordLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is UpdateStudentPasswordLoadSuccess) {
                setState(() {
                  passwordController.text = "";
                  mobileController.text = "";
                });
                getStatusData();
                ScaffoldMessenger.of(context)
                    .showSnackBar(commonSnackBar(title: "Password Changed"));
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildLabels(label: "Search Employee"),
                    GestureDetector(
                      onTap: () async {
                        final empData = await Navigator.pushNamed(context,
                                SearchEmployeeFromRecordsCommon.routeName)
                            as SearchEmployeeFromRecordsCommonModel;
                        final uid = await UserUtils.idFromCache();
                        final userToken = await UserUtils.userTokenFromCache();
                        final userData = await UserUtils.userTypeFromCache();
                        final employeeData = {
                          "OUserId": uid!,
                          "Token": userToken!,
                          "OrgId": userData!.organizationId!,
                          "Schoolid": userData.schoolId!,
                          "EmpId": userData.stuEmpId!,
                          "SessionId": userData.currentSessionid!,
                          "SearchEmpId": empData.empId,
                          "UserType": userData.ouserType!,
                        };
                        print('Sending Employee Info Data $employeeData');
                        context
                            .read<EmployeeInfoCubit>()
                            .employeeInfoCubitCall(employeeData);
                      },
                      child: Container(
                        // height: 40,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Text("search employee here..."),
                      ),
                    ),
                    if (selectedEmployee!.empId != -1)
                      Container(
                        color: Colors.blue.withOpacity(0.1),
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width - 80,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${selectedEmployee!.empId!} | ${selectedEmployee!.name!}",
                                        style: GoogleFonts.quicksand(
                                          color: Color(0xff3A3A3A),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "M : ${selectedEmployee!.mobileNo!}",
                                        style: GoogleFonts.quicksand(
                                          color: Color(0xff3A3A3A),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedEmployee = EmployeeInfoModel(
                                        empId: -1,
                                        empno: "",
                                        name: "",
                                        fatherName: "",
                                        designation: "",
                                        grout: "",
                                        dateOfBirth: "",
                                        gender: "",
                                        mobileNo: "",
                                        department: "",
                                        sessionID: -1,
                                        emailid: "",
                                        groupType: -1,
                                      );
                                      otpList = ["", "", "", "", "", ""];
                                      userId = "";
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    child:
                                        Icon(Icons.close, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildLabels(label: "Name : "),
                    buildLabels(
                      label: selectedEmployee!.name,
                      color: Colors.grey,
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildLabels(label: "Mobile : "),
                    buildLabels(
                      label: selectedEmployee!.mobileNo,
                      color: Colors.grey,
                    ),
                  ],
                ),
                Divider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildLabels(label: "Last OTP"),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: otpList.length,
                            itemBuilder: (context, i) {
                              var otp = otpList[i];
                              return buildOtpBox(otp);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     buildLabels(label: "All user types"),
                //     Container(
                //       decoration: BoxDecoration(
                //           color: Colors.blue.withOpacity(0.06),
                //           borderRadius: BorderRadius.circular(18.0)),
                //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
                //       child: Row(
                //         children: [
                //           buildLabels(label: "View All"),
                //           SizedBox(width: 8.0),
                //           Icon(Icons.keyboard_arrow_down_outlined),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: 20.0),
                if (selectedEmployee!.empId != -1)
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          children: [
                            Container(
                              color: Colors.blue.withOpacity(0.06),
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              child: Text(
                                "Manage User Types",
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            buildUserRolesGrid(),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  disabledForegroundColor: Theme.of(context).primaryColor.withOpacity(0.38), disabledBackgroundColor: Theme.of(context).primaryColor.withOpacity(0.12)),
                              onPressed: () async {
                                List<String> finalUsers = [];
                                userRolesList.forEach((element) {
                                  if (element.selected!) {
                                    finalUsers.add(element.value!);
                                  }
                                });
                                final newUser = {
                                  'OUserId': uid,
                                  'Token': token,
                                  'OrgId': userData!.organizationId,
                                  'Schoolid': userData!.schoolId,
                                  'SessionId': userData!.currentSessionid,
                                  'EmpId': userData!.stuEmpId,
                                  'UserType': userData!.ouserType,
                                  'MobileNo': selectedEmployee!.mobileNo,
                                  'Name': selectedEmployee!.name,
                                  'SearchEmpId':
                                      selectedEmployee!.empId.toString(),
                                  'GiveUserType': finalUsers.join(","),
                                };
                                print(
                                    "Sending CreateStudentPassword Data => $newUser");
                                context
                                    .read<CreateUserEmployeeStatusCubit>()
                                    .createUserEmployeeStatusCubitCall(newUser);
                              },
                              child: Text('Create'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      // if (selectedStudent!.oLoginId != "")
                      buildChangeTextField(
                        context,
                        iD: 0,
                        controller: passwordController,
                        title: "Change Password",
                        validator: FieldValidators.passwordValidator,
                        onPressed: () async {
                          final passData = {
                            'OUserId': uid,
                            'Token': token,
                            'OStuEmpId': userData!.stuEmpId,
                            'OrgId': userData!.organizationId,
                            'Schoolid': userData!.schoolId,
                            'UserType': userData!.ouserType,
                            'UserId':
                                employeeStatusList!.first.oUserId.toString(),
                            'OLoginId': employeeStatusList!.first.mobileNo,
                            'NewPassword': passwordController.text,
                          };
                          print(
                              "Sending UpdateStudentPassword Data => $passData");
                          context
                              .read<UpdateStudentPasswordCubit>()
                              .updateStudentPasswordCubitCall(passData);
                        },
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          children: [
                            Container(
                              color: Colors.blue.withOpacity(0.06),
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              child: Text(
                                "All Users",
                                style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: employeeStatusList!.length,
                              itemBuilder: (context, i) {
                                return ListTile(
                                  title: Text(
                                    employeeStatusList![i].stuEmpName!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Container(
                                    // color: Colors.green,
                                    child: Text(
                                      employeeStatusList![i].typeName!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  trailing: InkWell(
                                    onTap: () async {
                                      final deleteData = {
                                        'OUserId': uid,
                                        'Token': token,
                                        'OrgId': userData!.organizationId,
                                        'Schoolid': userData!.schoolId,
                                        'SessionId': userData!.currentSessionid,
                                        'EmpId': userData!.stuEmpId,
                                        'UserType': userData!.ouserType,
                                        'DelMobileNo':
                                            employeeStatusList![i].mobileNo,
                                        'DelOUserId': employeeStatusList![i]
                                            .oUserId
                                            .toString(),
                                        'DelName':
                                            employeeStatusList![i].stuEmpName,
                                        'DelUserType':
                                            employeeStatusList![i].oUserType,
                                      };
                                      print(
                                          "Sending DeleteUserEmployeeStatus data => $deleteData");
                                      context
                                          .read<DeleteUserEmployeeStatusCubit>()
                                          .deleteUserEmployeeStatusCubitCall(
                                              deleteData);
                                    },
                                    child:
                                        Icon(Icons.delete, color: Colors.red),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildUserRolesGrid() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: userRolesList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
          childAspectRatio: 3.5,
        ),
        itemBuilder: (context, i) {
          var item = userRolesList[i];
          return InkWell(
            // onTap: () => navigate(item.id),
            onTap: () {},
            child: Container(
              // decoration: BoxDecoration(border: Border.all()),
              child: Row(
                children: [
                  Checkbox(
                    value: item.selected,
                    onChanged: (val) {
                      setState(() {
                        userRolesList[i].selected = val;
                      });
                    },
                  ),
                  Flexible(
                    child: Text(
                      item.title!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      // textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                        color: Color(0xff3A3A3A),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Container buildChangeTextField(
    BuildContext context, {
    int? iD,
    TextEditingController? controller,
    required void Function()? onPressed,
    String? Function(String?)? validator,
    String? title,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Container(
            color: Colors.blue.withOpacity(0.06),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              title!,
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextFormField(
              controller: controller,
              validator: validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              inputFormatters: iD == 1
                  ? [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10)
                    ]
                  : null,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "type here",
                hintStyle: TextStyle(color: Color(0xffA5A5A5)),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                disabledForegroundColor: Theme.of(context).primaryColor.withOpacity(0.38), disabledBackgroundColor: Theme.of(context).primaryColor.withOpacity(0.12)),
            onPressed: onPressed,
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  Container buildOtpBox(String? value) {
    return Container(
      // color: Colors.grey,
      // padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 40,
      width: 30,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          value!,
          textScaleFactor: 1.5,
          style: GoogleFonts.quicksand(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Container buildLabelWithValue({String? heading, String? value}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading!,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 4),
          Text(
            value!,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.black54),
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }

  Padding buildLabels({String? label, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        label!,
        style: GoogleFonts.quicksand(
          color: color ?? Color(0xff3A3A3A),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Padding buildRow({String? title, String? value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title!,
            style: GoogleFonts.quicksand(
              color: Color(0xff777777),
              // color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value!,
            style: GoogleFonts.quicksand(
              color: Color(0xff3A3A3A),
              // color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class ManageUserModel {
  String? title, value;
  bool? selected = false;

  ManageUserModel({this.title, this.value, this.selected});

  @override
  String toString() {
    return "{title: $title, value: $value, selected: $selected}";
  }
}
