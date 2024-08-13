import 'package:campus_pro/src/DATA/MODELS/examMarksChartModel.dart';
// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

class ExamDetailChart extends StatefulWidget {
  final List<ExamMarksChartModel>? examMarksChart;
  const ExamDetailChart({Key? key, this.examMarksChart}) : super(key: key);

  @override
  _ExamDetailChartState createState() => _ExamDetailChartState();
}

class _ExamDetailChartState extends State<ExamDetailChart> {
  final List<MarksGraph> obtainedMarksList = [];
  final List<MarksGraph> highestMarksList = [];
  // List<Series<OrdinalSales, String>> seriesList;

  @override
  void initState() {
    widget.examMarksChart!.forEach((element) => obtainedMarksList.add(
        MarksGraph(element.subjectName!, double.parse(element.marksObtain!))));
    widget.examMarksChart!.forEach((element) => highestMarksList.add(
        MarksGraph(element.subjectName!, double.parse(element.maxObtained!))));
    super.initState();
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
            "Individual/Highest Marks In Class",
            // textScaleFactor: 1.5,
            // style: Theme.of(context).textTheme.headline5,
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
                  color: Colors.red,
                ),
                SizedBox(width: 8),
                Text(
                  "Obtained",
                  // textScaleFactor: 1.0,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 20,
                  width: 40,
                  color: Colors.green[800],
                ),
                SizedBox(width: 8),
                Text(
                  "Highest",
                  // textScaleFactor: 1.0,
                  style: TextStyle(fontSize: 16),
                ),
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
          //       obtainedMarksData: obtainedMarksList,
          //       highestMarksData: highestMarksList),
          //   animate: true,
          //   barGroupingType: charts.BarGroupingType.grouped,
          //   barRendererDecorator: new charts.BarLabelDecorator(
          //       insideLabelStyleSpec: new charts.TextStyleSpec(
          //           color: charts.MaterialPalette.white),
          //       outsideLabelStyleSpec: new charts.TextStyleSpec(
          //           color: charts.MaterialPalette.black)),
          // ),
        ),
      ],
    );
  }

  /// Create series list with multiple series
//   static List<charts.Series<MarksGraph, String>> _createSampleData(
//       {List<MarksGraph>? obtainedMarksData,
//       List<MarksGraph>? highestMarksData}) {
//     // examMarksChart!
//     //     .forEach((element) => obtainedMarksData.add(MarksGraph('Hindi', 5)));
//     // final obtainedMarksData = [
//     //   new MarksGraph('Hindi', 5),
//     // ];
//
//     // final highestMarksData = [
//     //   new MarksGraph('Hindi', 25),
//     // ];
//
//     return [
//       new charts.Series<MarksGraph, String>(
//         id: 'Obtained',
//         domainFn: (MarksGraph marks, _) => marks.subjectName,
//         measureFn: (MarksGraph marks, _) => marks.value,
//         data: obtainedMarksData!,
//         colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.red),
//         labelAccessorFn: (MarksGraph marks, _) =>
//             '${double.tryParse(marks.value.toString())!.toInt()}',
//       ),
//       new charts.Series<MarksGraph, String>(
//         id: 'Highest',
//         domainFn: (MarksGraph marks, _) => marks.subjectName,
//         measureFn: (MarksGraph marks, _) => marks.value,
//         data: highestMarksData!,
//         colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.green[800]!),
//         labelAccessorFn: (MarksGraph marks, _) =>
//             '${double.tryParse(marks.value.toString())!.toInt()}',
//       ),
//     ];
//   }
}

/// Sample ordinal data type.
class MarksGraph {
  final String subjectName;
  final double value;

  MarksGraph(this.subjectName, this.value);
}

// class ExamDetailChart extends StatefulWidget {
//   final List<ExamMarksChartModel>? examMarksChart;

//   const ExamDetailChart({Key? key, this.examMarksChart}) : super(key: key);
//   @override
//   State<StatefulWidget> createState() => ExamDetailChartState();
// }

// class ExamDetailChartState extends State<ExamDetailChart> {
//   final Color leftBarColor = Colors.red[400]!;
//   final Color rightBarColor = Colors.green[400]!;
//   final double width = 50;
//   final int value = 0;

//   late List<BarChartGroupData> rawBarGroups = [];
//   late List<BarChartGroupData> showingBarGroups = [];

//   int touchedGroupIndex = -1;

//   @override
//   void initState() {
//     super.initState();
//     widget.examMarksChart!.forEach((element) {
//       rawBarGroups.add(makeGroupData(
//           1 + value,
//           double.parse(element.avgObtained!),
//           double.parse(element.maxObtained!)));
//     });
//     // final barGroup1 = makeGroupData(0, 5, 12);
//     // final barGroup2 = makeGroupData(1, 16, 12);
//     // final barGroup3 = makeGroupData(2, 18, 5);
//     // final barGroup4 = makeGroupData(3, 20, 16);
//     // final barGroup5 = makeGroupData(4, 17, 6);
//     // final barGroup6 = makeGroupData(5, 19, 1.5);
//     // final barGroup7 = makeGroupData(6, 10, 16);
//     // final barGroup8 = makeGroupData(7, 10, 15);

//     // final items = [
//     //   barGroup1,
//     //   barGroup2,
//     //   barGroup3,
//     //   barGroup4,
//     //   barGroup5,
//     //   barGroup6,
//     //   barGroup7,
//     //   barGroup8,
//     // ];

