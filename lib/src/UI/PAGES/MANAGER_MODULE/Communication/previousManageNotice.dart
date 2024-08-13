import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UI/PAGES/MANAGER_MODULE/Communication/manageNotice.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:flutter/material.dart';

class PreviousManageNotice extends StatefulWidget {
  static const routeName = '/Previous-Manage-Notice';
  const PreviousManageNotice({Key? key}) : super(key: key);

  @override
  _PreviousManageNoticeState createState() => _PreviousManageNoticeState();
}

class _PreviousManageNoticeState extends State<PreviousManageNotice> {
  List dummyData = [
    // [
    //   'Notice Demo',
    //   'On the occasion of diwali today is holiday',
    //   '20 Aug 2021'
    // ],
    // [
    //   'Notice Demo',
    //   'On the occasion of diwali today is holiday On the occasion of diwali today is holiday On the occasion of diwali today is holiday',
    //   '21 Aug 2021'
    // ],
    // [
    //   'Notice Demo',
    //   'On the occasion of diwali today is holiday',
    //   '22 Aug 2021'
    // ],
    // [
    //   'Notice Demo',
    //   'On the occasion of diwali today is holiday',
    //   '23 Aug 2021'
    // ],
    // [
    //   'Notice Demo',
    //   'On the occasion of diwali today is holiday',
    //   '24 Aug 2021'
    // ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'Previous Notices'),
      floatingActionButton: GestureDetector(
        onTap: () {
          Map<String, String> data = {};
          Navigator.pushNamed(context, ManageNotice.routeName, arguments: data);
        },
        child: Container(
          margin: EdgeInsets.all(2),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border.all(width: 0.1),
              borderRadius: BorderRadius.circular(20)),
          child: Text(
            'Add Notice',
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            buildListView(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListView() {
    return dummyData.length > 0
        ? ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: dummyData.length,
            itemBuilder: (context, index) {
              var item = dummyData[index];
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '- ${item[0]}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      item[1],
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                print('Hello');
                              },
                              child: PhysicalModel(
                                color: Colors.transparent,
                                elevation: 20,
                                shape: BoxShape.rectangle,
                                shadowColor: Colors.white,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 0.01),
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.red),
                                  child: Center(
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                            ),
                            GestureDetector(
                              onTap: () {
                                print('Hello');
                                final data = {
                                  "title": "${item[0]}",
                                  "description": "${item[1]}",
                                };
                                Navigator.pushNamed(
                                    context, ManageNotice.routeName,
                                    arguments: data);
                              },
                              child: PhysicalModel(
                                color: Colors.transparent,
                                elevation: 20,
                                shape: BoxShape.rectangle,
                                shadowColor: Colors.white,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 0.01),
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${item[2]}',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          )
        : Center(
            child: Text(
              NO_RECORD_FOUND,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          );
  }
}
