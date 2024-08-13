import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/attendanceGraphModel.dart';
import 'package:campus_pro/src/DATA/MODELS/examMarksChartModel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class AttendanceBarChart extends StatefulWidget {
  final List<AttendanceGraphModel>? attendanceChart;
  const AttendanceBarChart({Key? key, this.attendanceChart}) : super(key: key);

  @override
  _AttendanceBarChartState createState() => _AttendanceBarChartState();
}

class _AttendanceBarChartState extends State<AttendanceBarChart> {
  final List<String> monthList = [];
  List<AttendanceGraph> presentList = [];
  final List<AttendanceGraph> absentList = [];
  final List<AttendanceGraph> leaveList = [];

  @override
  void initState() {
    List<int> demoMonth = [];
    widget.attendanceChart!.forEach((element) {
      // demoMonth.add(int.parse(element.attDate!.split('/')[0]));
      demoMonth.add(int.parse(element.attDate!.split('-')[1]));
    });
    final trimList = demoMonth.toSet().toList();
    trimList.sort();

    for (int i = 0; i < trimList.length; i++) {
      List<AttendanceGraphModel> present = [];
      present.addAll(widget.attendanceChart!
          .where((element) =>
              // int.parse(element.attDate!.split('/')[0]) == trimList[i] &&
              int.parse(element.attDate!.split('-')[1]) == trimList[i] &&
              element.attStatus!.toUpperCase() == "Y")
          .toList());
      final monthName = findMonthName(trimList[i].toString());
      presentList.add(AttendanceGraph(monthName, present.length.toDouble()));
    }

    for (int i = 0; i < trimList.length; i++) {
      List<AttendanceGraphModel> absent = [];
      absent.addAll(widget.attendanceChart!
          .where((element) =>
              // int.parse(element.attDate!.split('/')[0]) == trimList[i] &&
              int.parse(element.attDate!.split('-')[1]) == trimList[i] &&
              element.attStatus!.toUpperCase() == "N")
          .toList());
      final monthName = findMonthName(trimList[i].toString());
      absentList.add(AttendanceGraph(monthName, absent.length.toDouble()));
    }

    for (int i = 0; i < trimList.length; i++) {
      List<AttendanceGraphModel> leave = [];
      leave.addAll(widget.attendanceChart!
          .where((element) =>
              // int.parse(element.attDate!.split('/')[0]) == trimList[i] &&
              int.parse(element.attDate!.split('-')[1]) == trimList[i] &&
              element.attStatus!.toUpperCase() == "L")
          .toList());
      final monthName = findMonthName(trimList[i].toString());
      leaveList.add(AttendanceGraph(monthName, leave.length.toDouble()));
    }

    super.initState();
  }

  findMonthName(String monthId) {
    switch (monthId) {
      case "1":
        return 'Jan';
      case "2":
        return 'Feb';
      case "3":
        return 'Mar';
      case "4":
        return 'Apr';
      case "5":
        return 'May';
      case "6":
        return 'June';
      case "7":
        return 'Jul';
      case "8":
        return 'Aug';
      case "9":
        return 'Sep';
      case "10":
        return 'Oct';
      case "11":
        return 'Nov';
      case "12":
        return 'Dec';
      default:
        return '';
    }
  }

