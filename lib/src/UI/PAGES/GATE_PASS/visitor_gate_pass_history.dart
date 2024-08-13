import 'package:campus_pro/src/DATA/BLOC_CUBIT/MARK_VISITOR_EXIT_CUBIT/mark_visitor_exit_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/VISITOR_LIST_TODY_GATE_PASS_CUBIT/visitor_list_gate_pass_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/visitorListTodayModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:flutter_bloc/flutter_bloc.dart";

class VisitorHistory extends StatefulWidget {
  static const routeName = '/GatePass-History';
  const VisitorHistory({Key? key}) : super(key: key);

  @override
  _VisitorHistoryState createState() => _VisitorHistoryState();
}

class _VisitorHistoryState extends State<VisitorHistory> {
  List<VisitorListTodayGatePassModel> historyVisitor = [];

  TextEditingController _searchController = TextEditingController();

  _launchPhoneURL(String phoneNumber) async {
    String url = 'tel:' + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getVisitorHistory() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };

    print("sending data for visitor List gate pass $sendingData");

    context
        .read<VisitorListGatePassCubit>()
        .visitorListGatePassCubitCall(sendingData);
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

    context.read<MarkVisitorExitCubit>().exitVisitor(sendingData, 0);
  }

  @override
  void initState() {
    getVisitorHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Visitors History"),
      body: MultiBlocListener(
        listeners: [
          BlocListener<MarkVisitorExitCubit, MarkVisitorExitState>(
              listener: (context, state) {
            if (state is MarkVisitorExitLoadSuccess) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(commonSnackBar(title: 'Visitor Exit'));

              getVisitorHistory();
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
            BlocConsumer<VisitorListGatePassCubit, VisitorListGatePassState>(
              listener: (context, state) {
                if (state is VisitorListGatePassLoadSuccess) {
                  setState(() {
                    historyVisitor = state.visitorList;
                  });
                }
                if (state is VisitorListGatePassLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  } else {
                    historyVisitor = [];
                  }
                }
              },
              builder: (context, state) {
                if (state is VisitorListGatePassLoadInProgress) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is VisitorListGatePassLoadSuccess) {
                  return checkList(historyList: state.visitorList);
                } else if (state is VisitorListGatePassLoadFail) {
                  return checkList(error: state.failReason);
                } else {
                  return Container();
                }
              },
            ),
            //buildVisitorHistoryList(),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  checkList({List<VisitorListTodayGatePassModel>? historyList, String? error}) {
    if (historyList == null || historyList.isEmpty) {
      if (error == null || error.isEmpty) {
        return Center(
            child: Container(
          child: Text("Wait"),
        ));
      } else {
        return Center(
            child: Container(
          child: Text(
            "$error",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ));
      }
    } else {
      return buildVisitorHistoryList(historyList: historyList);
    }
  }

  Expanded buildVisitorHistoryList(
      {List<VisitorListTodayGatePassModel>? historyList}) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => SizedBox(
          height: 10,
        ),
        itemCount: historyList!.length,
        itemBuilder: (context, index) {
          var item = historyList[index];
          return (item.visitorName!.toLowerCase().contains(
                    _searchController.text.toLowerCase(),
                  ))
              ? Container(
                  padding: EdgeInsets.all(8),
                  //margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(width: 0.1),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return DetailScreen(
                                selImg:
                                    '${item.domainName}${item.visitorImagePath != "" ? item.visitorImagePath!.substring(2) : ""}',
                                ind: index,
                              );
                            },
                          ));
                        },
                        child: Hero(
                          tag: "visitor-history-detail-image $index",
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.27,
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: Image.network(
                                '${item.domainName}${item.visitorImagePath != "" ? item.visitorImagePath!.substring(2) : ""}',
                                width: 20.0,
                                height: 80.0,
                                fit: BoxFit.fill,
                                errorBuilder: (BuildContext context,
                                    Object object, StackTrace) {
                                  return RotatedBox(
                                    quarterTurns: -1,
                                    child: Image(
                                      width: 100,
                                      height: 100,
                                      image: AssetImage(AppImages.dummyImage),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${item.visitorName}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _launchPhoneURL("${item.number}");
                                  },
                                  child: Icon(
                                    Icons.phone,
                                    size: 25,
                                    color: Colors.blueAccent,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Text(
                                    'Entry : ${item.entryTime}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
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
                                Expanded(
                                  child: Text(
                                    'Address : ${item.visitorAddress}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    exitVisitor(id: item.id.toString());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      border: Border.all(
                                        width: 0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    margin: EdgeInsets.all(4),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    child: Text(
                                      "Exit",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container();
        },
      ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  final selImg;
  final int? ind;

  DetailScreen({
    this.selImg,
    this.ind,
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InteractiveViewer(
        panEnabled: false, // Set it to false
        boundaryMargin: EdgeInsets.all(100),
        minScale: 0.5,
        maxScale: 2,
        child: GestureDetector(
          child: RotatedBox(
            quarterTurns: 1,
            child: Center(
              child: Hero(
                tag: 'visitor-history-detail-image ${widget.ind}',
                child: Image.network(
                  '${widget.selImg}',
                  fit: BoxFit.fill,
                  errorBuilder:
                      (BuildContext context, Object object, StackTrace) {
                    return RotatedBox(
                      quarterTurns: -1,
                      child: Image(
                        width: 100,
                        height: 100,
                        image: AssetImage(AppImages.dummyImage),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
