import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:flutter/material.dart';

import '../../globalBlocProvidersFile.dart';

class UpdateEmail extends StatefulWidget {
  const UpdateEmail({Key? key}) : super(key: key);

  @override
  _UpdateEmailState createState() => _UpdateEmailState();
}

class _UpdateEmailState extends State<UpdateEmail> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  bool showLoader = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UpdateEmailCubit>(
      create: (_) => UpdateEmailCubit(UpdateEmailRepository(UpdateEmailApi())),
      child: MultiBlocListener(
        listeners: [
          BlocListener<UpdateEmailCubit, UpdateEmailState>(
            listener: (context, state) {
              if (state is UpdateEmailLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() => showLoader = !showLoader);
                }
              }
              if (state is UpdateEmailLoadInProgress) {
                setState(() => showLoader = !showLoader);
              }
              if (state is UpdateEmailLoadSuccess) {
                setState(() => showLoader = !showLoader);
                Navigator.pop(context);
              }
            },
          ),
        ],
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),
                buildLabels("Please Enter Email-id "),
                buildTextField(
                  controller: emailController,
                  validator: FieldValidators.emailValidator,
                  hintText: "type here",
                ),
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
    );
  }

  Container buildSubmitButton(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        // gradient: LinearGradient(
        //     begin: Alignment.centerLeft,
        //     end: Alignment.centerRight,
        //     colors: [accentColor, primaryColor]),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: TextButton(
        //color: Colors.transparent,
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final uid = await UserUtils.idFromCache();
            final token = await UserUtils.userTokenFromCache();
            final userData = await UserUtils.userTypeFromCache();
            final passData = {
              "OUserId": uid!,
              "Token": token!,
              "OrgId": userData!.organizationId!,
              "Schoolid": userData.schoolId!,
              "StuEmpId": userData.stuEmpId!,
              "EmailId": emailController.text,
              "UserType": userData.ouserType!,
            };
            print('Sending update Email Data => $passData');
            context.read<UpdateEmailCubit>().updateEmailCubitCall(passData);
          }
        },
        child: Text(
          "UPDATE",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Container buildTextField({
    String? hintText,
    String? Function(String?)? validator,
    @required TextEditingController? controller,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: TextFormField(
        controller: controller,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
        ),
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
