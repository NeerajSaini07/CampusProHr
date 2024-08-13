import 'package:campus_pro/src/DATA/BLOC_CUBIT/CHANGE_PASSWORD_STUDENT_CUBIT/change_password_student_cubit.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordStudent extends StatefulWidget {
  static const routeName = "/change-password-student";
  @override
  _ChangePasswordStudentState createState() => _ChangePasswordStudentState();
}

class _ChangePasswordStudentState extends State<ChangePasswordStudent> {
  bool showLoader = false;

  GlobalKey<FormState> __formKey = new GlobalKey<FormState>();

  TextEditingController oldPasswordController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  bool eyeTappedForNew = true;
  bool eyeTappedForConfirm = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "Change Password"),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ChangePasswordStudentCubit, ChangePasswordStudentState>(
            listener: (context, state) {
              if (state is ChangePasswordStudentLoadInProgress) {
                setState(() => showLoader = true);
              }
              if (state is ChangePasswordStudentLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() => showLoader = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    commonSnackBar(title: "Enter Credentials Properly"),
                  );
                }
              }
              if (state is ChangePasswordStudentLoadSuccess) {
                if (state.status == "Success") {
                  oldPasswordController.clear();
                  newPasswordController.clear();
                  confirmPasswordController.clear();
                  setState(() => showLoader = false);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(commonSnackBar(title: "Password Changed"));
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(commonSnackBar(title: "${state.status}"));
                  setState(() => showLoader = false);
                }
              }
            },
          ),
        ],
        child: Form(
          key: __formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.0),
                  buildLabels("Old Password"),
                  buildTextField(
                      controller: oldPasswordController,
                      validator: FieldValidators.passwordValidator,
                      hintText: "type here",
                      isIcon: false),
                  SizedBox(height: 20.0),
                  buildLabels("New Password"),
                  buildTextField(
                      controller: newPasswordController,
                      validator: FieldValidators.passwordValidator,
                      hintText: "type here",
                      isIcon: true),
                  SizedBox(height: 20.0),
                  buildLabels("Confirm Password"),
                  buildTextField(
                      controller: confirmPasswordController,
                      validator: FieldValidators.passwordValidator,
                      hintText: "type here",
                      isIcon: true),
                  SizedBox(height: 40.0),
                  if (showLoader)
                    Center(child: CircularProgressIndicator())
                  else
                    buildSubmitButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget buildEmailAlertBox({CheckEmailRegistrationModel? emailData}) {
  //   return emailData!.loginOTPFeature!.toUpperCase() == "Y"
  //       ? emailData!.mailVerified == "0" ? showEmailAlertMessage() : emailData!.mailVerified == "1" ? showEmailAlertMessage()
  //       : Container();
  // }

  InkWell showEmailAlertMessage() {
    return InkWell(
      // onTap: () => showEmailBottomSheet(),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          // color: Colors.yellow[200],
          border: Border(
            left: BorderSide(width: 2.0, color: Colors.red[200]!),
            right: BorderSide(width: 2.0, color: Colors.red[200]!),
            top: BorderSide(width: 2.0, color: Colors.red[200]!),
            bottom: BorderSide(width: 2.0, color: Colors.red[200]!),
          ),
        ),
        child: ListTile(
          title: Text("Your Email Id is not registered.",
              textScaleFactor: 1.0,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[400])),
          subtitle: Text("Tap here for Register",
              textScaleFactor: 1.0,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          // trailing: Icon(Icons.arrow_forward_ios_outlined),
        ),
      ),
    );
  }

  Widget buildSubmitButton(BuildContext context) {
    return Center(
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Theme.of(context).primaryColor,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                30.0,
              ),
            ),
          ),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10,
            ),
          ),
        ),
        onPressed: () async {
          if (newPasswordController.text == confirmPasswordController.text) {
            if (__formKey.currentState!.validate()) {
              final uid = await UserUtils.idFromCache();
              final token = await UserUtils.userTokenFromCache();
              final userData = await UserUtils.userTypeFromCache();
              final passData = {
                "OUserId": uid!,
                "Token": token!,
                "OrgId": userData!.organizationId!,
                "Schoolid": userData.schoolId!,
                "OldPass": oldPasswordController.text,
                "NewPass": newPasswordController.text,
                "StuEmp": userData.stuEmpId,
                "UserType": userData.ouserType,
              };
              context
                  .read<ChangePasswordStudentCubit>()
                  .changePasswordStudentCubitCall(passData);
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              commonSnackBar(
                title: "New Password Not Matched",
                duration: Duration(seconds: 1),
              ),
            );
          }
        },
        child: Text(
          "Change Password",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Container buildTextField({
    String? hintText,
    String? Function(String?)? validator,
    @required TextEditingController? controller,
    @required bool? isIcon,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: TextFormField(
        controller: controller,
        validator: validator,
        style: TextStyle(color: Colors.black),
        obscureText: isIcon == true
            ? controller == newPasswordController
                ? eyeTappedForNew == true
                    ? true
                    : false
                : eyeTappedForConfirm == true
                    ? true
                    : false
            : false,
        decoration: InputDecoration(
          suffixIcon: isIcon == true
              ? IconButton(
                  onPressed: () {
                    if (controller == newPasswordController) {
                      setState(() {
                        eyeTappedForNew = !eyeTappedForNew;
                      });
                    } else {
                      setState(() {
                        eyeTappedForConfirm = !eyeTappedForConfirm;
                      });
                    }
                  },
                  icon: controller == newPasswordController
                      ? eyeTappedForNew == true
                          ? Icon(
                              Icons.visibility_off,
                            )
                          : Icon(
                              Icons.visibility,
                              color: Colors.lightBlue,
                            )
                      : eyeTappedForConfirm == true
                          ? Icon(Icons.visibility_off)
                          : Icon(
                              Icons.visibility,
                              color: Colors.lightBlue,
                            ),
                )
              : Icon(
                  Icons.remove,
                  color: Colors.transparent,
                ),
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
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
        ),
      ),
    );
  }

  Text buildLabels(String label) {
    return Text(
      label,
      // style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 16),
    );
  }

  // showEmailBottomSheet() {
  //   showModalBottomSheet<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return UpdateEmail();
  //     },
  //   );
  // }
}

