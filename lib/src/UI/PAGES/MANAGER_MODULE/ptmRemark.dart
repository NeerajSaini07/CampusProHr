import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PtmRemark extends StatefulWidget {
  static const routeName = "/Ptm-remark";

  _PtmRemarkState createState() => _PtmRemarkState();
}

class _PtmRemarkState extends State<PtmRemark> {
  DateTime selectedDate = DateTime.now();

  static const dropDownValues = ["X", "X1", "X2"];
  String? selectedDropDown = "X";

  List<DropdownMenuItem<String>> dropdownMenuItem = dropDownValues
      .map((e) => DropdownMenuItem(
            child: Text("$e"),
            value: e,
          ))
      .toList();

  List<List> studentList = [
    [
      "name",
      "reg_no",
      "f_name",
      "1",
      "2",
      "3",
      "4",
      "5",
    ],
    [
      "name1",
      "f_name",
      "reg_no",
      "1",
      "2",
      "3",
      "4",
      "5",
    ],
    [
      "name2",
      "f_name",
      "reg_no",
      "1",
      "2",
      "3",
      "4",
      "5",
    ],
    [
      "name3",
      "f_name",
      "reg_no",
      "1",
      "2",
      "3",
      "4",
      "5",
    ],
    [
      "name",
      "reg_no",
      "f_name",
      "1",
      "2",
      "3",
      "4",
      "5",
    ],
    [
      "name1",
      "f_name",
      "reg_no",
      "1",
      "2",
      "3",
      "4",
      "5",
    ],
    [
      "name2",
      "f_name",
      "reg_no",
      "1",
      "2",
      "3",
      "4",
      "5",
    ],
    [
      "name3",
      "f_name",
      "reg_no",
      "1",
      "2",
      "3",
      "4",
      "5",
    ],
  ];

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: commonAppBar(context, title: "PTM Remark Entry"),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "Select Class",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.1),
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    width: 150,
                    height: 40,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: DropdownButton<String>(
                      items: dropdownMenuItem,
                      value: selectedDropDown,
                      underline: Container(),
                      isExpanded: true,
                      onChanged: (val) {
                        setState(() {
                          selectedDropDown = val;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "PTM Date",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      datePicker();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 7.0, horizontal: 7.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(
                          width: 0.1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "${DateFormat("dd-MMM-yyyy").format(selectedDate)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 30.0,
                          ),
                          Icon(
                            Icons.date_range,
                            color: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Divider(
            thickness: 2,
            color: Theme.of(context).primaryColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "General",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(
                "Transport",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(
                "Account",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(
                "Sport",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(
                "Hr",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                shrinkWrap: true,
                itemCount: studentList.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${studentList[index][0]} (${studentList[index][1]})"),
                        Text("${studentList[index][2]}"),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: [
                            textField(),
                            SizedBox(
                              width: 10,
                            ),
                            textField(),
                            SizedBox(
                              width: 10,
                            ),
                            textField(),
                            SizedBox(
                              width: 10,
                            ),
                            textField(),
                            SizedBox(
                              width: 10,
                            ),
                            textField(),
                          ],
                        )
                      ],
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget textField() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.17,
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12.0,
        ),
        border: Border.all(
          width: 0.2,
        ),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Future<DateTime?> datePicker() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2025));
    return date;
  }
}
