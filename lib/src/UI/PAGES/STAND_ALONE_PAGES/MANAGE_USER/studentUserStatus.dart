import 'package:campus_pro/src/DATA/BLOC_CUBIT/CREATE_USER_STUDENT_STATUS_CUBIT/create_user_student_status_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SEND_STUDENT_DETAILS_CUBIT/send_student_details_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/STUDENT_DETAIL_SEARCH_CUBIT/student_detail_search_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/UPDATE_STUDENT_ACCOUNT_STATUS_CUBIT/update_student_account_status_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/UPDATE_STUDENT_MOBILE_DETAIL_CUBIT/update_student_mobile_no_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/UPDATE_STUDENT_PASSWORD_CUBIT/update_student_password_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/searchStudentFromRecordsCommonModel.dart';
import 'package:campus_pro/src/DATA/MODELS/studentDetailSearchModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UI/WIDGETS/searchStudentFromRecordsCommon.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentUserStatus extends StatefulWidget {
  static const routeName = "/student-user-status";

  const StudentUserStatus({Key? key}) : super(key: key);

  @override
  _StudentUserStatusState createState() => _StudentUserStatusState();
}

class _StudentUserStatusState extends State<StudentUserStatus> {
  bool activeStatus = false;

  StudentDetailSearchModel? selectedStudent;

  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  List<String> otpList = ["", "", "", "", "", ""];

  String? uid;
  String? token;
  UserTypeModel? userData;

  String? userId = "";

  @override
  void initState() {
    selectedStudent = StudentDetailSearchModel(
      admNo: '',
      stName: '',
      fatherName: '',
      guardianMobileNo: '',
      ouserName: '',
      oLoginId: '',
      oUserPassword: '',
      oUserType: '',
      isActive: '',
      stuEmpName: '',
      ouserID: '',
      lastOTP: '',
    );
    getDataFromCache();
    super.initState();
  }

  getDataFromCache() async {
    uid = await UserUtils.idFromCache();
    token = await UserUtils.userTokenFromCache();
    userData = await UserUtils.userTypeFromCache();
  }

