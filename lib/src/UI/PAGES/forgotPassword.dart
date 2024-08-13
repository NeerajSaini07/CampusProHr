import 'package:campus_pro/src/DATA/BLOC_CUBIT/FORGOT_PASSWORD_CUBIT/forgot_password_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/VERIFY_OTP_CUBIT/verify_otp_cubit.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../DATA/API_SERVICES/verifyOtpApi.dart';
import '../../DATA/REPOSITORIES/verifyOtpRepository.dart';

class ForgotPassword extends StatefulWidget {
  static const routeName = "/forgot-password";
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  bool showOtpWidget = false;

  TextEditingController mobileController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool showLoader = false;

  bool _showPassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    mobileController.dispose();
    otpController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body: BlocProvider<VerifyOtpCubit>(
            create: (_) => VerifyOtpCubit(VerifyOtpRepository(VerifyOtpApi())),
            child: MultiBlocListener(
              listeners: [
                BlocListener<VerifyOtpCubit, VerifyOtpState>(
                  listener: (context, state) {
                    if (state is VerifyOtpLoadFail) {
                      if (state.failReason == "false") {
                        UserUtils.unauthorizedUser(context);
                      }
                    }
                    if (state is VerifyOtpLoadInProgress) {
                      setState(() => showLoader = !showLoader);
                    }
                    if (state is VerifyOtpLoadSuccess) {
                      setState(() => showLoader = !showLoader);
                      Navigator.pop(context);
                    }
                  },
                ),
                BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
                  listener: (context, state) {
                    if (state is ForgotPasswordLoadFail) {
                      if (state.failReason == "false") {
                        UserUtils.unauthorizedUser(context);
                      }
                    }
                    if (state is ForgotPasswordLoadInProgress) {
                      setState(() => showLoader = !showLoader);
                    }
                    if (state is ForgotPasswordLoadSuccess) {
                      setState(() => showLoader = !showLoader);
                    }
                  },
                ),
              ],
              child: buildForgotPasswordForm(context),
            ),
          ),
        ));
  }

  Widget buildForgotPasswordForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).primaryColor,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(20.0),
              child: RichText(
                text: TextSpan(
                  text: "Change ",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                  children: <TextSpan>[
                    TextSpan(
                      text: "Password?",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                      // recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // RichText(
                  //   text: TextSpan(
                  //     text: "Change ",
                  //     style: TextStyle(color: Colors.black, fontSize: 30),
                  //     children: <TextSpan>[
                  //       TextSpan(
                  //         text: "Password?",
                  //         style: TextStyle(
                  //             fontSize: 30, fontWeight: FontWeight.w700),
                  //         // recognizer: TapGestureRecognizer()..onTap = () {},
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: 8.0),
                  Text(
                    showOtpWidget
                        ? "Verification code has been sent on your mobile no. and registered Email ID."
                        : "You need enter OTP after submitting your mobile number.",
                    style: TextStyle(
                        color: showOtpWidget ? Colors.red : Color(0xff777777),
                        fontSize: 14),
                  ),
                  SizedBox(height: 20.0),
                  buildLabels("Mobile Number"),
                  buildTextField(
                      controller: mobileController,
                      validator: FieldValidators.mobileValidator,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                      ],
                      hintText: "98xxxxxx",
                      maxLength: 10,
                      obscureText: false,
                      prefixIcon: Icons.phone_android_sharp),
                  if (showOtpWidget)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildLabels("OTP"),
                        buildTextField(
                            controller: otpController,
                            validator: FieldValidators.globalValidator,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4)
                            ],
                            hintText: "xxxx",
                            maxLength: 4,
                            obscureText: false,
                            prefixIcon: Icons.pin),
                        buildLabels("New Password"),
                        buildTextField(
                            controller: newPasswordController,
                            validator: FieldValidators.mobileValidator,
                            hintText: "xxxxxxxxxx",
                            obscureText: false,
                            prefixIcon: Icons.password),
                        buildLabels("Confirm Password"),
                        buildTextField(
                            controller: confirmPasswordController,
                            validator: FieldValidators.mobileValidator,
                            hintText: "xxxxxxxxxx",
                            obscureText: false,
                            prefixIcon: Icons.password),
                      ],
                    ),
                  SizedBox(height: 60.0),
                  if (showLoader)
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 12),
                        Text(
                          "Please wait...",
                          textScaleFactor: 1.0,
                        )
                      ],
                    ))
                  else
                    Column(
                      children: [
                        buildSubmitBtn(),
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "Back to Sign in",
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildSubmitBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            if (showOtpWidget) {
              final mobileData = {
                "MobileNo": mobileController.text,
                "Pass": "123",
              };
              print("Sending forgot password data = $mobileData");
              context
                  .read<ForgotPasswordCubit>()
                  .forgotPasswordCubitCall(mobileData);
            } else {
              final passwordData = {
                "MobileNo": mobileController.text,
                "Otp": otpController.text,
                "NewPass": newPasswordController.text,
              };
              print("Sending verify OTP data = $passwordData");
              context.read<VerifyOtpCubit>().verifyOtpCubitCall(passwordData);
            }
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Text(
              showOtpWidget ? "CONFIRM" : "SEND OTP",
              style: TextStyle(
                  fontFamily: "BebasNeue-Regular", color: Colors.white),
            ),
            Icon(Icons.arrow_forward, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Container buildTextField({
    bool obscureText = false,
    IconData? prefixIcon,
    int? maxLength,
    String? hintText,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    @required TextEditingController? controller,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        validator: validator,
        maxLength: maxLength ?? null,
        inputFormatters: inputFormatters ?? null,
        keyboardType: keyboardType ?? null,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
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
          counter: SizedBox.shrink(),
          hintText: hintText,
          hintStyle: TextStyle(color: Color(0xffA5A5A5)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
          prefixIcon: Icon(prefixIcon),
        ),
        //   suffixIcon: suffixIcon
        //       ? InkWell(
        //           onTap: () {
        //             setState(() {
        //               _showPassword = !_showPassword;
        //             });
        //           },
        //           child: SizedBox(
        //             width: double.minPositive,
        //             child: Center(
        //               child: Text(
        //                 !_showPassword ? "Hide" : "Show",
        //                 textScaleFactor: 1.0,
        //                 style: TextStyle(
        //                     color: Color(0xff77838F),
        //                     fontWeight: FontWeight.w700),
        //               ),
        //             ),
        //           ),
        //         )
        //       : null,
        // ),
      ),
    );
  }

  Text buildLabels(String label) {
    return Text(
      label,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        // color: Color(0xffA5A5A5),
      ),
    );
  }
}
