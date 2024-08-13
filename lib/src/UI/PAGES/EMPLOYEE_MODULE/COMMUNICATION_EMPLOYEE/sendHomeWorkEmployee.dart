import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/themeData.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SendHomeWorkEmployee extends StatefulWidget {
  static const routeName = "/sendHomeWorkEmployee";
  const SendHomeWorkEmployee({Key? key}) : super(key: key);

  @override
  _SendHomeWorkEmployeeState createState() => _SendHomeWorkEmployeeState();
}

class _SendHomeWorkEmployeeState extends State<SendHomeWorkEmployee> {
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();
  String? toDate;
  String? fromDate;

  Future<void> _selectDate(BuildContext context, {int? index}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFromDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      helpText: "SELECT START DATE",
    );
    if (picked != null && picked != selectedFromDate)
      setState(() {
        if (index == 0) {
          selectedFromDate = picked;
          fromDate = DateFormat("dd-MMM-yyyy").format(selectedFromDate);
        } else {
          selectedToDate = picked;
          toDate = DateFormat("dd-MMM-yyyy").format(selectedToDate);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Send HomeWork"),
      body: buildViewHomeWork(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SendHomeWorkEmp()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget buildViewHomeWork(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        SizedBox(height: 2),
        buildTopDateFilter(context),
        Expanded(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: buildScreenHomeWork(context),
            ))
      ],
    );
  }

  Container buildTopDateFilter(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: buildDateSelector(
                  index: 0,
                  date: (fromDate != null)
                      ? fromDate
                      : DateFormat("dd-MMM-yyyy").format(selectedFromDate),
                ),
              ),
              Icon(Icons.arrow_right_alt_outlined),
              Expanded(
                child: buildDateSelector(
                  index: 1,
                  date: (toDate != null)
                      ? toDate
                      : DateFormat("dd-MMM-yyyy").format(selectedToDate),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Container(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              //   color: Colors.white,
              //   child: Text(
              //     "Clear",
              //     style: TextStyle(color: Colors.black),
              //   ),
              // ),
              InkWell(
                onTap: () async {
                  final uid = await UserUtils.idFromCache();
                  final token = await UserUtils.userTokenFromCache();
                  final userData = await UserUtils.userTypeFromCache();
                  final requestPayLoad = {
                    "OUserId": uid,
                    "Token": token,
                    "OrgId": userData!.organizationId,
                    "Schoolid": userData.schoolId!,
                    "SessionId": userData.currentSessionid!,
                    "For": userData.ouserType,
                    "StuEmpId": "258", // userData.stuEmpId,
                    "EmpGroupId": "0",
                    "From": fromDate,
                    "To": toDate,
                    // "OnLoad":1
                  };
                  // context
                  //     .read<HomeworkStudentCubit>()
                  //     .homeWorkCubitCall(requestPayLoad);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "View",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  InkWell buildDateSelector({String? date, int? index}) {
    return InkWell(
      onTap: () => _selectDate(context, index: index),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffECECEC)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 4,
              child: Text(
                date!,
                overflow: TextOverflow.visible,
                maxLines: 1,
              ),
            ),
            Icon(Icons.today, color: Theme.of(context).primaryColor)
          ],
        ),
      ),
    );
  }

  Container buildScreenHomeWork(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, i) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffDBDBDB)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Column(children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        color: Theme.of(context).primaryColor,
                        child:
                            buildText(title: "${i + 1}", color: Colors.white),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                          child: Container(
                              child: Align(
                                  alignment: Alignment.center,
                                  child: buildText(
                                      title: "VII-A2",
                                      color: Color(0xff3A3A3A))))),
                      SizedBox(width: 8),
                      Expanded(
                          child: Container(
                              child: Align(
                                  alignment: Alignment.center,
                                  child: buildText(
                                      title: "Math",
                                      color: Color(0xff3A3A3A))))),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: buildText(
                              title: "15 May 2021", color: Color(0xff3A3A3A)),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: buildText(
                              title: "Anjali", color: Color(0xff3A3A3A)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: buildText(
                            title: "Homework:\n" +
                                "Social Science: i). Do the following projects in the ... Write a pair of negative integers whose difference gives 8.",
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Icon(Icons.file_download,
                          color: accentColor),
                      Expanded(
                        child: Container(
                          child: Text(
                            "Download File",
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                color: accentColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      Icon(Icons.delete, color: accentColor),
                    ],
                  )
                ]),
              ),
            );
          }),
    );
  }

  Text buildText({String? title, Color? color}) {
    return Text(
      title ?? "",
      style: TextStyle(fontWeight: FontWeight.w600, color: color),
    );
  }
}

class SendHomeWorkEmp extends StatefulWidget {
  const SendHomeWorkEmp({Key? key}) : super(key: key);

  @override
  _SendHomeWorkEmpState createState() => _SendHomeWorkEmpState();
}

class _SendHomeWorkEmpState extends State<SendHomeWorkEmp> {
  List<String> classList = <String>[
    'VI - A2',
    'VI - A3',
    'VII - A1',
    'VII - B2',
    'VII - B1',
    'VII - B3'
  ];
  String? selectedClass;

  List<String> dropdownValueSessionList = <String>[
    '2018-2019',
    '2019-2020',
    '2020-2021',
    '2021-2022',
    '2022-2023',
    '2023-2024'
  ];
  String? dropdownSessionValue;
  TextEditingController _commentController = new TextEditingController();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  File? _pickedImage;

