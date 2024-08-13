import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExamMarksDetailAdmin extends StatefulWidget {
  static const routeName = '/Exam-Marks-Detail-Admin';
  final String? name;
  final String? rollNo;
  final String? admNo;
  final String? markObt;
  final String? internalMarks;
  final String? practicalMarks;
  final String? homeWorkMarks;
  final String? fatherName;
  ExamMarksDetailAdmin(
      {this.name,
      this.admNo,
      this.rollNo,
      this.homeWorkMarks,
      this.internalMarks,
      this.markObt,
      this.practicalMarks,
      this.fatherName});

  @override
  _ExamMarksDetailAdminState createState() => _ExamMarksDetailAdminState();
}

class _ExamMarksDetailAdminState extends State<ExamMarksDetailAdmin> {
  @override
  void initState() {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    // ));
    // // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    // SystemChrome.setEnabledSystemUIOverlays(
    //     [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: commonAppBar(context, title: 'Student Details'),
      body: CustomPaint(
        painter: CurvePainter(),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/userTypePageBackgroundImage.png"),
            fit: BoxFit.cover,
          )),
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildText(txt: 'Name : '),
                  buildResult(res: '${widget.name}'),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildText(txt: 'Adm. No. :'),
                  buildResult(res: '${widget.admNo}'),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildText(txt: 'Exam Roll No : '),
                  buildResult(res: '${widget.rollNo}'),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildText(txt: 'Marks Obtain :'),
                  buildResult(res: '${widget.markObt}'),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildText(txt: 'Father Name :'),
                  buildResult(res: '${widget.fatherName}'),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildText(txt: 'Internal Marks :'),
                  buildResult(res: '${widget.internalMarks}'),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildText(txt: 'Practical Marks :'),
                  buildResult(res: '${widget.practicalMarks}'),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildText(txt: 'Homework Marks :'),
                  buildResult(res: '${widget.homeWorkMarks}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildResult({String? res}) {
    return Flexible(
      child: Text(
        '$res',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
      ),
    );
  }

  Widget buildText({String? txt}) {
    return Text(
      '$txt',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 17,
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xff2855ae).withOpacity(0.5);
    // paint.color = Color(0xffFF6BF5E0);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 5;
    paint.strokeCap = StrokeCap.round;
    var path = Path();
    path.moveTo(0, size.height * 0.25);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.35,
        size.width * 0.5, size.height * 0.25);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.17, size.width, size.height * 0.25);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
