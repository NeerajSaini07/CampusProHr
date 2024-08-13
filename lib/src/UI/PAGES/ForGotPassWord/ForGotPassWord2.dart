import 'dart:async';

import 'package:campus_pro/src/DATA/API_SERVICES/verifyOtpApi.dart';
import 'package:campus_pro/src/UI/PAGES/ForGotPassWord/ApiForGotPassWord/verifyOtpApi.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:flutter/material.dart';

class ForGotPassWord2 extends StatefulWidget {
  final number;
  const ForGotPassWord2({Key? key, this.number}) : super(key: key);

  @override
  _ForGotPassWord2State createState() => _ForGotPassWord2State();
}

class _ForGotPassWord2State extends State<ForGotPassWord2> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  @override
  void initState() {
    mobileController.text = widget.number;
    super.initState();
  }

  Timer? timer;

  @override
  void dispose() {
    mobileController.dispose();
    otpController.dispose();
    passwordConfirmController.dispose();
    passwordController.dispose();
    if (timer != null) {
      timer!.cancel();
    }
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
                suffixIcon: false,
                ignoringPointer: true),
            SizedBox(
              height: 10,
            ),
            buildTextField(
              controller: otpController,
              validator: FieldValidators.mobileValidator,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              hintText: "Enter Otp",
              maxLength: 10,
              obscureText: false,
            ),
            SizedBox(
              height: 10,
            ),
            buildTextField(
              controller: passwordController,
              validator: FieldValidators.passwordValidator,
              hintText: "Enter Password",
              textInputAction: TextInputAction.go,
              obscureText: true,
            ),
            SizedBox(
              height: 10,
            ),
            buildTextField(
              controller: passwordConfirmController,
              validator: FieldValidators.passwordValidator,
              hintText: "Confirm Password",
              textInputAction: TextInputAction.go,
              obscureText: true,
            ),
            SizedBox(
              height: 50,
            ),
            buildSendOtp(),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    bool obscureText = false,
    bool? suffixIcon = false,
    int? maxLength,
    String? hintText,
    TextInputAction? textInputAction,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    @required TextEditingController? controller,
    bool? ignoringPointer,
  }) {
    return IgnorePointer(
      ignoring: ignoringPointer == null ? false : true,
      child: Container(
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
            if (passwordController.text == passwordConfirmController.text &&
                passwordController.text != "" &&
                otpController.text != "") {
              var data = {
                "MobileNo": mobileController.text,
                "Otp": otpController.text,
                "NewPass": passwordController.text,
              };

              print("Sending data for confirm password $data");

              await VerifyOtpApiForgotPassword()
                  .verifyOtp(payload: data)
                  .then((value) {
                if (value.split("#")[0] == "success") {
                  ScaffoldMessenger.of(context).showSnackBar(commonSnackBar(
                      title: "Password Changed",
                      duration: Duration(seconds: 2)));
                  timer = Timer.periodic(Duration(seconds: 2), (timer) {
                    Navigator.pop(context);
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      commonSnackBar(title: "${value.split("#")[1]}"));
                }
              });
              //
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                commonSnackBar(
                    title: "Password Does Not Match or Otp can not be empty."),
              );
            }
          },
          child: Text(
            "Confirm",
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