//     // rawBarGroups = items;

//     showingBarGroups = rawBarGroups;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1,
//       child: Container(
//         padding: const EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//             // border: Border.all(color: Color(0xffDBDBDB)),
//             // color: Colors.white,
//             ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisAlignment: MainAxisAlignment.start,
//           mainAxisSize: MainAxisSize.max,
//           children: <Widget>[
//             Text(
//               "Individual/Highest Marks In Class",
//               textScaleFactor: 1.5,
//               style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14),
//             ),
//             Divider(),
//             Container(
//               // color: Colors.blue,
//               height: 40,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                     height: 20,
//                     width: 40,
//                     color: Colors.red,
//                   ),
//                   Text("Obtained",
//                       style: TextStyle(color: Color(0xff7589a2), fontSize: 16)),
//                   SizedBox(width: 20),
//                   Container(
//                     height: 20,
//                     width: 40,
//                     color: Colors.green,
//                   ),
//                   Text("Highest",
//                       style: TextStyle(color: Color(0xff7589a2), fontSize: 16)),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: BarChart(
//                   BarChartData(
//                     maxY: 100,
//                     barTouchData: BarTouchData(
//                         touchTooltipData: BarTouchTooltipData(
//                           tooltipBgColor: Colors.grey,
//                           getTooltipItem: (_a, _b, _c, _d) => null,
//                         ),
//                         touchCallback: (response) {
//                           if (response.spot == null) {
//                             setState(() {
//                               touchedGroupIndex = -1;
//                               showingBarGroups = List.of(rawBarGroups);
//                             });
//                             return;
//                           }

//                           touchedGroupIndex =
//                               response.spot!.touchedBarGroupIndex;

//                           setState(() {
//                             if (response.touchInput is PointerExitEvent ||
//                                 response.touchInput is PointerUpEvent) {
//                               touchedGroupIndex = -1;
//                               showingBarGroups = List.of(rawBarGroups);
//                             } else {
//                               showingBarGroups = List.of(rawBarGroups);
//                               if (touchedGroupIndex != -1) {
//                                 var sum = 0.0;
//                                 for (var rod
//                                     in showingBarGroups[touchedGroupIndex]
//                                         .barRods) {
//                                   sum += rod.y;
//                                 }
//                                 final avg = sum /
//                                     showingBarGroups[touchedGroupIndex]
//                                         .barRods
//                                         .length;

//                                 showingBarGroups[touchedGroupIndex] =
//                                     showingBarGroups[touchedGroupIndex]
//                                         .copyWith(
//                                   barRods: showingBarGroups[touchedGroupIndex]
//                                       .barRods
//                                       .map((rod) {
//                                     return rod.copyWith(y: avg);
//                                   }).toList(),
//                                 );
//                               }
//                             }
//                           });
//                         }),
//                     titlesData: FlTitlesData(
//                       show: true,
//                       bottomTitles: SideTitles(
//                         showTitles: true,
//                         getTextStyles: (value) => const TextStyle(
//                             color: Color(0xff7589a2),
//                             fontWeight: FontWeight.bold,
//                             fontSize: 10),
//                         margin: 20,
//                         getTitles: (double value) {
//                           for (int i = 0;
//                               i < widget.examMarksChart!.length;
//                               i++)
//                             return widget.examMarksChart![i].subjectName!;
//                           return '';
//                           // widget.examMarksChart!
//                           //     .forEach((element) => element.subjectName);

//                           // switch (value.toInt()) {

//                           //   // case 0:
//                           //   //   return 'Computer';
//                           //   // case 1:
//                           //   //   return 'G.K.';
//                           //   // case 2:
//                           //   //   return 'Art & Crafts';
//                           //   // case 3:
//                           //   //   return 'E.V.S.';
//                           //   // case 4:
//                           //   //   return 'English';
//                           //   // case 5:
//                           //   //   return 'M.E.';
//                           //   // case 6:
//                           //   //   return 'Hindi';
//                           //   // case 7:
//                           //   //   return 'Maths';
//                           //   // default:
//                           //   //   return '';
//                           // }
//                         },
//                       ),
//                       leftTitles: SideTitles(
//                         showTitles: true,
//                         getTextStyles: (value) => const TextStyle(
//                             color: Color(0xff7589a2),
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14),
//                         margin: 20,
//                         reservedSize: 10,
//                         getTitles: (value) {
//                           if (value == 0) {
//                             return '0';
//                           } else if (value == 20) {
//                             return '20';
//                           } else if (value == 40) {
//                             return '40';
//                           } else if (value == 60) {
//                             return '60';
//                           } else if (value == 80) {
//                             return '80';
//                           } else if (value == 100) {
//                             return '100';
//                           } else {
//                             return '';
//                           }
//                         },
//                       ),
//                     ),
//                     borderData: FlBorderData(
//                       show: true,
//                     ),
//                     barGroups: showingBarGroups,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 12,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   BarChartGroupData makeGroupData(int x, double y1, double y2) {
//     return BarChartGroupData(
//       barsSpace: 4,
//       x: x,
//       barRods: [
//         BarChartRodData(
//           borderRadius: BorderRadius.zero,
//           y: y1,
//           colors: [leftBarColor],
//           width: width,
//         ),
//         BarChartRodData(
//           borderRadius: BorderRadius.zero,
//           y: y2,
//           colors: [rightBarColor],
//           width: width,
//         ),
//       ],
//     );
//   }
// }
