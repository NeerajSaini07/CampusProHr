import 'package:campus_pro/src/DATA/BLOC_CUBIT/CHANGE_OTP_USER_LOGS_CUBIT/change_otp_user_logs_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/OTP_USER_LIST_CUBIT/otp_user_list_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/otpUserListModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UI/WIDGETS/noRecordFound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpStatus extends StatefulWidget {
  static const routeName = "/otp-status";

  const OtpStatus({Key? key}) : super(key: key);

  @override
  _OtpStatusState createState() => _OtpStatusState();
}

class _OtpStatusState extends State<OtpStatus> {
  int activeStatus = 0;

  String? userId = "";

  List<OtpUserListModel> otpUserList = [];

  String? uid;
  String? token;
  UserTypeModel? userData;

  @override
  void initState() {
    getDataFromCache();
    super.initState();
  }

  getDataFromCache() async {
    uid = await UserUtils.idFromCache();
    token = await UserUtils.userTokenFromCache();
    userData = await UserUtils.userTypeFromCache();
    getOtpStatusList(index: 0);
  }

  getOtpStatusList({int? index, OtpUserListModel? otp}) async {
    final otpData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'SchoolID': userData!.schoolId,
      'EmpId': userData!.stuEmpId,
      'UserType': userData!.ouserType,
      'Mode': index == 0 ? "0" : "2",
      'EnableDisabled': index == 0 ? "" : otp!.isActive.toString(),
      'PassWord': "",
      'UserId': index == 0 ? "" : otp!.userId.toString(),
    };
    print("Sending OtpUserList Data => $otpData");
    context
        .read<OtpUserListCubit>()
        .otpUserListCubitCall(otpData, index == 0 ? false : true);
  }

  changeOtpStatus(String? remark) async {
    final otpData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData!.schoolId,
      'EmpId': userData!.stuEmpId,
      'UserType': userData!.ouserType,
      'Remark': remark,
      'UserId': userId,
    };
    print("Sending ChangeOtpUserLogs Data => $otpData");
    context.read<ChangeOtpUserLogsCubit>().changeOtpUserLogsCubitCall(otpData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "OTP Status"),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ChangeOtpUserLogsCubit, ChangeOtpUserLogsState>(
            listener: (context, state) {
              if (state is ChangeOtpUserLogsLoadSuccess) {
                setState(() {
                  activeStatus = 0;
                  userId = "";
                });
              }
            },
          ),
          BlocListener<OtpUserListCubit, OtpUserListState>(
            listener: (context, state) {
              if (state is OtpUserListLoadSuccess) {
                setState(() {
                  if (activeStatus == 1) {
                    activeStatus = 0;
                    changeOtpStatus("User Disabled");
                    // getOtpStatusList(index: 0);
                  } else if (activeStatus == 2) {
                    activeStatus = 0;
                    changeOtpStatus("Show Otp");
                  } else {
                    otpUserList = state.otpUserList;
                  }
                });
              }
            },
          ),
        ],
        child: BlocBuilder<OtpUserListCubit, OtpUserListState>(
          builder: (context, state) {
            if (state is OtpUserListLoadInProgress) {
              return buildOtpStatusBody(context);
            } else if (state is OtpUserListLoadSuccess) {
              return buildOtpStatusBody(context);
            } else if (state is OtpUserListLoadFail) {
              return noRecordFound();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  ListView buildOtpStatusBody(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(color: Colors.black54),
        itemCount: otpUserList.length,
        itemBuilder: (context, i) {
          var otp = otpUserList[i];
          return ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            title: Text("${otp.loginId} - ${otp.userName}"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (otp.designation != "")
                  Card(
                    color: Theme.of(context).colorScheme.secondary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        otp.designation!,
                        style: GoogleFonts.quicksand(color: Colors.white),
                      ),
                    ),
                  ),
                if (otp.oTP != "")
                  Row(
                    children: [
                      Text(
                        otp.showOtp!
                            ? otp.oTP!
                            : "${otp.oTP!.split("")[0]}${otp.oTP!.split("")[1]}${otp.oTP!.split("")[2]}xxx",
                      ),
                      SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          setState(() {
                            otpUserList[i].showOtp = !otp.showOtp!;
                          });
                          if (otp.showOtp!) {
                            setState(() {
                              activeStatus = 2;
                              userId = otpUserList[i].userId!.toString();
                            });
                            changeOtpStatus("Show Otp");
                          }
                        },
                        child: Text(!otp.showOtp! ? "show" : "hide",
                            style: GoogleFonts.quicksand(
                                color: Colors.green,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
              ],
            ),
            trailing: Switch(
              value: otp.isActive == 1 ? true : false,
              activeColor: Colors.green,
              onChanged: (val) {
                if (otp.isActive == 1) {
                  setState(() {
                    otpUserList[i].isActive = 2;
                    activeStatus = 1;
                    userId = otpUserList[i].userId!.toString();
                  });
                } else {
                  setState(() {
                    otpUserList[i].isActive = 1;
                    activeStatus = 1;
                    userId = otpUserList[i].userId!.toString();
                  });
                }
                getOtpStatusList(index: 1, otp: otpUserList[i]);
                // changeOtpStatus("User Disabled");
              },
            ),
          );
        });
  }

  String hideOtp(String otp) {
    final list = otp.split(",");
    final data = "${list[0]}${list[1]}${list[2]}xxx";
    print("data : $data");
    return data;
  }
}
