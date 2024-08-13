import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CLASSROOMS_STUDENT_CUBIT/classrooms_student_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CLASS_END_DRAWER_LOCAL_CUBIT/class_end_drawer_local_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SEND_CUSTOM_CLASSROOM_COMMENT_CUBIT/send_custom_class_room_comment_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/TEACHERS_LIST_CUBIT/teachers_list_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/classRoomsStudentModel.dart';
import 'package:campus_pro/src/DATA/MODELS/studentInfoModel.dart';
import 'package:campus_pro/src/DATA/MODELS/teachersListModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/chatRoomCommon.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/contactList.dart';
import 'package:campus_pro/src/UI/WIDGETS/classEndDrawer.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UI/WIDGETS/fileDownloader.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class ClassRoomsStudent extends StatefulWidget {
  static const routeName = "/classrooms-student";

  const ClassRoomsStudent({Key? key}) : super(key: key);
  @override
  _ClassRoomsStudentState createState() => _ClassRoomsStudentState();
}

class _ClassRoomsStudentState extends State<ClassRoomsStudent> {
  ScrollController _scrollController = new ScrollController();

  final _drawerKey = GlobalKey<ScaffoldState>();

  TeachersListModel? teacherSelected;

  String selectedTeacher = "All";

  List<StudentInfoModel>? stuData = [];

  bool showLoader = false;
  bool isLoading = false;
  List<ClassRoomsStudentModel> classrommCustomList = [];

  @override
  void initState() {
    teacherSelected = TeachersListModel(
        classID: 'null',
        empId: 'null',
        empSub: 'All',
        sectionId: 'null',
        sessionId: 'null',
        streamId: 'null',
        subjectId: 'null',
        yearId: 'null');
    getClassTeachers();
    showLoader = true;
    // getClassrooms();
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     print('Fetching More ClassRoom Data');
    //     filterClassrooms();
    //     // getClassrooms();
    //   }
    // });
    super.initState();
  }

