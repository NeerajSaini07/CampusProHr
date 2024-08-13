import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/fileDownloader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeWorkStatusStudentHwListAdmin extends StatefulWidget {
  final homeworkList;
  final downloadLink;
  final className;
  static const routeName = '/HomeWork-Status-Student-Hw-List-Admin';
  const HomeWorkStatusStudentHwListAdmin(
      {this.homeworkList, this.downloadLink, this.className});

  @override
  _HomeWorkStatusStudentHwListAdminState createState() =>
      _HomeWorkStatusStudentHwListAdminState();
}

class _HomeWorkStatusStudentHwListAdminState
    extends State<HomeWorkStatusStudentHwListAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'Homework Status'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    child: RichText(
                      text: TextSpan(
                        text: "Class : ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                            text: "${widget.className}",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Text(
                  //   'Class - ${widget.className}',
                  //   style: TextStyle(
                  //       color: Colors.blue,
                  //       fontSize: 25,
                  //       fontWeight: FontWeight.w900),
                  // ),
                  widget.downloadLink != ""
                      ? FileDownload(
                          fileName: widget.downloadLink!.split("/").last,
                          fileUrl: widget.downloadLink!,
                          downloadWidget: Icon(Icons.file_download,
                              color: Theme.of(context).primaryColor),
                        )
                      :
                      // IconButton(
                      //     constraints: BoxConstraints(),
                      //     splashColor: Colors.transparent,
                      //     onPressed: () {
                      //       FileDownload(
                      //         fileName: widget.downloadLink!.split("/").last,
                      //         fileUrl: widget.downloadLink!,
                      //         downloadWidget: Icon(Icons.file_download,
                      //             color: Theme.of(context).primaryColor),
                      //       );
                      //     },
                      //     icon: Icon(
                      //       Icons.arrow_circle_down_sharp,
                      //       color: Theme.of(context).primaryColor,
                      //       size: 30,
                      //     ),
                      //   )
                      Container()
                ],
              ),
            ),
            Divider(
              thickness: 5,
            ),
            // Container(
            //   margin: EdgeInsets.symmetric(vertical: 10),
            //   child: Text(
            //     'HomeWork',
            //     style: TextStyle(
            //         decoration: TextDecoration.underline,
            //         color: Colors.red,
            //         fontWeight: FontWeight.w600,
            //         fontSize: 25),
            //   ),
            // ),
            Container(
              margin: EdgeInsets.all(10),
              child: RichText(
                text: TextSpan(
                  // text: '- ${widget.homeworkList!.split(":")[0]}',
                  text: '',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.blueAccent,
                  ),
                  children: [
                    TextSpan(
                      // text: ' : ${widget.homeworkList!.split(":")[1]}',
                      text: '${widget.homeworkList!}',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   margin: EdgeInsets.all(10),
            //   child: Text(
            //     '- ${widget.homeworkList}',
            //     style: TextStyle(
            //       fontWeight: FontWeight.w600,
            //       fontSize: 16,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
