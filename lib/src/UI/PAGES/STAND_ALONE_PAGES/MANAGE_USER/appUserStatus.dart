import 'package:campus_pro/src/DATA/API_SERVICES/sendSmsForUserStatusApi.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/APP_USER_DETAIL_CUBIT/app_user_detail_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/APP_USER_LIST_CUBIT/app_user_list_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/DOWNLOAD_APP_USER_DATA_CUBIT/download_app_user_data_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/appUserDetailModel.dart';
import 'package:campus_pro/src/DATA/MODELS/appUserListModel.dart';
import 'package:campus_pro/src/DATA/MODELS/downloadAppUserDataModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UI/WIDGETS/noRecordFound.dart';
import 'package:campus_pro/src/UI/WIDGETS/openExcelFile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppUserStatus extends StatefulWidget {
  static const routeName = "/app-user-status";

  const AppUserStatus({Key? key}) : super(key: key);

  @override
  _AppUserStatusState createState() => _AppUserStatusState();
}

class _AppUserStatusState extends State<AppUserStatus> {
  String _selectedType = "S";
  String _selectedStatus = "1";

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
    getAppUserStatusList();
  }

  getAppUserStatusList() async {
    final appData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'SchoolId': userData!.schoolId,
      'SessionId': userData!.currentSessionid,
      'EmpId': userData!.stuEmpId,
      'UserType': userData!.ouserType,
      'STUENTOREMPLOYEE': _selectedType,
    };
    print("Sending AppUserList Data => $appData");
    context.read<AppUserListCubit>().appUserListCubitCall(
        appData, userData!.ouserType! == "c" ? true : false);
  }

  getUserDetails({String? type, String? classId}) async {
    final appData = {
      'UserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'SchoolId': userData!.schoolId,
      'SessionId': userData!.currentSessionid,
      'EmpId': userData!.stuEmpId,
      'UserType': userData!.ouserType,
      'IsActive': type,
      'ClassID': classId,
      'For': _selectedType == "S" ? "S" : "E"
    };
    print("Sending AppUserDetail Data => $appData");
    context.read<AppUserDetailCubit>().appUserDetailCubitCall(appData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "App User Status"),
      bottomNavigationBar: buildBottomBar(),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AppUserDetailCubit, AppUserDetailState>(
            listener: (context, state) {
              if (state is AppUserDetailLoadSuccess) {
                showUsersList(state.appUserDetail);
              }
            },
          ),
          BlocListener<DownloadAppUserDataCubit, DownloadAppUserDataState>(
            listener: (context, state) {
              if (state is DownloadAppUserDataLoadSuccess) {
                print(state.downloadData.length);
                state.downloadData.forEach((element) {
                  print(
                      "excel data getting ${element.admno} ${element.stname} ${element.fatherName} ${element.oLoginid} ${element.ouserpassword}");
                });

                createExcelData(state.downloadData);
              }
            },
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                "Select Type :",
                style: TextStyle(
                  // color: Color(0xff777777),
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Row(
              children: [
                buildRadioText(
                    title: "Student", value: "S", groupValue: _selectedType),
                buildRadioText(
                    title: "Employee", value: "E", groupValue: _selectedType),
              ],
            ),
            Container(
              color: Colors.blue[200],
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: buildHeading(
                        title: _selectedType == "S" ? "Class" : "Employee"),
                  ),
                  buildHeading(title: "Active"),
                  buildHeading(title: "Inactive"),
                  buildHeading(title: "File"),
                ],
              ),
            ),
            BlocConsumer<AppUserListCubit, AppUserListState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is AppUserListLoadInProgress) {
                  // return Center(child: CircularProgressIndicator());
                  return Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: LinearProgressIndicator());
                } else if (state is AppUserListLoadSuccess) {
                  return buildUsersBody(context, state.appUserList);
                } else if (state is AppUserListLoadFail) {
                  return noRecordFound();
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Container buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildRadioText(
              title: "Active", value: "1", groupValue: _selectedStatus),
          buildRadioText(
              title: "InActive", value: "0", groupValue: _selectedStatus),
          TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xff2ab57d))),
            onPressed: () async {
              var data = {
                "OUserId": uid,
                "Token": token,
                "OrgId": userData!.organizationId,
                "SchoolId": userData!.schoolId,
                "SessionId": userData!.currentSessionid,
                "STUENTOREMPLOYEE": _selectedType == "S" ? "S" : "E",
                "UserStatus": _selectedStatus == "1" ? "Y" : "N",
                "EmpId": userData!.stuEmpId,
                "UserType": userData!.ouserType,
              };
              print("Sending data for Send sms for user status $data");
              SendSmsForUserStatusApi().sendSms(data).then((value) {
                try {
                  if (value == "Success") {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(commonSnackBar(title: "SMS Sent"));
                  }
                } catch (e) {}
              });
            },
            child: Text(
              "Send SMS",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Row buildRadioText(
      {String? title, required String value, required String? groupValue}) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: groupValue,
          onChanged: (_) {
            setState(() {
              if (value == "S" || value == "E") {
                _selectedType = value;
                print(_selectedType);
                getAppUserStatusList();
              } else {
                _selectedStatus = value;
              }
            });
          },
        ),
        Text(title!),
      ],
    );
  }

  Expanded buildUsersBody(
      BuildContext context, List<AppUserListModel> appUserList) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemCount: appUserList.length,
        itemBuilder: (context, i) {
          var item = appUserList[i];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: buildLabels(label: item.className),
                ),
                InkWell(
                  onTap: () => getUserDetails(type: "Y", classId: item.classID),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.09,
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    color: Color(0xff2ab57d),
                    child: Center(child: buildLabels(label: item.active)),
                  ),
                ),
                InkWell(
                  onTap: () => getUserDetails(type: "N", classId: item.classID),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.09,
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    color: Colors.red.shade200,
                    child: Center(child: buildLabels(label: item.inActive)),
                  ),
                ),
                _selectedType == "S"
                    ? IconButton(
                        onPressed: () async {
                          final excelData = {
                            'UserId': uid,
                            'Token': token,
                            'OrgId': userData!.organizationId,
                            'SchoolID': userData!.schoolId,
                            'SessionId': userData!.currentSessionid,
                            'EmpId': userData!.stuEmpId,
                            'UserType': userData!.ouserType,
                            'ClassId': item.classID,
                          };
                          print(
                              "Sending DownloadAppUserData data => $excelData");
                          context
                              .read<DownloadAppUserDataCubit>()
                              .downloadAppUserDataCubitCall(excelData);
                        },
                        icon: Icon(
                          Icons.download,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      )
                    : IconButton(
                        splashColor: Colors.transparent,
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_right,
                          color: Colors.transparent,
                        ))
              ],
            ),
          );
        },
      ),
    );
  }

  Container buildHeading({String? title}) {
    return Container(
      child: Text(
        title!,
        style: TextStyle(
          // color: Color(0xff777777),
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget buildLabels({String? label}) {
    return Text(
      label!,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        // color: Theme.of(context).primaryColor,
        fontSize: 16,
        color: Color(0xff313131),
      ),
    );
  }

  showUsersList(List<AppUserDetailModel> appUserDetail) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return UsersList(appUserDetail: appUserDetail);
      },
    );
  }

  createExcelData(List<DownloadAppUserDataModel> excelData) {
    createExcel(headingList: headingList, dataList: excelData);
  }
}

