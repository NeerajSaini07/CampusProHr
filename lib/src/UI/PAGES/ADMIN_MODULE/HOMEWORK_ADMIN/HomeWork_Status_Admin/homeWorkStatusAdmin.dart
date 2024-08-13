import 'package:campus_pro/src/DATA/BLOC_CUBIT/CLASS_LIST_HW_STATUS_ADMIN_CUBIT/class_list_hw_status_admin_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/classListHwStatusAdminModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/HOMEWORK_ADMIN/HomeWork_Status_Admin/homeWorkStatusStudentHwListAdmin.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/fileDownloader.dart';
import 'package:campus_pro/src/WIDGETS_STYLE/style_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWorkStatusAdmin extends StatefulWidget {
  static const routeName = "/HomeWork-Status-Admin";
  const HomeWorkStatusAdmin({Key? key}) : super(key: key);

  @override
  _HomeWorkStatusAdminState createState() => _HomeWorkStatusAdminState();
}

class _HomeWorkStatusAdminState extends State<HomeWorkStatusAdmin> {
  DateTime selectedDate = DateTime.now();

  bool isChecked = true;

  // static const item = [
  //   [
  //     'X',
  //     'Eng : Hello This is English HomeWork.I Like to Send it to you.Thanks',
  //   ],
  //   [
  //     'X',
  //     'Eng : Hello This is English HomeWork.I Like to Send it to you.Thanks This is English HomeWork.I Like to Send it to you.Thanks This is English HomeWork.I Like to Send it to you.ThanksThis is English HomeWork.I Like to Send it to you.ThanksThis is English HomeWork.I Like to Send it to you.Thanks This is English HomeWork.I Like to Send it to you.ThanksThis is English HomeWork.I Like to Send it to you.Thanks This is English HomeWork.I Like to Send it to you.Thanksv ',
  //   ],
  //   [
  //     'X',
  //     'Eng : Hello',
  //   ],
  // ];
  // static const item1 = [
  //   [
  //     'X',
  //     'End ,hindi, G.k,End ,hindi, G.k,End ,hindi, G.k,End ,hindi, G.k,End ,hindi, G.k'
  //   ],
  //   [
  //     'X',
  //     'End',
  //   ],
  //   [
  //     'X',
  //     'End',
  //   ],
  // ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1947),
      lastDate: DateTime(2101),
    );
    if (picked != null)
      setState(() {
        print(picked);
        selectedDate = picked;
        if (isChecked == true) {
          homeWorkList(statusSending: '1');
        } else {
          homeWorkList(statusSending: '0');
        }
      });
  }

  homeWorkList({String? statusSending}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final getHwData = {
      "OUserId": uid!,
      "UserType": userData!.ouserType,
      "Token": token,
      "StuEmpId": userData.stuEmpId,
      "OrgId": userData.organizationId,
      "schoolid": userData.schoolId,
      "Date": DateFormat('dd-MMM-yyyy').format(selectedDate),
      "SendingStatus": statusSending,
    };
    print('Class List before api Hw Status $getHwData');
    context
        .read<ClassListHwStatusAdminCubit>()
        .classListHwStatusAdminCubitCall(getHwData);
  }

  @override
  void initState() {
    super.initState();
    homeWorkList(statusSending: '1');
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1)).then((value) {
      homeWorkList(statusSending: '1');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Homework Status"),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date:",
                        style: TextStyle(
                          // color: Theme.of(context).primaryColor,
                          color: Color(0xff3A3A3A),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 8),
                      buildDateSelector(
                        selectedDate:
                            DateFormat("dd MMM yyyy").format(selectedDate),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.046,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      onPressed: () {
                        print('Hello');
                        setState(() {
                          isChecked = !isChecked;
                          if (isChecked == true) {
                            homeWorkList(statusSending: '1');
                          } else {
                            homeWorkList(statusSending: '0');
                          }
                        });
                      },
                      child: RichText(
                        text: TextSpan(
                          text:
                              isChecked == true ? 'Load not sent' : 'Load sent',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    // PhysicalModel(
                    //   elevation: 10,
                    //   color: Colors.transparent,
                    //   child: Container(
                    //     padding:
                    //         EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    //     decoration: BoxDecoration(
                    //       color: Theme.of(context).primaryColor,
                    //       borderRadius: BorderRadius.circular(30),
                    //     ),
                    //     child: GestureDetector(
                    //       onTap: () {
                    //         print('Hello');
                    //         setState(() {
                    //           isChecked = !isChecked;
                    //           if (isChecked == true) {
                    //             homeWorkList(statusSending: '1');
                    //           } else {
                    //             homeWorkList(statusSending: '0');
                    //           }
                    //         });
                    //       },
                    //       child: RichText(
                    //         text: TextSpan(
                    //             text: isChecked == true
                    //                 ? 'Load not sent'
                    //                 : 'Load sent',
                    //             style: TextStyle(
                    //               fontSize: 16,
                    //             )),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
            isChecked == true
                ? Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            // 'Below are the Classes whose HW is send Today.',
                            'Below are the Classes whose HW is send on ${DateFormat("dd-MMM-yyyy").format(selectedDate)}.',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 13),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Click To See The HomeWork In Detail.',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  )
                : Container(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        // 'Below are the Classes whose HW not send Today.',
                        'Below are the Classes whose HW not send on ${DateFormat("dd-MMM-yyyy").format(selectedDate)}.',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ),
                  ),
            SizedBox(
              height: isChecked == true
                  ? MediaQuery.of(context).size.height * 0.01
                  : MediaQuery.of(context).size.height * 0.02,
            ),
            // BlocConsumer<ClassListHwStatusAdminCubit,
            //     ClassListHwStatusAdminState>(
            //   listener: (context, state) {},
            //   builder: (context, state) {
            //     if(state is ClassListHwStatusAdminLoadInProgress){
            //       return CircularProgressIndicator();
            //     }
            //     else if (state is ClassListHwStatusAdminLoadSuccess){
            //       return checkListDoneHw(classList: state.classList);
            //     }
            //     else if (state is ClassListHwStatusAdminLoadFail){
            //       return checkListDoneHw(error: state.failReason);
            //     }
            //     else{
            //       return Container();
            //     }
            //   },
            // ),
            isChecked == true
                ? BlocConsumer<ClassListHwStatusAdminCubit,
                    ClassListHwStatusAdminState>(
                    listener: (context, state) {
                      if (state is ClassListHwStatusAdminLoadFail) {
                        if (state.failReason == "false") {
                          UserUtils.unauthorizedUser(context);
                        }
                      }
                    },
                    builder: (context, state) {
                      if (state is ClassListHwStatusAdminLoadInProgress) {
                        // return Center(child: CircularProgressIndicator());
                        return LinearProgressIndicator();
                      } else if (state is ClassListHwStatusAdminLoadSuccess) {
                        return checkListDoneHw(classList: state.classList);
                      } else if (state is ClassListHwStatusAdminLoadFail) {
                        return checkListDoneHw(error: state.failReason);
                      } else {
                        return Container();
                      }
                    },
                  )
                : BlocConsumer<ClassListHwStatusAdminCubit,
                    ClassListHwStatusAdminState>(
                    listener: (context, state) {
                      if (state is ClassListHwStatusAdminLoadFail) {
                        if (state.failReason == "false") {
                          UserUtils.unauthorizedUser(context);
                        }
                      }
                    },
                    builder: (context, state) {
                      if (state is ClassListHwStatusAdminLoadInProgress) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is ClassListHwStatusAdminLoadSuccess) {
                        return checkListNotDoneHw(classList: state.classList);
                      } else if (state is ClassListHwStatusAdminLoadFail) {
                        return checkListNotDoneHw(error: state.failReason);
                      } else {
                        return Container();
                      }
                    },
                  ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Expanded checkListNotDoneHw(
      {List<ClassListHwStatusAdminModel>? classList, String? error}) {
    if (classList == null || classList.isEmpty) {
      return Expanded(
          child: Center(
        child: Container(
          child: Text('$error'),
        ),
      ));
    } else {
      return buildHwNotSendToday(classList: classList);
    }
  }

  Expanded buildHwNotSendToday({List<ClassListHwStatusAdminModel>? classList}) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        itemCount: classList!.length,
        itemBuilder: (context, index) {
          var item = classList[index];
          return Container(
            margin: EdgeInsets.only(left: 12, right: 12, top: 4),
            padding: EdgeInsets.only(top: 4, left: 8, bottom: 4, right: 8),
            decoration: BoxDecoration(
                border: Border.all(width: 0.2),
                borderRadius: BorderRadius.circular(2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Class : ',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    Text(
                      '${item.className}',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.red),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.004,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      // Text(
                      //   'HomeWork Not Send Subjects : ',
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.w600,
                      //     fontSize: 15,
                      //     color: Colors.lightBlueAccent,
                      //   ),
                      // ),
                      Flexible(
                        child: Text(
                          '-${item.sentMessage}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Expanded checkListDoneHw(
      {List<ClassListHwStatusAdminModel>? classList, String? error}) {
    if (classList == null || classList.isEmpty) {
      return Expanded(
          child: Center(
        child: Container(
          child: Text(
            '$error',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ));
    } else {
      return buildHwSendToday(classList: classList);
    }
  }

  Expanded buildHwSendToday({List<ClassListHwStatusAdminModel>? classList}) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        itemCount: classList!.length,
        itemBuilder: (context, index) {
          var item = classList[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return HomeWorkStatusStudentHwListAdmin(
                      homeworkList: item.sentMessage,
                      downloadLink:
                          item.homeworkURL != null ? item.homeworkURL : null,
                      className: item.className,
                    );
                  },
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 4),
              padding: EdgeInsets.only(top: 4, left: 8, bottom: 4, right: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 0.2),
                  borderRadius: BorderRadius.circular(2)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Class : ',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          Text(
                            '${item.className}',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: Colors.lightBlueAccent),
                          )
                        ],
                      ),
                      item.homeworkURL != ""
                          ? FileDownload(
                              fileName: item.homeworkURL!.split("/").last,
                              fileUrl: item.homeworkURL!,
                              downloadWidget: Icon(Icons.file_download,
                                  color: Theme.of(context).primaryColor),
                            )
                          // ? GestureDetector(
                          //     onTap: () {
                          //       FileDownload(
                          //         fileName: item.homeworkURL!.split("/").last,
                          //         fileUrl: item.homeworkURL!,
                          //         downloadWidget: Icon(Icons.file_download,
                          //             color: Theme.of(context).primaryColor),
                          //       );
                          //     },
                          //     child: Icon(
                          //       Icons.arrow_circle_down_sharp,
                          //       size: 25,
                          //       color: Theme.of(context).primaryColor,
                          //     ),
                          //   )
                          : Container()
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                      text: "HomeWork For : ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                      children: [
                        TextSpan(
                          text:
                              "${item.sentMessage != null ? item.sentMessage!.split(":")[0] : ""}",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  // Text(
                  //   'HomeWork For : ${item.sentMessage!.split(":")[0]}',
                  //   style: TextStyle(
                  //       color: Colors.green,
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.w600),
                  // )
                  // Text(
                  //   'Click To See The HomeWork.',
                  //   style: TextStyle(
                  //       color: Colors.red,
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.w600),
                  // )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  InkWell buildDateSelector({String? selectedDate, int? index}) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: internalTextForDateTime(context,
          width: MediaQuery.of(context).size.width * 0.4,
          selectedDate: selectedDate),
      // Container(
      //   width: MediaQuery.of(context).size.width * 0.4,
      //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      //   decoration: BoxDecoration(
      //     border: Border.all(color: Color(0xffECECEC)),
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Container(
      //         width: MediaQuery.of(context).size.width * 0.25,
      //         child: Text(
      //           selectedDate!,
      //           overflow: TextOverflow.visible,
      //           maxLines: 1,
      //         ),
      //       ),
      //       Icon(Icons.today, color: Theme.of(context).primaryColor)
      //     ],
      //   ),
      // ),
    );
  }
}