  Future<File?> getImage({ImageSource source = ImageSource.gallery}) async {
    Navigator.pop(context);
    final pickedFile = await ImagePicker().getImage(source: source);
    if (pickedFile != null) {
      print('Image selected.');
      final image = File(pickedFile.path);
      return image;
    } else {
      print('Ops! No Image selected.');
    }
  }

  showUploadSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "Upload via",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 60),
              child: Row(
                children: [
                  buildUploadOption(
                    context,
                    icon: Icons.camera_alt,
                    title: "Camera",
                    onTap: () async {
                      File? tempFile =
                          await getImage(source: ImageSource.camera);
                      if (mounted && tempFile != null) {
                        setState(() {
                          _pickedImage = tempFile;
                        });
                      }
                    },
                  ),
                  buildUploadOption(
                    context,
                    icon: Icons.photo_library,
                    title: "Gallery",
                    onTap: () async {
                      File? tempFile =
                          await getImage(source: ImageSource.gallery);
                      if (mounted && tempFile != null) {
                        setState(() {
                          _pickedImage = tempFile;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Expanded buildUploadOption(BuildContext context,
      {IconData? icon, String? title, void Function()? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: accentColor, size: 28),
            Text(
              title.toString(),
              textScaleFactor: 1.0,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Create HomeWork"),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Form(
            key: _formKey,
            child: ListView(
              children: [
                selectYearAndClass(context),
                buildHomeWork(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded selectYearAndClass(BuildContext context) {
    return Expanded(
      flex: 0,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: sessionSelect(context),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: classSelect(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container sessionSelect(BuildContext context) {
    return Container(
      height: 40.0,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffECECEC)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 2.0),
        child: DropdownButton<String>(
          value: dropdownSessionValue,
          icon: const Icon(Icons.arrow_drop_down),
          hint: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "SELECT SESSION",
            ),
          ),
          iconSize: 20,
          elevation: 16,
          isExpanded: true,
          dropdownColor: Color(0xffFFFFFF),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 13.0,
          ),
          underline: Container(
            color: Color(0xffFFFFFF),
          ),
          onChanged: (newValue) {
            setState(() {
              dropdownSessionValue = newValue;
              print(
                  ">>>>>>>>>>>selected values>>>>>>>>>>>>>>>>$dropdownSessionValue");
            });
          },
          items: dropdownValueSessionList
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  value,
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Container classSelect(BuildContext context) {
    return Container(
      height: 40.0,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffECECEC)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 2.0),
        child: DropdownButton<String>(
          value: selectedClass,
          icon: const Icon(Icons.arrow_drop_down),
          hint: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "SELECT CLASS",
            ),
          ),
          iconSize: 20,
          elevation: 16,
          isExpanded: true,
          dropdownColor: Color(0xffFFFFFF),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 13.0,
          ),
          underline: Container(
            color: Color(0xffFFFFFF),
          ),
          onChanged: (newValue) {
            setState(() {
              selectedClass = newValue;
              print(">>>>>>>>>>>selected values>>>>>>>>>>>>>>>>$selectedClass");
            });
          },
          items: classList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  value,
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Container buildHomeWork(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          children: [
            Container(
              child: TextFormField(
                cursorColor: Colors.black,
                maxLines: 5,
                style: TextStyle(fontSize: 16.0, color: Color(0xff323643)),
                controller: _commentController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                  hintText: "Type here...",
                  hintStyle:
                      TextStyle(fontSize: 16.0, color: Color(0xff323643)),
                  focusedBorder: new OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                      borderSide: new BorderSide(color: Color(0xff323643)),
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Comment';
                  }
                  return null;
                },
              ),
            ),
            buildImageUpload(context),
            Container(
              width: 200.0,
              child: Padding(
                padding: EdgeInsets.only(left: 1.0, top: 5.0, right: 1.0),
                child: Container(
                  height: 35.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [accentColor, primaryColor]),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        return;
                      } else {
                        final sendActivity = {
                          "comment": _commentController.text,
                        };
                        // context
                        //     .read<CreateActivityCubit>()
                        //     .createActivityCubitCall(sendActivity);
                      }
                    },
                    child: Text(
                      "Post",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildImageUpload(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLabels("Deposite Proof:"),
          Center(
            child: GestureDetector(
              onTap: () => showUploadSheet(),
              child: Container(
                height: 150,
                width: 150,
                decoration: new BoxDecoration(
                  color: Color(0xffFAFAFA),
                  border: Border.all(
                      width: 1,
                      style: BorderStyle.solid,
                      color: Color(0xffECECEC)),
                ),
                child: _pickedImage != null
                    ? GestureDetector(
                        onTap: () => showUploadSheet(),
                        child: Stack(
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              child:
                                  Image.file(_pickedImage!, fit: BoxFit.cover),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                height: 30,
                                width: 150,
                                color: Colors.black54,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: FittedBox(
                                      child: Text(
                                    "Change",
                                    style: TextStyle(color: Colors.white70),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.upload_file,
                              color: accentColor, size: 28),
                          Text(
                            "Upload",
                            textScaleFactor: 1.0,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildLabels(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: TextStyle(
          // color: Theme.of(context).primaryColor,
          color: Color(0xff313131),
        ),
      ),
    );
  }
}