  getClassTeachers() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final stuInfoData = await UserUtils.stuInfoDataFromCache();
    final teacherData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData.schoolId!,
      'SessionId': userData.currentSessionid!,
      'StudentId': userData.stuEmpId,
      'ClassId': stuInfoData!.classId, //'204',
      'SectionId': stuInfoData.classSectionId, //'1445',
      'StreamId': stuInfoData.streamId, //'204',
      'YearId': stuInfoData.yearId, //'1',
    };
    print("teacher sending = > $teacherData");
    context.read<TeachersListCubit>().teachersListCubitCall(teacherData);
  }

  // getClassrooms() async {
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
  //     'EmpId': 'null',
  //     'SubjectId': 'null',
  //     // 'NoRows': '5',
  //     'NoRows': '20',
  //     'Counts': '0',
  //     'ClassId':
  //         "${stuInfoData!.classId}#${stuInfoData.classSectionId}#${stuInfoData.streamId}#${stuInfoData.yearId}", //'204#1445#204#1',
  //     'StudentId': userData.stuEmpId,
  //     'LastId': 'null',
  //   };
  //   print("sending ClassRoomsStudent data = > $classData");
  //   context
  //       .read<ClassRoomsStudentCubit>()
  //       .classRoomsStudentCubitCall(classData);
  // }

  filterClassrooms(bool isLoadMore) async {
    print('filterClassrooms working : ${teacherSelected!.empSub}');
    setState(() {
      if (!isLoadMore) classrommCustomList = [];
      selectedTeacher = teacherSelected!.empSub!.split("-")[0];
    });
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final stuInfoData = await UserUtils.stuInfoDataFromCache();
    final classData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData.schoolId,
      'SessionId': userData.currentSessionid,
      'UserType': userData.ouserType,
      'EmpId': teacherSelected!.empId,
      'SubjectId': teacherSelected!.subjectId,
      // 'NoRows': '2',
      'NoRows': '20',
      'Counts': classrommCustomList.length > 0
          ? classrommCustomList.length.toString()
          : '0',
      'ClassId':
          "${stuInfoData!.classId}#${stuInfoData.streamId}#${stuInfoData.classSectionId}#${stuInfoData.yearId}", //'204#1445#204#1',
      'StudentId': userData.stuEmpId,
      'LastId': 'null',
    };
    print("sending ClassRoomsStudent WITH Teacher data = > $classData");
    context
        .read<ClassRoomsStudentCubit>()
        .classRoomsStudentCubitCall(classData);
  }

  Future _loadMore() async {
    setState(() {
      isLoading = true;
    });

    // Add in an artificial delay
    await new Future.delayed(const Duration(seconds: 3));
    filterClassrooms(true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000)).then((value) {
      getClassTeachers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      // drawer: DrawerWidget(),
      endDrawer: ClassesEndDrawer(),
      appBar: commonAppBar(
        context,
        // leadingIcon: Builder(
        //   builder: (context) {
        //     return IconButton(
        //       icon: Icon(Icons.dehaze),
        //       onPressed: () {
        //         Scaffold.of(context).openDrawer();
        //       },
        //     );
        //   },
        // ),
        title: "Classrooms",
        // icon: IconButton(
        //   onPressed: () {},
        //   icon: Icon(Icons.refresh, color: Colors.white, size: 30),
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ContactList.routeName);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.message),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<SendCustomClassRoomCommentCubit,
              SendCustomClassRoomCommentState>(
            listener: (context, state) {
              if (state is SendCustomClassRoomCommentLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is SendCustomClassRoomCommentLoadSuccess) {
                getClassTeachers();
              }
            },
          ),
          BlocListener<TeachersListCubit, TeachersListState>(
            listener: (context, state) {
              if (state is TeachersListLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is TeachersListLoadSuccess) {
                filterClassrooms(false);
              }
            },
          ),
          BlocListener<ClassEndDrawerLocalCubit, ClassEndDrawerLocalState>(
            listener: (context, state) {
              if (state is ClassEndDrawerLocalLoadSuccess) {
                setState(() {
                  showLoader = true;
                });
              }
              if (state is ClassEndDrawerLocalLoadSuccess) {
                setState(() {
                  teacherSelected = state.teacherSelect;
                });
                filterClassrooms(false);
              }
            },
          ),
        ],
        child: BlocConsumer<ClassRoomsStudentCubit, ClassRoomsStudentState>(
          listener: (context, state) {
            if (state is ClassRoomsStudentLoadSuccess) {
              classrommCustomList.addAll(state.classRoomsList);
              setState(() {
                isLoading = false;
                showLoader = false;
              });
            }
            if (state is ClassRoomsStudentLoadFail) {
              if (state.failReason == "false") {
                UserUtils.unauthorizedUser(context);
              } else {
                setState(() {
                  isLoading = false;
                  showLoader = false;
                });
                if (classrommCustomList.length > 0) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(commonSnackBar(title: "No More Record"));
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(commonSnackBar(title: "No Record"));
                }
              }
            }
          },
          builder: (context, state) {
            if (state is ClassRoomsStudentLoadInProgress) {
              return buildClassroomsBody(context);
            } else if (state is ClassRoomsStudentLoadSuccess) {
              return buildClassroomsBody(context);
            } else if (state is ClassRoomsStudentLoadFail) {
              // return Center(
              //     child: Text(
              //   "No Class Assign to you.",
              //   textScaleFactor: 1.5,
              // ));
              return buildClassroomsBody(context);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget buildClassroomsBody(BuildContext context) {
    return Scrollbar(
      child: Column(
        children: [
          buildTopDateFilter(context),
          if (showLoader) LinearProgressIndicator() else Divider(thickness: 2),
          if (classrommCustomList.isEmpty)
            Expanded(
              child: Container(
                child: Center(
                  child: Text(
                    "No Class Assign to you.",
                    textScaleFactor: 1.2,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: Stack(
                children: [
                  LazyLoadScrollView(
                    isLoading: isLoading,
                    onEndOfPage: () => _loadMore(),
                    // scrollOffset: 70,
                    child: RefreshIndicator(
                      onRefresh: () => _onRefresh(),
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            Divider(color: Color(0xffECECEC), thickness: 6),
                        controller: _scrollController,
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: classrommCustomList.length,
                        itemBuilder: (context, i) {
                          var item = classrommCustomList[i];
                          return Container(
                            decoration: BoxDecoration(),
                            child: ListTile(
                              title: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    radius: 20,
                                    backgroundImage:
                                        AssetImage(AppImages.dummyImage),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.subjectName != "" &&
                                                  item.subjectName != null
                                              ? item.subjectName!.contains('-')
                                                  ? item.subjectName!
                                                      .split("-")[1]
                                                  : item.subjectName!
                                              : 'unknown',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 19),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${item.subjectName != "" && item.subjectName != null ? item.subjectName!.contains('-')
                                                  // ? "${item.stuEmpType == 'E' ? "Me To" : ""} ${item.subjectName!.split("-")[0]} ● ${item.circularDate1}"
                                                  ? "${item.stuEmpType == 'E' ? "Me To" : ""} ${item.subjectName!.split("-")[0]}" : item.subjectName! : 'unknown'}",
                                              // style: TextStyle(fontSize: 16),
                                              style: commonStyleForText,
                                            ),
                                            Text(
                                              "${item.circularDate1}",
                                              style: TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Divider(color: Color(0xffDBDBDB), height: 10),
                                  if (item.cirContent != null &&
                                      item.cirContent != "")
                                    Text(item.cirContent!,
                                        style: commonStyleForText
                                        // TextStyle(
                                        //     fontSize: 16, color: Colors.black),
                                        ),
                                  if (item.cirContent != null &&
                                      item.cirContent != "")
                                    Divider(
                                        color: Color(0xffDBDBDB), height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      if (item.circularFileUrl != null &&
                                          item.circularFileUrl != "")
                                        FileDownload(
                                          fileName: item.circularFileUrl!
                                              .split("/")
                                              .last,
                                          fileUrl: item.circularFileUrl!,
                                          downloadWidget: Row(
                                            children: [
                                              Image.asset(
                                                  getDownloadImage(item
                                                      .circularFileUrl!
                                                      .split(".")
                                                      .last),
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  width: 28),
                                              SizedBox(width: 10),
                                              Text(
                                                "Download",
                                                textScaleFactor: 1.1,
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ),
                                      InkWell(
                                        onTap: () {
                                          final chatData = ChatRoomCommonModel(
                                            appbarTitle:
                                                item.subjectName!.contains('-')
                                                    ? item.subjectName!
                                                        .split("-")
                                                        .first
                                                    : item.subjectName,
                                            iD: item.circularId,
                                            stuEmpId: item.stuEmpId,
                                            classId: item.classId,
                                            teacherId: item.stuEmpType == "E"
                                                ? item.stuEmpId
                                                : "",
                                            screenType: "classroom",
                                          );
                                          Navigator.pushNamed(
                                              context, ChatRoomCommon.routeName,
                                              arguments: chatData);
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.chat_bubble_outline,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            SizedBox(width: 10),
                                            // googleFontStyleLeto(context,
                                            //     txt: "Comments"),
                                            Text(
                                              "Comments",
                                              textScaleFactor: 1.1,
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Divider(color: Color(0xffECECEC), thickness: 6),
          if (isLoading)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 8.0),
                  Text(
                    'Loading more...',
                    textScaleFactor: 1.0,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Text buildText({String? title, Color? color}) {
  //   return Text(
  //     title ?? "",
  //     style: TextStyle(fontWeight: FontWeight.w600, color: color),
  //   );
  // }

  Container buildTopDateFilter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            color: Colors.white,
            child: Text(
              "$selectedTeacher",
              // style: Theme.of(context).textTheme.headline6,
            ),
          ),
          InkWell(
            onTap: () async {
              _drawerKey.currentState!.openEndDrawer();
            },
            child: Container(
              // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              // color: Theme.of(context).primaryColor,
              child: Row(
                children: [
                  Text("Filter",
                      // style: Theme.of(context).textTheme.headline6,
                  ),
                  Icon(Icons.sort),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text buildLabels(String label) {
    return Text(
      label,
      // style: Theme.of(context).textTheme.headline6,
      // style: TextStyle(
      //   // color: Theme.of(context).primaryColor,
      //   color: Color(0xff3A3A3A),
      //   fontWeight: FontWeight.w600,
      // ),
    );
  }

  String getDownloadImage(String? extention) {
    switch (extention) {
      case "jpg":
        return AppImages.jpgImage;
      case "jpeg":
        return AppImages.jpegImage;
      case "pdf":
        return AppImages.pdfImage;
      default:
        return AppImages.downloadImage;
    }
  }
}
