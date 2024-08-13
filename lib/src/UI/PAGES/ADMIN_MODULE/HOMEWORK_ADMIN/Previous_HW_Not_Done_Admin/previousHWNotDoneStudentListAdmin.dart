import 'package:campus_pro/src/DATA/MODELS/classListPrevHwNotDoneStatusModel.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PreviousHWNotDoneStudentList extends StatefulWidget {
  static const routeName = '/previous-HW-Not-Done-StudentList-Admin';
  final String? className;
  final List<ClassListPrevHwNotDoneStatusModel>? classData;
  const PreviousHWNotDoneStudentList(
      {@required this.className, @required this.classData});

  @override
  _PreviousHWNotDoneStudentListState createState() =>
      _PreviousHWNotDoneStudentListState();
}

class _PreviousHWNotDoneStudentListState
    extends State<PreviousHWNotDoneStudentList> {
  List<ClassListPrevHwNotDoneStatusModel> classList = [];
  _launchPhoneURL(String phoneNumber) async {
    String url = 'tel:' + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getClassList() {
    setState(() {
      classList = widget.classData!;
    });
  }

  @override
  void initState() {
    getClassList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'Class : ${widget.className}'),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          classList.length != 0
              ? Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                    itemCount: classList.length,
                    itemBuilder: (context, index) {
                      var item = classList[index];
                      return Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 5),
                        padding: EdgeInsets.all(8),
                        decoration:
                            BoxDecoration(border: Border.all(width: 0.1)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    '${item.stName!.toUpperCase()}',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${item.compClass!.toUpperCase()}',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.red),
                                    ),
                                    Text(
                                      ' (${item.admNo})',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'F/N : ${item.fatherName}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  item.guardianMobileNo != "" &&
                                          item.guardianMobileNo != null
                                      ? GestureDetector(
                                          onTap: () {
                                            print('TEST');
                                            _launchPhoneURL(
                                                '${item.guardianMobileNo}');
                                          },
                                          child: Icon(
                                            Icons.phone,
                                            size: 20,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
