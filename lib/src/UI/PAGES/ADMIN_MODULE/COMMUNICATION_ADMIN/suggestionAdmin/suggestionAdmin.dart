import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_COMPLAIN_SUGGESTION_LIST_ADMIN_CUBIT/get_complain_suggestion_list_admin_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/INACTIVE_COMP_OR_SUGG_CUBIT/inactive_comp_or_sugg_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/REPLY_COMPLAIN_SUGGESTION_ADMIN_CUBIT/reply_complain_suggestion_admin_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/getComplainSuggestionListAdminModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/COMMUNICATION_ADMIN/suggestionAdmin/suggestionDataAdmin.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/WIDGETS_STYLE/style_common.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuggestionAdmin extends StatefulWidget {
  static const routeName = '/Suggestion-Admin';
  const SuggestionAdmin({Key? key}) : super(key: key);

  @override
  _SuggestionAdminState createState() => _SuggestionAdminState();
}

class _SuggestionAdminState extends State<SuggestionAdmin> {
  List<TextEditingController> _controllers = [];
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

  Future<void> _selectDate(BuildContext context, {int? index}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFromDate,
      firstDate: DateTime(1990),
      lastDate: DateTime(2101),
      helpText: index == 0 ? "SELECT FROM DATE" : "SELECT TO DATE",
    );
    if (picked != null)
      setState(() {
        if (index == 0) {
          selectedFromDate = picked;
        } else {
          selectedToDate = picked;
        }
      });
  }

  getSuggestionComplainList() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final getSuggCompData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "StudentId": "",
      "FromDate": DateFormat('dd-MMM-yyyy').format(selectedFromDate),
      "ToDate": DateFormat('dd-MMM-yyyy').format(selectedToDate),
      "FromStuOrEmp": "",
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };

    print('Sending Suggestion Data $getSuggCompData');
    context
        .read<GetComplainSuggestionListAdminCubit>()
        .getComplainSuggestionListAdminCubitCall(getSuggCompData);
  }

  replyForCompSug({String? sugId, String? remark}) async {
    final id = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final replyForSug = {
      "OUserId": id,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "CompSugId": sugId.toString(),
      "AdminRemark": remark.toString(),
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };
    print('Sending Data for Reply Suggestion $replyForSug');
    context
        .read<ReplyComplainSuggestionAdminCubit>()
        .replyComplainSuggestionAdminCubitCall(replyForSug);
  }

  inActiveReplyOrSuggestion({
    String? sugId,
  }) async {
    final id = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final inActiveSuggestionData = {
      "OUserId": id,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "CompSugId": sugId.toString(),
      "UserType": userData.ouserType,
      "StuEmpId": userData.stuEmpId,
    };

    context
        .read<InactiveCompOrSuggCubit>()
        .inactiveCompOrSuggCubitCall(inActiveSuggestionData);
  }

  @override
  void initState() {
    super.initState();
    getSuggestionComplainList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'Suggestion'),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ReplyComplainSuggestionAdminCubit,
              ReplyComplainSuggestionAdminState>(listener: (context, state) {
            if (state is ReplyComplainSuggestionAdminLoadSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                // SnackBar(
                //   backgroundColor: Colors.lightBlue,
                //   content: Text('Reply Sent'),
                //   duration: Duration(seconds: 1),
                // ),
                commonSnackBar(
                    duration: Duration(seconds: 1), title: 'Reply Sent'),
              );
              getSuggestionComplainList();
            }
            if (state is ReplyComplainSuggestionAdminLoadFail) {
              if (state.failReason == "false") {
                UserUtils.unauthorizedUser(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  // SnackBar(
                  //   backgroundColor: Colors.lightBlue,
                  //   content: Text('${state.failReason}'),
                  //   duration: Duration(seconds: 1),
                  // ),
                  commonSnackBar(
                    title: '${state.failReason}',
                    duration: Duration(seconds: 1),
                  ),
                );
              }
            }
          }),
          BlocListener<InactiveCompOrSuggCubit, InactiveCompOrSuggState>(
            listener: (context, state) {
              if (state is InactiveCompOrSuggLoadSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                    // SnackBar(
                    //   backgroundColor: Colors.lightBlue,
                    //   content: Text('Suggestion Resolved'),
                    //   duration: Duration(seconds: 1),
                    // ),
                    commonSnackBar(
                        title: 'Suggestion Resolved',
                        duration: Duration(seconds: 1)));
                getSuggestionComplainList();
              }
              if (state is InactiveCompOrSuggLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    // SnackBar(
                    //   backgroundColor: Colors.lightBlue,
                    //   content: Text('${state.failReason}'),
                    //   duration: Duration(seconds: 1),
                    // ),
                    commonSnackBar(
                      title: '${state.failReason}',
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              }
            },
          )
        ],
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, right: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabels("Start Date"),
                      SizedBox(height: 8),
                      buildDateSelector(
                        index: 0,
                        selectedDate:
                            DateFormat("dd MMM yyyy").format(selectedFromDate),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabels("End Date"),
                      SizedBox(height: 8),
                      buildDateSelector(
                        index: 1,
                        selectedDate:
                            DateFormat("dd MMM yyyy").format(selectedToDate),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                ),
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).primaryColor),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              onPressed: () {
                print('Hello');
                getSuggestionComplainList();
              },
              child: Text(
                'Apply',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     print('Hello');
            //     getSuggestionComplainList();
            //   },
            //   child: PhysicalModel(
            //     color: Colors.transparent,
            //     elevation: 30,
            //     child: Container(
            //       margin: EdgeInsets.all(8),
            //       padding: EdgeInsets.all(8),
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(30),
            //           color: Theme.of(context).primaryColor),
            //       child: Center(
            //         child: Text(
            //           'Apply',
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontWeight: FontWeight.w600,
            //               fontSize: 16),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Divider(
              thickness: 5,
            ),
            BlocConsumer<GetComplainSuggestionListAdminCubit,
                GetComplainSuggestionListAdminState>(
              listener: (context, state) {
                if (state is GetComplainSuggestionListAdminLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  }
                }
              },
              builder: (context, state) {
                if (state is GetComplainSuggestionListAdminLoadInProgress) {
                  // return CircularProgressIndicator();
                  return LinearProgressIndicator();
                } else if (state is GetComplainSuggestionListAdminLoadSuccess) {
                  return checkSuggestionList(
                      suggestionList: state.suggestionList);
                } else if (state is GetComplainSuggestionListAdminLoadFail) {
                  return checkSuggestionList(error: state.failReason);
                } else {
                  return Container();
                }
              },
            )
            //checkSuggestionList()
          ],
        ),
      ),
    );
  }

  Expanded checkSuggestionList(
      {List<GetComplainSuggestionListAdminModel>? suggestionList,
      String? error}) {
    if (suggestionList == null || suggestionList.isEmpty) {
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
      return buildSuggestionList(suggestionList: suggestionList);
    }
  }

  Expanded buildSuggestionList(
      {List<GetComplainSuggestionListAdminModel>? suggestionList}) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: 10,
        ),
        itemCount: suggestionList!.length,
        itemBuilder: (context, index) {
          var item = suggestionList[index];
          _controllers.add(
            new TextEditingController(),
          );

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SuggestionDataAdmin(
                      subject: item.cSSubject,
                      message: item.cSDetail,
                      name: item.cSBy,
                      className: item.className,
                      date: item.tranDate,
                      mobileNo: item.guardianMobileNo,
                      suggestionId: item.cSId,
                    );
                  },
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0.1),
              ),
              margin: EdgeInsets.only(left: 20, right: 20, top: 5),
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(width: 0.1),
                                color: Colors.blue
                                // image: DecorationImage(
                                //     image: NetworkImage(
                                //         'https://googleflutter.com/sample_image.jpg'),
                                //     fit: BoxFit.fill),
                                ),
                            child: Center(
                              child: Text(
                                item.cS == 'S' ? 'S' : 'C',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005,
                          ),
                          Text(
                            item.tranDate.toString(),
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Text(
                              item.cSTopic.toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Text(item.cSDetail.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                  item.isActive != "N"
                      ? Column(
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                                inActiveReplyOrSuggestion(sugId: item.cSId);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.28,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.1),
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(13)),
                                margin: EdgeInsets.all(4),
                                padding: EdgeInsets.all(6),
                                child: Center(
                                  child: Text(
                                    'Mark Resolved',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Reply To : Student'),
                                        content: TextFormField(
                                          controller: _controllers[index],
                                          style: TextStyle(color: Colors.black),
                                          decoration: InputDecoration(
                                            border: new OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(18.0),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xffECECEC),
                                              ),
                                              gapPadding: 0.0,
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xffECECEC),
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                            hintText: "type reply here",
                                            hintStyle: TextStyle(
                                                color: Color(0xffA5A5A5)),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 0.0,
                                                    horizontal: 16.0),
                                          ),
                                        ),
                                        actions: [
                                          Center(
                                            child: InkWell(
                                              onTap: () {
                                                replyForCompSug(
                                                    sugId: item.cSId,
                                                    remark: _controllers[index]
                                                        .text);
                                                Navigator.pop(context);
                                              },
                                              splashColor: Colors.transparent,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                margin: EdgeInsets.all(8),
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            13),
                                                    border:
                                                        Border.all(width: 0.1),
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                                child: Center(
                                                  child: Text(
                                                    'Reply',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.28,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.1),
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(13)),
                                margin: EdgeInsets.all(4),
                                padding: EdgeInsets.all(6),
                                child: Center(
                                  child: Text(
                                    'Reply',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container()
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
      onTap: () => _selectDate(context, index: index),
      child: internalTextForDateTime(
        context,
        selectedDate: selectedDate,
        width: MediaQuery.of(context).size.width * 0.4,
      ),
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
      //         width: MediaQuery.of(context).size.width / 4,
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

  Text buildLabels(String label) {
    return Text(
      label,
      style: TextStyle(
        // color: Theme.of(context).primaryColor,
        color: Color(0xff3A3A3A),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