// class UpdateEmail extends StatefulWidget {
//   const UpdateEmail({Key? key}) : super(key: key);

//   @override
//   _UpdateEmailState createState() => _UpdateEmailState();
// }

// class _UpdateEmailState extends State<UpdateEmail> {
//   TextEditingController emailController = TextEditingController();

//   bool showLoader = false;

//   @override
//   void dispose() {
//     emailController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 20.0),
//           buildLabels("Please Enter Email-id "),
//           buildTextField(
//             controller: emailController,
//             validator: FieldValidators.globalValidator,
//             hintText: "type here",
//           ),
//           SizedBox(height: 40.0),
//           if (showLoader)
//             Center(child: CircularProgressIndicator())
//           else
//             buildSubmitButton(context),
//         ],
//       ),
//     );
//   }

//   Container buildSubmitButton(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//             colors: [accentColor, primaryColor]),
//         borderRadius: BorderRadius.all(
//           Radius.circular(10.0),
//         ),
//       ),
//       child: FlatButton(
//         //color: Colors.transparent,
//         onPressed: () async {
//           // final uid = await UserUtils.idFromCache();
//           // final token = await UserUtils.userTokenFromCache();
//           // final userData = await UserUtils.userTypeFromCache();
//           // final passData = {
//           //   "OUserId": uid!,
//           //   "Token": token!,
//           //   "OrgId": userData!.organizationId!,
//           //   "Schoolid": userData.schoolId!,
//           //   "OldPass": oldPasswordController.text,
//           //   "NewPass": newPasswordController.text,
//           //   // "OLoginId":userData.,
//           // };
//           // context
//           //     .read<ChangePasswordStudentCubit>()
//           //     .changePasswordStudentCubitCall(passData);
//         },
//         child: Text(
//           "SUBMIT",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }

//   Container buildTextField({
//     String? hintText,
//     String? Function(String?)? validator,
//     @required TextEditingController? controller,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(top: 8),
//       child: TextFormField(
//         controller: controller,
//         validator: validator,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         style: TextStyle(color: Colors.black),
//         decoration: InputDecoration(
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Color(0xffECECEC),
//             ),
//             gapPadding: 0.0,
//           ),
//           disabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Color(0xffECECEC),
//             ),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Color(0xffECECEC),
//             ),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Theme.of(context).primaryColor,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Theme.of(context).primaryColor,
//             ),
//           ),
//           hintText: hintText,
//           hintStyle: TextStyle(color: Color(0xffA5A5A5)),
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
//         ),
//       ),
//     );
//   }

//   Text buildLabels(String label) {
//     return Text(
//       label,
//       style: TextStyle(
//         color: Theme.of(context).primaryColor,
//         // color: Color(0xffA5A5A5),
//       ),
//     );
//   }
// }
