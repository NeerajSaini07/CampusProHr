import 'package:campus_pro/src/DATA/BLOC_CUBIT/FEEDBACK_STUDENT_CUBIT/feedback_student_cubit.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../DATA/API_SERVICES/feedbackStudentApi.dart';
import '../../../DATA/REPOSITORIES/feedbackStudentRepository.dart';

class FeedbackStudent extends StatefulWidget {
  static const routeName = "/feedback-student";

  @override
  _FeedbackStudentState createState() => _FeedbackStudentState();
}

class _FeedbackStudentState extends State<FeedbackStudent> {
  TextEditingController topicController = new TextEditingController();
  TextEditingController subjectController = new TextEditingController();
  TextEditingController messageController = new TextEditingController();

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _selectedType = "C";

  bool showLoader = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    topicController.dispose();
    subjectController.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "Feedback"),
      body:     BlocProvider<FeedbackStudentCubit>(
        create: (_) => FeedbackStudentCubit(
            FeedbackStudentRepository(FeedbackStudentApi())),
            child:
      MultiBlocListener(
        listeners: [
          BlocListener<FeedbackStudentCubit, FeedbackStudentState>(
            listener: (context, state) {
              if (state is FeedbackStudentLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is FeedbackStudentLoadInProgress) {
                setState(() => showLoader = !showLoader);
              }
              if (state is FeedbackStudentLoadSuccess) {
                topicController.clear();
                subjectController.clear();
                messageController.clear();
                setState(() => showLoader = !showLoader);
                // Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  commonSnackBar(
                    title: "Feedback Sent",
                    duration: Duration(seconds: 1),
                  ),
                );
              }
            },
          ),
        ],
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLabels(label: "Feedback Type"),
                Row(
                  children: [
                    buildRadioText(
                        title: "Complain",
                        value: "C",
                        groupValue: _selectedType),
                    buildRadioText(
                        title: "Suggestion",
                        value: "S",
                        groupValue: _selectedType),
                  ],
                ),
                buildLabels(label: "Topic"),
                buildTextField(
                  controller: topicController,
                  validator: FieldValidators.globalValidator,
                ),
                SizedBox(height: 10),
                buildLabels(label: "Subject"),
                buildTextField(
                  controller: subjectController,
                  validator: FieldValidators.globalValidator,
                ),
                SizedBox(height: 10),
                buildLabels(label: "Message"),
                buildTextField(
                  controller: messageController,
                  validator: FieldValidators.globalValidator,
                  maxLines: 5,
                  maxLength: 500,
                ),
                SizedBox(height: 10),
                if (showLoader)
                  Center(child: CircularProgressIndicator())
                else
                  buildSendButton(context),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Row buildRadioText(
      {String? title, required String value, required String? groupValue}) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: groupValue,
          onChanged: (String? value) {
            setState(() {
              _selectedType = value!;
            });
          },
        ),
        Text(title!),
      ],
    );
  }

  Padding buildLabels({String? label, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Text(
        label!,
        // style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 16),
      ),
    );
  }

  Container buildTextField({
    int? maxLines = 1,
    int? maxLength,
    String? Function(String?)? validator,
    @required TextEditingController? controller,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLines: maxLines ?? null,
        maxLength: maxLength ?? null,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(18.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffECECEC),
            ),
            gapPadding: 0.0,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
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
          hintText: "type here",
          hintStyle: TextStyle(color: Color(0xffA5A5A5)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          // suffixIcon: suffixIcon
          //     ? InkWell(
          //         onTap: () {
          //           setState(() {
          //             _showPassword = !_showPassword;
          //           });
          //         },
          //         child: !_showPassword
          //             ? Icon(Icons.remove_red_eye_outlined)
          //             : Icon(Icons.remove_red_eye),
          //       )
          //     : null,
        ),
      ),
    );
  }

  Widget buildSendButton(BuildContext context) {
    return Center(
      child: TextButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).primaryColor),
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(
            horizontal: 25.0,
            vertical: 5,
          )),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                30.0,
              ),
            ),
          ),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final uid = await UserUtils.idFromCache();
            final token = await UserUtils.userTokenFromCache();
            final userType = await UserUtils.userTypeFromCache();
            final sendFeedBack = {
              "OUserId": uid,
              "Token": token,
              "OrgId": userType!.organizationId!,
              "Schoolid": userType.schoolId,
              "SessionId": userType.currentSessionid,
              "Usertype": userType.ouserType,
              "StudentId": userType.stuEmpId,
              "Comp_Sug": _selectedType,
              "C_STopic": topicController.text,
              "C_SSubject": subjectController.text,
              "C_SDetail": messageController.text,
            };
            print("sendFeedBack on UI => $sendFeedBack");
            context
                .read<FeedbackStudentCubit>()
                .feedbackStudentCubitCall(sendFeedBack);
          }
          // FocusScopeNode currentFocus = FocusScope.of(context);
          // if (!currentFocus.hasPrimaryFocus) {
          //   currentFocus.unfocus();
          // }
        },
        child: Text(
          "SEND",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
