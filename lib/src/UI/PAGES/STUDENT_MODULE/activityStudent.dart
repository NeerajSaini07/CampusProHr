import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/ACTIVITY_FOR_STUDENT_CUBIT/activity_for_student_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/activityForStudentModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/fileDownloader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityStudent extends StatefulWidget {
  static const routeName = '/activity-Student-';
  const ActivityStudent({Key? key}) : super(key: key);

  @override
  _ActivityStudentState createState() => _ActivityStudentState();
}

class _ActivityStudentState extends State<ActivityStudent> {
  int index = 0;
  String? url;

  List<ActivityForStudentModel>? studentList = [];

  getActivity({String? filterType}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final stuInfo = await UserUtils.stuInfoDataFromCache();

    final sendingActivityData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "StudentId": userData.stuEmpId,
      "ClassId": stuInfo!.classId,
      "SectionId": stuInfo.classSectionId,
      "UserType": "S",
      "Filter": filterType,
    };

    print('sending data for activity $sendingActivityData');

    context
        .read<ActivityForStudentCubit>()
        .activityForStudentCubitCall(sendingActivityData);
  }

  getImageUrl() async {
    final userData = await UserUtils.userTypeFromCache();
    setState(() {
      url = userData!.baseDomainURL;
    });
  }

  @override
  void initState() {
    getActivity(filterType: '1');
    getImageUrl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'Activity'),
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          buildIndexSelect(),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 5,
          ),
          SizedBox(
            height: 10,
          ),
          BlocConsumer<ActivityForStudentCubit, ActivityForStudentState>(
            listener: (context, state) {
              if (state is ActivityForStudentLoadSuccess) {
                setState(() {
                  studentList = [];
                });
                setState(() {
                  studentList = state.activityList;
                });
              }
              if (state is ActivityForStudentLoadFail) {
                if (state.failReason == 'false') {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    studentList = [];
                  });
                }
              }
            },
            builder: (context, state) {
              if (state is ActivityForStudentLoadInProgress) {
                // return Container(
                //     height: 10, width: 10, child: CircularProgressIndicator());
                return LinearProgressIndicator();
              } else if (state is ActivityForStudentLoadSuccess) {
                return checkList(activityList: state.activityList);
              } else if (state is ActivityForStudentLoadFail) {
                return checkList(failReason: state.failReason);
              } else {
                return Container();
              }
            },
          )
        ],
      ),
    );
  }

  Widget checkList(
      {List<ActivityForStudentModel>? activityList, String? failReason}) {
    if (activityList == null || activityList.isEmpty) {
      if (failReason == null || failReason.isEmpty) {
        return Center(
          child: Container(
            child: Text('Wait'),
          ),
        );
      } else {
        return Center(
          child: Container(
            child: Text(
              '$failReason',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }
    } else {
      return buildActivityList(activityList: activityList);
    }
  }

  Widget buildActivityList({List<ActivityForStudentModel>? activityList}) {
    return Expanded(
      child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 10.0),
          itemCount: activityList!.length,
          itemBuilder: (context, i) {
            var item = activityList[i];
            return Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffE1E3E8),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Title : ${item.title!}',
                        style: commonStyleForText.copyWith(
                          fontWeight: FontWeight.w600,
                        )),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Content : ${item.htmlContent!}',
                      style: commonStyleForText,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        item.circularFileUrl != ""
                            ? FileDownload(
                                fileUrl: "$url" + item.circularFileUrl!,
                                downloadWidget: Icon(
                                  Icons.download_outlined,
                                  color: Theme.of(context).primaryColor,
                                ),
                                fileName: item.circularFileUrl!.split('.').last,
                              )
                            : Container(),
                        Text(
                          item.dateAdded!,
                          style: TextStyle(
                            fontSize: 11.0,
                          ),
                        ),
                      ],
                    )
                  ],
                ));
          }),
    );
  }

  Container buildIndexSelect() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  if (index != 0) {
                    setState(() {
                      index = 0;
                    });
                    getActivity(filterType: '1');
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(4),
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.3),
                    shape: BoxShape.circle,
                    color: index == 0 ? Colors.blueAccent : Colors.white,
                  ),
                  child: Text(''),
                ),
              ),
              Text(
                'My School',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  if (index != 1) {
                    setState(() {
                      index = 1;
                    });
                    getActivity(filterType: '2');
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(4),
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.3),
                    shape: BoxShape.circle,
                    color: index == 1 ? Colors.blueAccent : Colors.white,
                  ),
                  child: Text(''),
                ),
              ),
              Text(
                'My Class',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  if (index != 2) {
                    setState(() {
                      index = 2;
                    });
                    getActivity(filterType: '3');
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(4),
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.3),
                    shape: BoxShape.circle,
                    color: index == 2 ? Colors.blueAccent : Colors.white,
                  ),
                  child: Text(''),
                ),
              ),
              Text(
                'Me only',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