class UsersList extends StatefulWidget {
  final List<AppUserDetailModel>? appUserDetail;

  const UsersList({Key? key, this.appUserDetail}) : super(key: key);
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Colors.blue[200],
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildHeading(title: "Users"),
              buildHeading(title: "Adm No"),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) =>
                Divider(color: Colors.black54),
            itemCount: widget.appUserDetail!.length,
            itemBuilder: (context, i) {
              var user = widget.appUserDetail![i];
              return ListTile(
                title: Text(user.sTUEMPNAME!),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Father's name : ${user.fATHERNAME}",
                        style: TextStyle(fontSize: 12)),
                    Text(user.mOBILENO!, style: TextStyle(fontSize: 12)),
                  ],
                ),
                trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  constraints: BoxConstraints(minWidth: 100.0),
                  child: Text(user.aDMNO!),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Container buildHeading({String? title}) {
    return Container(
      child: Text(
        title!,
        style: TextStyle(
          // color: Color(0xff777777),
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

List<String> headingList = [
  'AdmNO',
  'Name',
  'Father Name',
  'Login Id',
  'Password'
];

List<List<String>> dataList = [
  ["32922", "rohit", "raja", "9098765678", "65678"],
  ['20713', "shiv", "satyabir", '8397053807', '87090'],
  ['6', "sonam", "raj", '8976543210', '43210'],
  ['32922', "rohit", "raja", '9098765678', '65678'],
  ['20713', "shiv", "satyabir", '8397053807', '87090'],
];
