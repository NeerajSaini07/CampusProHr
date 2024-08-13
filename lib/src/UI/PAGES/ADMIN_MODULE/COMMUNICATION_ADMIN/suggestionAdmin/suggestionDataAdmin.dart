import 'package:campus_pro/src/DATA/BLOC_CUBIT/REPLY_COMPLAIN_SUGGESTION_ADMIN_CUBIT/reply_complain_suggestion_admin_cubit.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SuggestionDataAdmin extends StatefulWidget {
  static const routeName = "/SuggestionDataAdmin";

  final String? subject;
  final String? message;
  final String? date;
  final String? name;
  final String? className;
  final String? mobileNo;
  final String? suggestionId;
  const SuggestionDataAdmin({
    this.name,
    this.className,
    this.mobileNo,
    this.date,
    this.message,
    this.subject,
    this.suggestionId,
  });

  @override
  _SuggestionDataAdminState createState() => _SuggestionDataAdminState();
}

class _SuggestionDataAdminState extends State<SuggestionDataAdmin> {
  TextEditingController replyController = TextEditingController();

  _launchPhoneURL(String phoneNumber) async {
    String url = 'tel:' + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  replyForCompSug({String? sugId, String? remark}) async {
    final id = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final replyForSug = {
      "OUserId": id,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "CompSugId": sugId.toString(),
      "AdminRemark": remark.toString(),
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };
    print('Sending Data for Reply Suggestion $replyForSug');
    context
        .read<ReplyComplainSuggestionAdminCubit>()
        .replyComplainSuggestionAdminCubitCall(replyForSug);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'Summary'),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ReplyComplainSuggestionAdminCubit,
              ReplyComplainSuggestionAdminState>(listener: (context, state) {
            if (state is ReplyComplainSuggestionAdminLoadSuccess) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     duration: Duration(seconds: 1),
              //     content: Text("Reply Sent"),
              //     backgroundColor: Colors.lightBlueAccent,
              //   ),
              // );
              replyController.text = "";
              Navigator.pop(context);
            }
          })
        ],
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      'Subject : ${widget.subject}',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text('Date : ${widget.date}'),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Text(
                'Message : ${widget.message}',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      '${widget.name} (${widget.className})',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ),
                  widget.mobileNo != null
                      ? GestureDetector(
                          onTap: () {
                            _launchPhoneURL(widget.mobileNo.toString());
                          },
                          child: Icon(
                            Icons.local_phone,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : Container()
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              TextFormField(
                controller: replyController,
                validator: FieldValidators.globalValidator,
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
                  hintText: "type reply here",
                  hintStyle: TextStyle(color: Color(0xffA5A5A5)),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 16.0),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Center(
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    if (replyController.text.length > 1) {
                      replyForCompSug(
                          sugId: widget.suggestionId,
                          remark: replyController.text);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //   content: Text('Enter Something'),
                        //   backgroundColor: Colors.lightBlueAccent,
                        // ),
                        commonSnackBar(
                          title: 'Enter Something',
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 0.1),
                        color: Theme.of(context).primaryColor),
                    child: Center(
                      child: Text(
                        'Reply',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
