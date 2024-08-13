import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_ASSIGN_LIST_TASK_MANAGEMENT_CUBIT/get_assign_list_task_management_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_FOLLOWER_LIST_TASK_MANAGEMENT_CUBIT/get_follower_list_task_management_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_TASK_DATA_CUBIT/get_task_data_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/assignFollowerListTaskManagementModel.dart';
import 'package:campus_pro/src/DATA/MODELS/taskManagementDummyModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskManagementDetail extends StatefulWidget {
  static const routeName = "/task-management-detail";
  final String? id;

  const TaskManagementDetail({Key? key, this.id}) : super(key: key);
  @override
  _TaskManagementDetailState createState() => _TaskManagementDetailState();
}

class _TaskManagementDetailState extends State<TaskManagementDetail> {
  List<AssignFollowerListTaskManagementModel>? assignList = [];
  List<AssignFollowerListTaskManagementModel>? followerList = [];

  getFollowerList(
      {String? taskname,
      String? sdate,
      String? ddate,
      String? priority,
      String? status,
      //String? createdid,
      String? folloupids,
      String? assignids}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final data = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "Flag": "GetFollower",
      "Id": widget.id,
      "TaskName": "",
      "StartDate": "",
      "DueDate": "",
      "Priority": "",
      "Status": "",
      "CreatedID": "",
      "FollowUp": "",
      "AssignTo": "",
      "UserType": userData.ouserType,
      "EmpId": userData.stuEmpId,
    };

    print("sending data to get follower list $data");

    context
        .read<GetFollowerListTaskManagementCubit>()
        .getFollowerListTaskManagementCubitData(data);
  }

  getAssignList(
      {String? taskname,
      String? sdate,
      String? ddate,
      String? priority,
      String? status,
      String? folloupids,
      String? assignids}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final data = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "Flag": "GetAssign",
      "Id": widget.id,
      "TaskName": "",
      "StartDate": "",
      "DueDate": "",
      "Priority": "",
      "Status": "",
      "CreatedID": "",
      "FollowUp": "",
      "AssignTo": "",
      "UserType": userData.ouserType,
      "EmpId": userData.stuEmpId,
    };

    print("sending data to get get assign List $data");

    context
        .read<GetAssignListTaskManagementCubit>()
        .getAssignListTaskManagementCubitData(data);
  }

  @override
  void initState() {
    getAssignList();
    getFollowerList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Detail"),
      body: MultiBlocListener(
        listeners: [
          BlocListener<GetFollowerListTaskManagementCubit,
              GetFollowerListTaskManagementState>(listener: (context, state) {
            if (state is GetFollowerListTaskManagementLoadSuccess) {
              setState(() {
                followerList = state.result;
              });
            }
            if (state is GetFollowerListTaskManagementLoadFail) {
              if (state.failReason == "false") {
                UserUtils.unauthorizedUser(context);
              }
            }
          }),
          BlocListener<GetAssignListTaskManagementCubit,
              GetAssignListTaskManagementState>(listener: (context, state) {
            if (state is GetAssignListTaskManagementLoadSuccess) {
              setState(() {
                assignList = state.result;
              });
            }
            if (state is GetAssignListTaskManagementLoadFail) {
              if (state.failReason == "false") {
                UserUtils.unauthorizedUser(context);
              }
            }
          }),
        ],
        child: buildTaskDetailBody(
          context,
        ),
      ),
    );
  }

  Widget buildTaskDetailBody(BuildContext context) {
    return Column(
      children: [
        Text(
          "Assign List",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.55,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: assignList!.length > 0
                ? ListView.builder(
                    itemCount: assignList!.length,
                    itemBuilder: (context, index) {
                      var item = assignList![index];
                      return Container(
                        margin: EdgeInsets.all(4),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.06),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${item.empName}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 6, right: 6, top: 2, bottom: 2),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                    color: item.statusVal == "Pending"
                                        ? Colors.blue
                                        : Colors.green,
                                  ),
                                  child: Text(
                                    item.statusVal!,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Comment Count: ${item.totalComnt}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                                Text(
                                  "Last Updated: ${item.lastUpdated!.split(" ")[0]}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Center(
                    child: Container(
                    child: Text(
                      "No Record",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ))),
        Text(
          "Follower List",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.25,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: followerList!.length > 0
                ? ListView.builder(
                    itemCount: followerList!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Text(
                          "- ${followerList![index].empName}",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Container(
                      child: Text(
                        "No Record",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ))
      ],
    );
  }
}
