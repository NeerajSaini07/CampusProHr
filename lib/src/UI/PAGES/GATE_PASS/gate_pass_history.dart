import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_GATE_PASS_HISTORY_CUBIT/get_gate_pass_history_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/MARK_VISITOR_EXIT_CUBIT/mark_visitor_exit_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/getGatePassHistoryModal.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GatePassHistory extends StatefulWidget {
  static const routeName = "/Gate-Pass-History";
  const GatePassHistory({Key? key}) : super(key: key);

  @override
  _GatePassHistoryState createState() => _GatePassHistoryState();
}

class _GatePassHistoryState extends State<GatePassHistory> {
  TextEditingController _searchController = TextEditingController();

  List<GetGatePassHistoryModal> gatePassList = [];

  List demoList = List.generate(10, (index) => null);

  _launchPhoneURL(String phoneNumber) async {
    String url = 'tel:' + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getGatePassHistory() async {
    final id = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingData = {
      "OUserId": id,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "UserType": userData.ouserType,
      "StuEmpId": userData.stuEmpId,
    };

    print("sending data for gate pass history $sendingData");

    context
        .read<GetGatePassHistoryCubit>()
        .getGatePassHistoryCubitCall(sendingData);
  }

  exitVisitor({String? id}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "SchoolId": userData.schoolId,
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "Id": id
    };

    print("sending data for exit gate pass $sendingData");

    context.read<MarkVisitorExitCubit>().exitVisitor(sendingData, 1);
  }

  @override
  void initState() {
    getGatePassHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gate Pass History"),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<GetGatePassHistoryCubit, GetGatePassHistoryState>(
              listener: (context, state) {
            if (state is GetGatePassHistoryLoadSuccess) {
              setState(() {
                gatePassList = state.historyList;
              });
            }
            if (state is GetGatePassHistoryLoadFail) {
              if (state.failReason == "false") {
                UserUtils.unauthorizedUser(context);
              } else {}
            }
          }),
          BlocListener<MarkVisitorExitCubit, MarkVisitorExitState>(
              listener: (context, state) {
            if (state is MarkVisitorExitLoadSuccess) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(commonSnackBar(title: 'Visitor Exit'));
              getGatePassHistory();
            }
            if (state is MarkVisitorExitLoadFail) {
              if (state.failReason == "false") {
                UserUtils.unauthorizedUser(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    commonSnackBar(title: 'Something went wrong'));
              }
            }
          }),
        ],
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                border: Border.all(width: 0.2),
                borderRadius: BorderRadius.circular(13),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search By Name"),
                controller: _searchController,
                onChanged: (val) {
                  setState(() {
                    _searchController.text;
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            BlocBuilder<GetGatePassHistoryCubit, GetGatePassHistoryState>(
                builder: (context, state) {
              if (state is GetGatePassHistoryLoadInProgress) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetGatePassHistoryLoadSuccess) {
                return checkList(list: gatePassList);
              } else if (state is GetGatePassHistoryLoadFail) {
                return checkList(error: state.failReason);
              } else {
                return Container();
              }
            }),
            SizedBox(
              height: 3,
            ),
          ],
        ),
      ),
    );
  }

  checkList({List<GetGatePassHistoryModal>? list, String? error}) {
    if (list == null || list.isEmpty) {
      if (error == null || error.isEmpty) {
        return Center(
          child: Text(
            "Wait",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        );
      } else {
        return Center(
          child: Text(
            "$error",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        );
      }
    } else {
      return buildGatePassHistory(list: list);
    }
  }

  Expanded buildGatePassHistory({List<GetGatePassHistoryModal>? list}) {
    return Expanded(
        child: ListView.separated(
      itemCount: list!.length,
      shrinkWrap: true,
      separatorBuilder: (context, index) => SizedBox(
        height: 10,
      ),
      itemBuilder: (context, index) {
        var item = list[index];
        return item.name!
                .toLowerCase()
                .contains(_searchController.text.toLowerCase())
            ? Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(width: 0.1),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${item.name}",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "${item.studentEmployeeName}",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${item.time}",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        IconButton(
                          constraints: BoxConstraints(),
                          onPressed: () {
                            _launchPhoneURL("${item.contactNo}");
                          },
                          icon: Icon(Icons.phone),
                          color: Colors.blue,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${item.purpose}",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "${item.passType}",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        GestureDetector(
                          onTap: () {
                            exitVisitor(id: item.id.toString());
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 6, right: 6, top: 3, bottom: 3),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              border: Border.all(width: 0.1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              "Exit",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            : Container();
      },
    ));
  }
}
