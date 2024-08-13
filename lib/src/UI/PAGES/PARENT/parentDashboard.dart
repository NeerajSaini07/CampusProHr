import 'package:campus_pro/src/DATA/MODELS/dummyData.dart';
import 'package:flutter/material.dart';

class ParentDashboard extends StatefulWidget {
  static const routeName = "/parent-dashboard";
  const ParentDashboard({Key? key}) : super(key: key);

  @override
  _ParentDashboardState createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.redAccent,
                          radius: 20,
                          child: CircleAvatar(
                            backgroundColor: Color(0xffFF5BB1F6),
                            radius: 13,
                          ),
                        ),
                        Text(
                          "  Demo School",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Color(0xffFF5BB1F6),
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 30,
                        child: Image.asset("assets/images/boy.png"),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, XYZ's parent",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Standard 1-A",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // shape: BoxShape.circle,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                          ),
                          child: Container(
                            height: 36,
                            width: 36,
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffFFA9D2F3),
                                border: Border.all(
                                    color: Theme.of(context).primaryColor)),
                            child: Icon(
                              Icons.access_time_sharp,
                              size: 26,
                              color: Color(0xffFF5BB1F6),
                            ),
                          ),
                        ),
                        Text(
                          "       Book \n appointment \n with principle",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          //Add Quick Access
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff045D98).withOpacity(0.03),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildQuickAccessType(context, title: "Academics"),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.23,
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(width: 25);
                          },
                          shrinkWrap: true,
                          itemCount: studentCategoryListAcademics.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var item = studentCategoryListAcademics[index];
                            return buildCard(
                                img: item.image, title: item.title);
                          }),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     buildCard(img: AppImages.feePaymentImage, title: "Fee"),
                    //     buildCard(
                    //         img: AppImages.attendanceIcon,
                    //         title: "Notification"),
                    //     buildCard(
                    //         img: AppImages.notifyImage, title: "Circular"),
                    //   ],
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    buildQuickAccessType(context, title: "Administrative"),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.23,
                      // color: Colors.transparent,
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(width: 25);
                          },
                          shrinkWrap: true,
                          itemCount: studentCategoryListAcademics.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var item = studentCategoryListAcademics[index];
                            return buildCard(
                                img: item.image, title: item.title);
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //
                    buildQuickAccessType(context, title: "Circulars"),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.23,
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(width: 25);
                          },
                          shrinkWrap: true,
                          itemCount: studentCategoryListAcademics.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var item = studentCategoryListAcademics[index];
                            return buildCard(
                                img: item.image, title: item.title);
                          }),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildCard({String? title, String? img}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 1,
              // color: Colors.grey.shade400,
              color: Color(0xff045D98).withOpacity(0.1),
              offset: Offset(0, 10),
            )
          ],
          color: Colors.white),
      height: 120,
      width: 135,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("$img", height: 50, width: 50),
          SizedBox(
            height: 20,
          ),
          Text(
            "$title",
            textScaleFactor: 0.7,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Widget buildQuickAccessType(BuildContext context, {String? title}) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      child: Text(
        "$title",
        style: TextStyle(
          fontSize: 20,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