  // List<Series<OrdinalSales, String>> seriesList
  // List<Series<dynamic, String*>*>*

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Current Year Attendance Graph",
            // textScaleFactor: 1.5,
            // style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Container(
                  height: 20,
                  width: 40,
                  color: Colors.green[800],
                ),
                SizedBox(width: 8),
                Text("Present", style: commonStyleForText),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 20,
                  width: 40,
                  color: Colors.red,
                ),
                SizedBox(width: 8),
                Text("Absent", style: commonStyleForText),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 20,
                  width: 40,
                  color: Color.fromRGBO(250, 196, 47, 1.0),
                ),
                SizedBox(width: 8),
                Text("Leaves", style: commonStyleForText),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width / 1.5,
          margin: const EdgeInsets.only(left: 10.0),
          // child: new charts.BarChart(
          //   _createSampleData(
          //     presentData: presentList,
          //     absentData: absentList,
          //     leaveData: leaveList,
          //   ),
          //   animate: true,
          //   primaryMeasureAxis: new charts.NumericAxisSpec(
          //     // viewport: charts.NumericExtents(0.0, 30.0),
          //     renderSpec: charts.SmallTickRendererSpec(
          //       axisLineStyle: charts.LineStyleSpec(),
          //       labelRotation: 0,
          //     ),
          //   ),
          //
          //   domainAxis: new charts.OrdinalAxisSpec(
          //     viewport: charts.OrdinalViewport('AePS', 2),
          //     renderSpec: charts.SmallTickRendererSpec(
          //       labelRotation: 0,
          //       // labelRotation: 30,
          //     ),
          //   ),
          //   behaviors: [
          //     // new charts.SeriesLegend(),
          //     new charts.SlidingViewport(),
          //     new charts.PanAndZoomBehavior(),
          //   ],
          //   //behaviors: [new charts.PanAndZoomBehavior()],
          //   // barGroupingType: charts.BarGroupingType.stacked,
          //   barRendererDecorator: new charts.BarLabelDecorator(
          //       insideLabelStyleSpec: new charts.TextStyleSpec(
          //           color: charts.MaterialPalette.white),
          //       outsideLabelStyleSpec: new charts.TextStyleSpec(
          //           color: charts.MaterialPalette.black)),
          //   // animate: true,
          //   // barGroupingType: charts.BarGroupingType.grouped,
          //   // barRendererDecorator: new charts.BarLabelDecorator(
          //   //     insideLabelStyleSpec: new charts.TextStyleSpec(
          //   //         color: charts.MaterialPalette.white),
          //   //     outsideLabelStyleSpec: new charts.TextStyleSpec(
          //   //         color: charts.MaterialPalette.black)),
          // ),
        ),
      ],
    );
  }

  /// Create series list with multiple series
  // static List<charts.Series<AttendanceGraph, String>> _createSampleData(
  //     {List<AttendanceGraph>? presentData,
  //     List<AttendanceGraph>? absentData,
  //     List<AttendanceGraph>? leaveData}) {
  //   print("presentData => $presentData");
  //   print("absentData => $absentData");
  //   print("leaveData => $leaveData");
  //   return [
  //     new charts.Series<AttendanceGraph, String>(
  //       id: 'Present',
  //       domainFn: (AttendanceGraph attendance, _) => attendance.monthName,
  //       measureFn: (AttendanceGraph attendance, _) => attendance.value,
  //       data: presentData!,
  //       colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.green[800]!),
  //       labelAccessorFn: (AttendanceGraph marks, _) =>
  //           '${double.tryParse(marks.value.toString())!.toInt()}',
  //       // colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
  //     ),
  //     new charts.Series<AttendanceGraph, String>(
  //       id: 'Absent',
  //       domainFn: (AttendanceGraph attendance, _) => attendance.monthName,
  //       measureFn: (AttendanceGraph attendance, _) => attendance.value,
  //       data: absentData!,
  //       colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.red),
  //       labelAccessorFn: (AttendanceGraph marks, _) =>
  //           '${double.tryParse(marks.value.toString())!.toInt()}',
  //       // colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
  //     ),
  //     new charts.Series<AttendanceGraph, String>(
  //       id: 'Leave',
  //       domainFn: (AttendanceGraph attendance, _) => attendance.monthName,
  //       measureFn: (AttendanceGraph attendance, _) => attendance.value,
  //       data: leaveData!,
  //       colorFn: (_, __) =>
  //           charts.ColorUtil.fromDartColor(Color.fromRGBO(250, 196, 47, 1.0)),
  //       labelAccessorFn: (AttendanceGraph marks, _) =>
  //           '${double.tryParse(marks.value.toString())!.toInt()}',
  //       // colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
  //     ),
  //   ];
  // }
}

/// Sample ordinal data type.
class AttendanceGraph {
  final String monthName;
  final double value;

  AttendanceGraph(this.monthName, this.value);

  @override
  String toString() {
    return 'monthName: $monthName, value: $value';
  }
}
