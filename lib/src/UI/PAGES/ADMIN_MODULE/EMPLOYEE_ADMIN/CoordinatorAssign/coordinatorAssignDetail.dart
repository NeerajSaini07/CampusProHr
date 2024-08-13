import 'package:campus_pro/src/DATA/BLOC_CUBIT/COORDINATOR_LIST_DETAIL_CUBIT/coordinator_list_detail_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/DELETE_COORDINATOR_CUBIT/delete_coordinator_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/coordinatorListDetailModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/EMPLOYEE_ADMIN/CoordinatorAssign/coordinatorAssignAdd.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoordinatorAssign extends StatefulWidget {
  static const routeName = '/coordinator-assign';
  const CoordinatorAssign({Key? key}) : super(key: key);

  @override
  _CoordinatorAssignState createState() => _CoordinatorAssignState();
}

class _CoordinatorAssignState extends State<CoordinatorAssign> {
  List<CoordinatorListDetailModel>? coordinatorList = [];

  getCoordinatorList() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingDataForCoordinator = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };

    print('sending data for CoordinatorListDetail $sendingDataForCoordinator');

    context
        .read<CoordinatorListDetailCubit>()
        .coordinatorListDetailCubitCall(sendingDataForCoordinator);
  }

  deleteCoordinator({String? empid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingDataForDeleteCoordinator = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "SearchEmpId": empid,
    };

    print(
        'sending data for deleteCoordinator $sendingDataForDeleteCoordinator');

    context
        .read<DeleteCoordinatorCubit>()
        .deleteCoordinatorCubitCall(sendingDataForDeleteCoordinator);
  }

  @override
  void initState() {
    coordinatorList = [];
    getCoordinatorList();
    super.initState();
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1)).then((value) {
      coordinatorList = [];
      getCoordinatorList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'Coordinator Details'),
      floatingActionButton: GestureDetector(
        onTap: () {
          print('Hello');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddCoordinatorAssign();
              },
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).primaryColor,
          ),
          child: Text(
            'Assign Coordinator',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: MultiBlocListener(
          listeners: [
            BlocListener<DeleteCoordinatorCubit, DeleteCoordinatorState>(
                listener: (context, state) {
              if (state is DeleteCoordinatorLoadSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  commonSnackBar(
                    title: 'Coordinator Deleted',
                    duration: Duration(seconds: 1),
                  ),
                );
                getCoordinatorList();
              }
              if (state is DeleteCoordinatorLoadFail) {
                if (state.failReason == 'false') {
                  UserUtils.unauthorizedUser(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    commonSnackBar(
                      title: '${state.failReason}',
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              }
            }),
          ],
          child: Column(
            children: [
              BlocConsumer<CoordinatorListDetailCubit,
                  CoordinatorListDetailState>(
                listener: (context, state) {
                  if (state is CoordinatorListDetailLoadSuccess) {
                    setState(() {
                      coordinatorList = state.coordinatorList;
                    });
                  }
                  if (state is CoordinatorListDetailLoadFail) {
                    if (state.failReason == 'false') {
                      UserUtils.unauthorizedUser(context);
                    } else {
                      setState(() {
                        coordinatorList = [];
                      });
                    }
                  }
                },
                builder: (context, state) {
                  if (state is CoordinatorListDetailLoadInProgress) {
                    // return Center(
                    //   child: Container(
                    //       height: 10,
                    //       width: 10,
                    //       child: CircularProgressIndicator()),
                    // );
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: LinearProgressIndicator(),
                    );
                  }
                  if (state is CoordinatorListDetailLoadSuccess) {
                    return checkList(coordinatorList: coordinatorList);
                  }
                  if (state is CoordinatorListDetailLoadFail) {
                    return checkList(error: state.failReason);
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget checkList(
      {List<CoordinatorListDetailModel>? coordinatorList, String? error}) {
    if (coordinatorList == null || coordinatorList.isEmpty) {
      if (error == null || error.isEmpty) {
        return Center(
          child: Text(
            'Wait',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      } else {
        return Center(
          child: Text(
            '$error',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }
    } else {
      return buildCoordinatorList(coordinatorList: coordinatorList);
    }
  }

  Expanded buildCoordinatorList(
      {List<CoordinatorListDetailModel>? coordinatorList}) {
    return Expanded(
      child: ListView.builder(
        itemCount: coordinatorList!.length,
        itemBuilder: (context, index) {
          var item = coordinatorList[index];
          return Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 0.1)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        '${item.name!.toUpperCase()}',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        //'${item[1].split(' ')[1]} : naman(${item[3]})',
                        'CreatedBy : ${item.createdBy} (${item.createdOn})',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          deleteCoordinator(empid: item.empID.toString());
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        ' UpdatedBy : ${item.updatedBy != "" ? item.updatedBy : ""} (${item.updatedBy != "" ? item.updatedOn : ""})',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
