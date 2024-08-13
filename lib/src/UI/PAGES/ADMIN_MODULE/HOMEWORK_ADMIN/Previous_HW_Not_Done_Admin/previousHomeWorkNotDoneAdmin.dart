import 'package:campus_pro/src/DATA/BLOC_CUBIT/CASS_LIST_PREV_HW_NOT_DONE_STATUS_CUBIT/class_list_prev_hw_not_done_status_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/classListPrevHwNotDoneStatusModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/HOMEWORK_ADMIN/Previous_HW_Not_Done_Admin/previousHWNotDoneStudentListAdmin.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/WIDGETS_STYLE/style_common.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreviousHomeWorkNotDoneAdmin extends StatefulWidget {
  static const routeName = "/Previous-Homework-Status-Admin";
  const PreviousHomeWorkNotDoneAdmin({Key? key}) : super(key: key);

  @override
  _PreviousHomeWorkNotDoneAdminState createState() =>
      _PreviousHomeWorkNotDoneAdminState();
}

class _PreviousHomeWorkNotDoneAdminState
    extends State<PreviousHomeWorkNotDoneAdmin> {
  DateTime selectedDate = DateTime.now();
  List<ClassListPrevHwNotDoneStatusModel>? totalClassList;
  List<ClassListPrevHwNotDoneStatusModel>? allClassList;
  List<ClassListPrevHwNotDoneStatusModel>? forSingleClassList = [];

  static const item = [
    [
      'X',
      '5',
      [
        ['name', '123', 'father name', '432342423423423'],
        ['name', '123', 'father name', '432342423423423'],
        ['name', '123', 'father name', '432342423423423']
      ]
    ],
    [
      'X',
      '5',
      [
        ['name1', '123', 'father name', '432342423423423'],
        ['name', '123', 'father name', '432342423423423']
      ]
    ],
    [
      'X',
      '5',
      [
        ['name2', '123', 'father name', '432342423423423']
      ]
    ]
  ];

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
      });
    getClassListHwNotDone(queryType: '0');
    getClassListHwNotDone(queryType: '1');
  }

  getClassListHwNotDone({String? queryType}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "Date": selectedDate.toString(),
      "QueryType": queryType.toString(),
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };

    print('Sending Data for Prev Hw Not Done$sendingData');

    context
        .read<ClassListPrevHwNotDoneStatusCubit>()
        .classListPrevHwNotDoneStatusCubitCall(sendingData);
  }

  @override
  void initState() {
    super.initState();
    getClassListHwNotDone(queryType: '0');
    getClassListHwNotDone(queryType: '1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Previous Homework Status"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: buildDateSelector(
                        selectedDate:
                            DateFormat("dd MMM yyyy").format(selectedDate),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: Text(
                        'Note : Click on class to see the students.',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Divider(
            thickness: 5,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          BlocConsumer<ClassListPrevHwNotDoneStatusCubit,
              ClassListPrevHwNotDoneStatusState>(
            listener: (context, state) {
              if (state is ClassListPrevHwNotDoneStatusLoadFail) {
                if (state.failReason == 'false') {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is ClassListPrevHwNotDoneStatusLoadSuccess) {
                setState(() {
                  if (state.classList[0].noOfStudent == "") {
                    totalClassList = state.classList;
                  } else {
                    allClassList = state.classList;
                  }
                  // allClassList!.forEach((element) {
                  //   totalClassList!.forEach((ele) {
                  //     if (element.compClass == ele.compClass) {
                  //       forSingleClassList!.add(element);
                  //     }
                  //   });
                  // });
                });
              }
            },
            builder: (context, state) {
              if (state is ClassListPrevHwNotDoneStatusLoadInProgress) {
                // return Center(child: CircularProgressIndicator());
                return LinearProgressIndicator();
              } else if (state is ClassListPrevHwNotDoneStatusLoadSuccess) {
                return checkList(classList: allClassList);
              } else if (state is ClassListPrevHwNotDoneStatusLoadFail) {
                return checkList(error: state.failReason);
              } else {
                return Container();
              }
            },
          )
          //buildPrevHwNotDone()
        ],
      ),
    );
  }

  Expanded checkList(
      {List<ClassListPrevHwNotDoneStatusModel>? classList, String? error}) {
    if (classList == null || classList.isEmpty) {
      return Expanded(
          child: Center(
        child: Text(
          '$error',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ));
    } else {
      return buildPrevHwNotDone(classList: classList);
    }
  }

  Expanded buildPrevHwNotDone(
      {List<ClassListPrevHwNotDoneStatusModel>? classList}) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        itemCount: classList!.length,
        itemBuilder: (context, index) {
          var item = classList[index];
          return InkWell(
            onTap: () {
              // getClassListHwNotDone(queryType: '1');

              // allClassList!.forEach((element) {
              //   totalClassList!.forEach((ele) {if(element.compClass==ele.compClass){
              //     forSingleClassList!.add(element);
              //   }});
              // });
              setState(() {
                forSingleClassList = [];
                totalClassList!.forEach((element) {
                  print(item.compClass);
                  print(element.compClass);
                  if (item.compClass == element.compClass) {
                    forSingleClassList!.add(element);
                  }
                });
              });

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return PreviousHWNotDoneStudentList(
                      className: item.compClass,
                      //classData: totalClassList,
                      classData: forSingleClassList,
                    );
                  },
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 13),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(border: Border.all(width: 0.2)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Class : ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${item.compClass}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  // Text(
                  //   'Note : Click To See The Students',
                  //   style: TextStyle(
                  //       color: Colors.red,
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.w600),
                  // )
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'No of Students : ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${item.noOfStudent}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  InkWell buildDateSelector({String? selectedDate}) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: internalTextForDateTime(context,
          width: MediaQuery.of(context).size.width * 0.4,
          selectedDate: selectedDate),
      // Container(
      //   width: MediaQuery.of(context).size.width,
      //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      //   decoration: BoxDecoration(
      //     border: Border.all(color: Color(0xffECECEC)),
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Container(
      //           width: MediaQuery.of(context).size.width / 4,
      //           child: RichText(
      //             text: TextSpan(
      //                 text: '$selectedDate',
      //                 style: TextStyle(
      //                   fontSize: 16,
      //                   color: Colors.black,
      //                 )),
      //           )
      //           // Text(
      //           //   selectedDate!,
      //           //   overflow: TextOverflow.visible,
      //           //   maxLines: 1,
      //           // ),
      //           ),
      //       Icon(Icons.today, color: Theme.of(context).primaryColor)
      //     ],
      //   ),
      // ),
    );
  }
}
