import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckAssignSheet extends StatefulWidget {
  static const routeName = 'check-test-sheet';
  @override
  _CheckAssignSheetState createState() => _CheckAssignSheetState();
}

class _CheckAssignSheetState extends State<CheckAssignSheet> {
  var items1 = [
    ['X', 'Math', '30', '12', '14', 'view details'],
    ['X', 'Science', '30', '12', '14', 'view details'],
    ['X', 'English', '30', '12', '14', 'view details']
  ];

  var items2 = [
    ['1111', '10000', 'check', 'Done'],
    ['2222', '10000', 'Checked', 'Done'],
    ['3333', '99999', 'Check', 'Done']
  ];
  TabController? tabController;
  int _currentIndex = 0;

  void tabIndexChange(int tabIndex) {
    setState(() {
      _currentIndex = tabIndex;
    });
  }

  static const classItem = [
    '--Select Class--',
    'III-A2',
    'III-A3',
    '3-A10',
    'V-2-A2',
  ];

  static const testItem = [
    '--Select Test--',
    'Test 1',
    'Test 2',
    'Test 3',
    'Test 4',
  ];

  final List<DropdownMenuItem<String>> _dropDownClassITem = classItem
      .map(
        (String value) => DropdownMenuItem<String>(
          child: Text(value),
          value: value,
        ),
      )
      .toList();

  final List<DropdownMenuItem<String>> _dropDownSectionITem = testItem
      .map(
        (String value) => DropdownMenuItem<String>(
          child: Text(value),
          value: value,
        ),
      )
      .toList();

  String classSelectValue = '--Select Class--';
  String testSelectValue = '--Select Test--';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'Check Assign Sheet'),
      body: DefaultTabController(
        initialIndex: _currentIndex,
        length: 2,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 12, bottom: 5, left: 18, right: 18),
              child: Row(
                children: [
                  buildClassDropDown(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  buildTestDropDown(),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.2),
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor,
                ),
                child: InkWell(
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    print('Test');
                  },
                  child: Center(
                    child: Text(
                      'Search',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  //customBorder: CircleBorder(),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Divider(
              thickness: 5,
            ),
            buildTabBar(context),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Expanded(
              child: TabBarView(
                //physics: NeverScrollableScrollPhysics(),
                children: [
                  totalStudentsAssigned(), totalSheetAssigned()
                  // buildDataList(),
                  // buildDataList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildClassDropDown() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Class :',
            // style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
              // borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton(
              isDense: true,
              value: classSelectValue,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: this._dropDownClassITem,
              onChanged: (String? val) {
                setState(
                  () {
                    classSelectValue = val!;
                    print("selectedMonth: $val");
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildTestDropDown() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Test :',
            // style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
              // borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton(
              isDense: true,
              value: testSelectValue,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: this._dropDownSectionITem,
              onChanged: (String? val) {
                setState(
                  () {
                    testSelectValue = val!;
                    print("selectedMonth: $val");
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Container buildTabBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor)),
      child: TabBar(
        unselectedLabelColor: Theme.of(context).primaryColor,
        labelColor: Colors.white,
        indicator: BoxDecoration(
          // gradient: customGradient,
          color: Theme.of(context).primaryColor,
        ),
        physics: ClampingScrollPhysics(),
        onTap: (int tabIndex) {
          print("tabIndex: $tabIndex");
          switch (tabIndex) {
            case 0:
              tabIndexChange(tabIndex);
              // getSample();
              break;
            case 1:
              tabIndexChange(tabIndex);
              break;
            default:
              tabIndexChange(tabIndex);
              // getSample();
              break;
          }
        },
        tabs: [
          buildTabs(title: 'Total Students Assigned ', index: 0),
          buildTabs(title: 'Total Sheets Assigned ', index: 1),
        ],
        controller: tabController,
      ),
    );
  }

  Tab buildTabs({String? title, int? index}) {
    return Tab(
      child: Text(title!),
    );
  }

  Center buildDataList() {
    return Center(
      child: Text(NO_RECORD_FOUND),
    );
  }

  ListView totalStudentsAssigned() {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 10,
        );
      },
      itemCount: items1.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(width: 0.1),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Class : '),
                      Text(
                        items1[index][0],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      // Text('Test : '),
                      Text(
                        items1[index][1],
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Total Students : '),
                      Text(
                        items1[index][2],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Total Students Checked : '),
                      Text(
                        items1[index][3],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Partially Checked : '),
                      Text(
                        items1[index][4],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Details : '),
                      Text(items1[index][5]),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  ListView totalSheetAssigned() {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 10,
        );
      },
      itemCount: items2.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(width: 0.1),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Reg. No. : '),
                      Text(
                        items2[index][0],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Total Sheet : '),
                      Text(
                        items2[index][1],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Action : '),
                      Text(
                        items2[index][2],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Status : '),
                      Text(
                        items2[index][3],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
