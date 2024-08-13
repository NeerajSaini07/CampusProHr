import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UI/PAGES/ForGotPassWord/ApiForGotPassWord/checkSchoolForGotPasswordApi.dart';
import 'package:campus_pro/src/UI/PAGES/ForGotPassWord/ForGotPassWord2.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForGotPassWord1 extends StatefulWidget {
  ForGotPassWord1();

  @override
  _ForGotPassWord1State createState() => _ForGotPassWord1State();
}

class _ForGotPassWord1State extends State<ForGotPassWord1> {
  TextEditingController mobileController = TextEditingController();

  static var dropDownMenu = [];
  String selectedDropDown = "";
  String selectedDropDownId = "";

  bool showDropDown = false;

  @override
  void dispose() {
    mobileController.dispose();
    dropDownMenu = [];
    selectedDropDown = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Center(
              child: Text(
                "Change Password",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            buildTextField(
                controller: mobileController,
                validator: FieldValidators.mobileValidator,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                hintText: "Enter Mobile Number",
                maxLength: 10,
                obscureText: false,
                suffixIcon: false),
            SizedBox(
              height: 20,
            ),
            buildSchoolDropDown(),
            // SizedBox(
            //   height: 50,
            // ),
            // buildSendOtp(),
          ],
        ),
      ),
    );
  }

  Expanded buildSchoolDropDown() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showDropDown
              ? Text(
                  'School',
                  // style: Theme.of(context).textTheme.headline6,
                )
              : Container(),
          showDropDown
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                )
              : Container(),
          showDropDown
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffECECEC)),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: DropdownButton<String>(
                    isDense: true,
                    value: selectedDropDown,
                    key: UniqueKey(),
                    isExpanded: true,
                    underline: Container(),
                    items: dropDownMenu
                        .map(
                          (value) => DropdownMenuItem<String>(
                            child: Text(value[1]),
                            value: value[1],
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          selectedDropDown = val!;
                          dropDownMenu.forEach((element) {
                            if (element[1] == selectedDropDown) {
                              selectedDropDownId = element[0];
                            }
                          });
                          print(selectedDropDownId);
                        },
                      );
                    },
                  ),
                )
              : Container(),
          showDropDown
              ? SizedBox(
                  height: 50,
                )
              : Container(),
          buildSendOtp(),
        ],
      ),
    );
  }

  Container buildTextField({
    bool obscureText = false,
    bool? suffixIcon = false,
    int? maxLength,
    String? hintText,
    TextInputAction? textInputAction,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    @required TextEditingController? controller,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: TextFormField(
        textInputAction: textInputAction,
        obscureText: obscureText,
        controller: controller,
        validator: validator,
        maxLength: maxLength ?? null,
        keyboardType: keyboardType ?? null,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffECECEC),
            ),
            gapPadding: 0.0,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffECECEC),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffECECEC),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Color(0xffA5A5A5)),
          counterText: "",
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
        ),
      ),
    );
  }

  Widget buildSendOtp() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 20),
        decoration: BoxDecoration(
          color: Color(0xff2ab57d),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: TextButton(
          onPressed: () async {
            try {
              if (mobileController.text != "" &&
                  mobileController.text.length == 10) {
                var data = {
                  "Mobile": mobileController.text,
                  "Schoolid": selectedDropDown == ""
                      ? ""
                      : selectedDropDownId.split("#")[0],
                  "OrgId": selectedDropDown == ""
                      ? ""
                      : selectedDropDownId.split("#")[1],
                };

                print(data);
                await CheckSchoolForGotPasswordApi()
                    .checkSchool(payload: data)
                    .then((value) async {
                  // List lis = value.split(",");
                  // print(value);
                  // print(value["Data"].runtimeType);
                  print(value["Data"] is List<dynamic>);
                  print(value["Data"].length);

                  ///
                  if (value["Data"] is List<dynamic>) {
                    //
                    if (value["Data"].length > 1) {
                      List data = value["Data"];
                      setState(() {
                        data.forEach((ele1) {
                          print(ele1);
                          dropDownMenu
                              .add([ele1["schoolid"], ele1["SchoolName"]]);
                        });
                        selectedDropDown = data[0]["SchoolName"];
                        selectedDropDownId = data[0]["schoolid"];
                        // print(dropDownMenu);
                        // print(selectedDropDown);
                        showDropDown = true;
                      });
                    } else {
                      // dropDownMenu.add("${value["Data"]}");
                      // selectedDropDown = value["Data"][0]["SchoolName"];
                      // selectedDropDownId = value["Data"][0]["schoolid"];
                      //
                      // var data = {
                      //   "Mobile": mobileController.text,
                      //   "Schoolid": selectedDropDownId.split("#")[0],
                      //   "OrgId": selectedDropDownId.split("#")[1],
                      // };
                      //
                      // print(data);
                      // await CheckSchoolForGotPasswordApi()
                      //     .checkSchool(payload: data)
                      //     .then((value) async {});
                      //
                    }
                  } else {
                    if (value["Data"].split("#")[0] == "success") {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return ForGotPassWord2(
                            number: mobileController.text,
                          );
                        }),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(commonSnackBar(
                          title: "${value["Data"].split("#")[1]}"));
                    }
                  }
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    commonSnackBar(title: "Enter Valid Mobile Number"));
              }
            } catch (e) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(commonSnackBar(title: "$SOMETHING_WENT_WRONG"));
            }
          },
          child: Text(
            "Send Otp",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
