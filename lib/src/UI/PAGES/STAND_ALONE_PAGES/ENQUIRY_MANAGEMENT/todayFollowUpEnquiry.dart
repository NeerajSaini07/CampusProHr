import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/DASHBOARD_ENQUIRY_CUBIT/dashboard_enquiry_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/dashboardEnquiryModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeDummyData.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodayFollowUpEnquiry extends StatefulWidget {
  const TodayFollowUpEnquiry({Key? key}) : super(key: key);

  @override
  _TodayFollowUpEnquiryState createState() => _TodayFollowUpEnquiryState();
}

class _TodayFollowUpEnquiryState extends State<TodayFollowUpEnquiry> {
  List<TodayFollowUp>? todayFollowUpList = [];

  @override
  void initState() {
    getDashboardCharts();
    super.initState();
  }

  getDashboardCharts() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userType = await UserUtils.userTypeFromCache();
    final dashboardEnquiryData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userType!.organizationId,
      "Schoolid": userType.schoolId,
      "Flag": "All",
    };
    print("Sending TodayFollowUpEnquiry Data => $dashboardEnquiryData");
    context
        .read<DashboardEnquiryCubit>()
        .dashboardEnquiryCubitCall(dashboardEnquiryData);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<DashboardEnquiryCubit, DashboardEnquiryState>(
        listener: (context, state) {
          if (state is DashboardEnquiryLoadFail) {
            if (state.failReason == "false") {
              UserUtils.unauthorizedUser(context);
            }
          }
          if (state is DashboardEnquiryLoadSuccess) {
            setState(() {
              var chartData = state.dashboardEnquiryData.data;
              todayFollowUpList = chartData!.todayFollowUp;
            });
          }
        },
        builder: (context, state) {
          if (state is DashboardEnquiryLoadInProgress) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DashboardEnquiryLoadSuccess) {
            return buildFollowUpBody();
          } else if (state is DashboardEnquiryLoadFail) {
            return Center(child: Text(NO_RECORD_FOUND));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Container buildFollowUpBody() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: todayFollowUpList!.isNotEmpty
          ? ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 10),
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: todayFollowUpList!.length,
              itemBuilder: (context, i) {
                var item = todayFollowUpList![i];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffDBDBDB)),
                  ),
                  child: Stack(
                    children: [
                      ListTile(
                        title: Text(
                          item.name!,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // buildEmailPhone(
                                //     title: '13 Feb 2021 11:15 AM',
                                //     icon: Icons.calendar_today),
                                buildEmailPhone(
                                  title: item.contactNo,
                                  icon: Icons.phone,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: '13 Feb 2021 11:15 AM',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Comments: ${item.comments!}",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 0.0,
                        child: Container(
                          color: Colors.green,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 6),
                            child: Text(
                              item.statusVal!,
                              textScaleFactor: 1.5,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : Center(
              child: Text(
              NO_RECORD_FOUND,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            )),
    );
  }

  Row buildEmailPhone({String? title, IconData? icon}) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).primaryColor,
          // color: Colors.black54,
          size: 20,
        ),
        SizedBox(width: 4),
        RichText(
          text: TextSpan(
            text: title,
            style: TextStyle(
              // fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
