import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CLASS_END_DRAWER_LOCAL_CUBIT/class_end_drawer_local_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/TEACHERS_LIST_CUBIT/teachers_list_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/teachersListModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ClassesEndDrawer extends StatefulWidget {
  @override
  _ClassesEndDrawerState createState() => _ClassesEndDrawerState();
}

class _ClassesEndDrawerState extends State<ClassesEndDrawer> {
  TeachersListModel? _addAllSelected;

  // ClassRoomsStudent classRoomObject = ClassRoomsStudent();

  // filterClassrooms(TeachersListModel? teacherData) async {
  //   final uid = await UserUtils.idFromCache();
  //   final token = await UserUtils.userTokenFromCache();
  //   final userData = await UserUtils.userTypeFromCache();
  //   final stuInfoData = await UserUtils.stuInfoDataFromCache();
  //   final classData = {
  //     'OUserId': uid,
  //     'Token': token,
  //     'OrgId': userData!.organizationId,
  //     'Schoolid': userData.schoolId,
  //     'SessionId': userData.currentSessionid,
  //     'EmpId': teacherData!.empId,
  //     'SubjectId': teacherData.subjectId,
  //     // 'NoRows': '2',
  //     'NoRows': '20',
  //     'Counts': '0',
  //     'ClassId':
  //         "${stuInfoData!.classId}#${stuInfoData.classSectionId}#${stuInfoData.streamId}#${stuInfoData.yearId}", //'204#1445#204#1',
  //     'StudentId': userData.stuEmpId,
  //     'LastId': 'null',
  //   };
  //   print("sending ClassRoomsStudent WITH Teacher data = > $classData");
  //   context
  //       .read<ClassRoomsStudentCubit>()
  //       .classRoomsStudentCubitCall(classData);
  //   Navigator.pop(context, teacherData);
  // }

  @override
  void initState() {
    super.initState();
  }

  //  BlocListener<TeachersListCubit, TeachersListState>(
  //         listener: (context, state) {
  //           if (state is TeachersListLoadSuccess) {
  //             TeachersListModel? _addAllSelected;
  //             _addAllSelected = TeachersListModel(
  //                 classID: 'null',
  //                 empId: 'null',
  //                 empSub: 'All',
  //                 sectionId: 'null',
  //                 sessionId: 'null',
  //                 streamId: 'null',
  //                 subjectId: '',
  //                 yearId: '');
  //             state.teacherData.insert(0, _addAllSelected);

  //             print("TeachersListLoadSuccess inserted");
  //           }
  //           if (state is TeachersListLoadFail) {
  //           }
  //         },
  //       ),

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      child: Drawer(
        child: Scaffold(
          appBar: AppBar(toolbarHeight: 0.0),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                color: Theme.of(context).primaryColor,
                child: Text(
                  "All Teachers",
                  style: TextStyle(
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              SizedBox(height: 8),
              BlocConsumer<TeachersListCubit, TeachersListState>(
                listener: (context, state) {
                  if (state is TeachersListLoadFail) {
                    if (state.failReason == "false") {
                      UserUtils.unauthorizedUser(context);
                    }
                  }
                },
                builder: (context, state) {
                  if (state is TeachersListLoadInProgress) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is TeachersListLoadSuccess) {
                    return buildTeacherList(context,
                        teacherData: state.teacherData);
                  } else if (state is TeachersListLoadFail) {
                    return buildTeacherList(context);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildTeacherList(BuildContext context,
      {List<TeachersListModel>? teacherData}) {
    if (teacherData![0].empSub != 'All') {
      _addAllSelected = TeachersListModel(
          classID: 'null',
          empId: 'null',
          empSub: 'All',
          sectionId: 'null',
          sessionId: 'null',
          streamId: 'null',
          subjectId: 'null',
          yearId: 'null');
      teacherData.insert(0, _addAllSelected!);
    }
    return Expanded(
      child: Container(
        // margin: const EdgeInsets.all(12.0),
        child: teacherData.isNotEmpty
            ? ListView.separated(
                itemCount: teacherData.length,
                separatorBuilder: (BuildContext context, int index) =>
                    buildDivider(),
                itemBuilder: (context, i) {
                  var item = teacherData[i];
                  return InkWell(
                    onTap: () {
                      context
                          .read<ClassEndDrawerLocalCubit>()
                          .classEndDrawerLocalCubitCall(item);
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Text(
                        item.empSub!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                  // return ListTile(
                  //   title: Text(
                  //     item.itemName ?? "",
                  //     style: TextStyle(
                  //       color: Theme.of(context).primaryColor,
                  //       fontSize: 12,
                  //     ),
                  //   ),
                  //   onTap: () => _onSelected(i),
                  // );
                })
            : Center(child: Text(NO_RECORD_FOUND)),
      ),
    );
  }

  Text buildText({String? title}) {
    return Text(
      title ?? "",
      textScaleFactor: 1.0,
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        // decoration: TextDecoration.underline,
      ),
    );
  }

  Padding buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Divider(color: Colors.grey),
    );
  }
}

class DrawerItem {
  String? itemName;
  String? icon;

  DrawerItem({this.itemName, this.icon});
}
