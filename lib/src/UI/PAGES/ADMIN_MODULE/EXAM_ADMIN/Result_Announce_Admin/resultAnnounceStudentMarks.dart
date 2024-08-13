import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:flutter/material.dart';

class ResultAnnounceStudentMarks extends StatefulWidget {
  final classItemList;
  static const routeName = '/Result-Announce-StudentMarks';
  ResultAnnounceStudentMarks({this.classItemList});

  @override
  _ResultAnnounceStudentMarksState createState() =>
      _ResultAnnounceStudentMarksState();
}

class _ResultAnnounceStudentMarksState
    extends State<ResultAnnounceStudentMarks> {
  List? classList;

  @override
  void initState() {
    super.initState();
    classList = widget.classItemList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'Class List'),
      body: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: 10,
        ),
        itemCount: classList!.length,
        itemBuilder: (context, index) {
          var item = classList![index];
          return Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 0.2),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['Subject'].toUpperCase(),
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      item['TeacherName'].toUpperCase(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueAccent),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.009,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Entered : ${item['TotalMarksEntered']}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Published : ${item['ResultAnnounced']}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