  refreshStudentData() async {
    final studentData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData!.schoolId,
      'SessionID': userData!.currentSessionid,
      'UserType': 's',
      'StuEmpID': userData!.stuEmpId,
      'StuId': userId,
      'OUserType': userData!.ouserType,
    };
    print("Sending StudentDetailSearch Data => $studentData");
    context
        .read<StudentDetailSearchCubit>()
        .studentDetailSearchCubitCall(studentData);
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
      appBar: commonAppBar(context, title: "Student User Status"),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CreateUserStudentStatusCubit,
              CreateUserStudentStatusState>(
            listener: (context, state) {
              if (state is CreateUserStudentStatusLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is CreateUserStudentStatusLoadSuccess) {
                setState(() {
                  passwordController.text = "";
                  mobileController.text = "";
                });
                refreshStudentData();
              }
            },
          ),
          BlocListener<UpdateStudentAccountStatusCubit,
              UpdateStudentAccountStatusState>(
            listener: (context, state) {
              if (state is UpdateStudentAccountStatusLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is UpdateStudentAccountStatusLoadSuccess) {
                if (state.status) refreshStudentData();
              }
            },
          ),
          BlocListener<UpdateStudentMobileNoCubit, UpdateStudentMobileNoState>(
            listener: (context, state) {
              if (state is UpdateStudentMobileNoLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is UpdateStudentMobileNoLoadSuccess) {
                setState(() {
                  passwordController.text = "";
                  mobileController.text = "";
                });
                refreshStudentData();
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
                FocusScope.of(context).unfocus();
                ScaffoldMessenger.of(context)
                    .showSnackBar(commonSnackBar(title: "Password Updated"));
                refreshStudentData();
              }
            },
          ),
          BlocListener<StudentDetailSearchCubit, StudentDetailSearchState>(
            listener: (context, state) {
              if (state is StudentDetailSearchLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is StudentDetailSearchLoadSuccess) {
                setState(() {
                  passwordController.text = "";
                  mobileController.text = "";
                  selectedStudent = state.studentDetails;
                  if (selectedStudent!.isActive!.toLowerCase() == "y") {
                    activeStatus = true;
                  } else {
                    activeStatus = false;
                  }
                  if (state.studentDetails.lastOTP != "") {
                    otpList = state.studentDetails.lastOTP!.split("").toList();
                    print("otpList otpList => $otpList");
                  }
                });
              }
            },
          ),
          BlocListener<SendStudentDetailsCubit, SendStudentDetailsState>(
            listener: (context, state) {
              if (state is SendStudentDetailsLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is SendStudentDetailsLoadSuccess) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(commonSnackBar(title: 'Send Successfully!'));
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
                    buildLabels(label: "Search Student"),
                    GestureDetector(
                      onTap: () async {
                        final studentData = await Navigator.pushNamed(context,
                                SearchStudentFromRecordsCommon.routeName)
                            as SearchStudentFromRecordsCommonModel;
                        if (studentData.studentid != "") {
                          final data = {
                            'OUserId': uid,
                            'Token': token,
                            'OrgId': userData!.organizationId,
                            'Schoolid': userData!.schoolId,
                            'SessionID': userData!.currentSessionid,
                            'UserType': 's',
                            'StuEmpID': userData!.stuEmpId,
                            'StuId': studentData.studentid,
                            'OUserType': userData!.ouserType,
                          };

                          print(
                              "Sending StudentDetailSearch Data => $studentData");
                          context
                              .read<StudentDetailSearchCubit>()
                              .studentDetailSearchCubitCall(data);
                          setState(() => userId = studentData.studentid);
                        }
                      },
                      child: Container(
                        // height: 40,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Text("search student here..."),
                      ),
                    ),
                    if (selectedStudent!.admNo != "")
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
                                  // color: Colors.green,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${selectedStudent!.admNo!} | ${selectedStudent!.stName!}",
                                        style: GoogleFonts.quicksand(
                                          color: Color(0xff3A3A3A),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "s/o : ${selectedStudent!.fatherName!}\nM : ${selectedStudent!.guardianMobileNo!}",
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
                                      selectedStudent =
                                          StudentDetailSearchModel(
                                        admNo: '',
                                        stName: '',
                                        fatherName: '',
                                        guardianMobileNo: '',
                                        ouserName: '',
                                        oLoginId: '',
                                        oUserPassword: '',
                                        oUserType: '',
                                        isActive: '',
                                        stuEmpName: '',
                                        ouserID: '',
                                        lastOTP: '',
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
                if (selectedStudent!.oLoginId != "")
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "Already Exist.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                        color: Colors.red[300],
                        fontWeight: FontWeight.bold,
                        // fontSize: 16,
                      ),
                    ),
                  ),
                SizedBox(height: 10.0),
                if (selectedStudent!.isActive != "")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildLabels(
                        label: activeStatus ? "Active" : "Inactive",
                        color: activeStatus ? Colors.green : Colors.red,
                      ),
                      Switch(
                        value: activeStatus,
                        activeColor: Colors.green,
                        onChanged: (val) {
                          final statusData = {
                            'OUserId': uid,
                            'Token': token,
                            'OrgId': userData!.organizationId,
                            'Schoolid': userData!.schoolId,
                            'Mobile': selectedStudent!.guardianMobileNo,
                            'UserType': "S",
                            'OUserType': userData!.ouserType,
                            'StuEmpID': userId,
                            'OStuEmpId': userData!.stuEmpId,
                            'Status': val == false ? "N" : "Y",
                          };
                          print(
                              "Sending UpdateStudentAccountStatus data => $statusData");
                          context
                              .read<UpdateStudentAccountStatusCubit>()
                              .updateStudentAccountStatusCubitCall(statusData);
                        },
                      ),
                    ],
                  ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildLabels(label: "Login ID : "),
                    buildLabels(
                      label: selectedStudent!.oLoginId,
                      color: Colors.grey,
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildLabels(label: "Password : "),
                    buildLabels(
                      label: selectedStudent!.oUserPassword != null
                          ? selectedStudent!.oUserPassword
                          : "",
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
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (selectedStudent!.oLoginId != "")
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Color.fromRGBO(250, 196, 47, 1.0),
                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0))),
                            ),
                            onPressed: () async {
                              final details = {
                                'OUserId': uid,
                                'Token': token,
                                'OrgId': userData!.organizationId,
                                'Schoolid': userData!.schoolId,
                                'StuEmpId': userData!.stuEmpId,
                                'SessionId': userData!.currentSessionid,
                                'StudentID': userId,
                                'LoginID': selectedStudent!.oLoginId!,
                                'Password':
                                    selectedStudent!.oUserPassword != null
                                        ? selectedStudent!.oUserPassword
                                        : "",
                                'UserType': userData!.ouserType,
                              };
                              print(
                                  "Sending SendStudentDetails Data => $details");
                              context
                                  .read<SendStudentDetailsCubit>()
                                  .sendStudentDetailsCubitCall(details);
                            },
                            child: Text(
                              "Send Details",
                              style: GoogleFonts.quicksand(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        if (selectedStudent!.oLoginId == "" &&
                            userId != "" &&
                            selectedStudent!.guardianMobileNo != "")
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                Color(0xff2ab57d),
                              )),
                              onPressed: () async {
                                final data = {
                                  "OUserId": uid,
                                  "Token": token,
                                  "OrgId": userData!.organizationId,
                                  "SchoolId": userData!.schoolId,
                                  "SessionId": userData!.currentSessionid,
                                  "UpdatedById": userData!.stuEmpId,
                                  "UserType": 's',
                                  "OUserType": userData!.ouserType,
                                  "StuId": userId,
                                  "MobileNo": selectedStudent!.guardianMobileNo,
                                };
                                context
                                    .read<CreateUserStudentStatusCubit>()
                                    .createUserStudentStatusCubitCall(data);
                              },
                              child: Text(
                                "Create User",
                                style: GoogleFonts.quicksand(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        // ElevatedButton(
                        //   style: ElevatedButton.styleFrom(
                        //     onSurface: Color(0xff2ab57d),
                        //     // primary: Color(0xff2ab57d), // background
                        //     // onPrimary: Colors.white, // foreground
                        //   ),
                        //   onPressed: null,
                        //   child: Text('Send Details'),
                        // ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                if (selectedStudent!.oLoginId != "")
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
                        'UserId': selectedStudent!.ouserID,
                        'OLoginId': selectedStudent!.oLoginId,
                        'NewPassword': passwordController.text,
                      };
                      print("Sending UpdateStudentPassword Data => $passData");
                      context
                          .read<UpdateStudentPasswordCubit>()
                          .updateStudentPasswordCubitCall(passData);
                    },
                  ),
                SizedBox(height: 16.0),
                // if (selectedStudent!.oLoginId != "" && selectedStudent!.oLoginId != null)
                buildChangeTextField(
                  context,
                  iD: 1,
                  controller: mobileController,
                  title: "Change Mobile No",
                  validator: FieldValidators.mobileNoValidator,
                  onPressed: () async {
                    final mobileData = {
                      'OUserId': uid,
                      'Token': token,
                      'OrgId': userData!.organizationId,
                      'Schoolid': userData!.schoolId,
                      'StudentID': userId,
                      'AdmNo': selectedStudent!.admNo,
                      'OldNo': selectedStudent!.guardianMobileNo,
                      'NewNo': mobileController.text,
                      'StuEmpId': userData!.stuEmpId,
                      'UserType': userData!.ouserType,
                    };
                    print("Sending UpdateStudentMobileNo Data => $mobileData");
                    context
                        .read<UpdateStudentMobileNoCubit>()
                        .updateStudentMobileNoCubitCall(mobileData);
                  },
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ), disabledForegroundColor: Theme.of(context).primaryColor.withOpacity(0.38), disabledBackgroundColor: Theme.of(context).primaryColor.withOpacity(0.12),
            ),
            onPressed: onPressed,
            child: Text(
              'Update',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
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
            // style: Theme.of(context).textTheme.headline6,
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
