import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
import 'package:google_fonts/google_fonts.dart';

class BarPieCommonChart extends StatefulWidget {
  final double? width;
  final double? height;
  final String? subjectName;
  final String? chartType;
  final Color? color;
  final String? graphTitle;
  final List<CommonListGraph>? commonDataList;
  const BarPieCommonChart({
    Key? key,
    this.subjectName,
    this.graphTitle,
    this.chartType,
    this.commonDataList,
    this.color,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  _BarPieCommonChartState createState() => _BarPieCommonChartState();
}

class _BarPieCommonChartState extends State<BarPieCommonChart> {
  // List colorsChart = [
  //   charts.ColorUtil.fromDartColor(Color(0xff0CECDD).withOpacity(0.2)),
  //   charts.ColorUtil.fromDartColor(Color(0xffFF2626).withOpacity(0.2)),
  //   charts.ColorUtil.fromDartColor(Color(0xffFFF338).withOpacity(0.2)),
  //   charts.ColorUtil.fromDartColor(Color(0xffFF67E7).withOpacity(0.2)),
  //   charts.ColorUtil.fromDartColor(Color(0xff865439).withOpacity(0.2)),
  //   charts.ColorUtil.fromDartColor(Color(0xffE63E6D).withOpacity(0.2)),
  //   charts.ColorUtil.fromDartColor(Color(0xffA03C78).withOpacity(0.2)),
  //   charts.ColorUtil.fromDartColor(Color(0xff7C83FD).withOpacity(0.2)),
  //   charts.ColorUtil.fromDartColor(Color(0xffFB7AFC).withOpacity(0.2)),
  //   charts.ColorUtil.fromDartColor(Color(0xffBF1363).withOpacity(0.2)),
  //   charts.ColorUtil.fromDartColor(Color(0xffFF96AD).withOpacity(0.2)),
  //   charts.ColorUtil.fromDartColor(Color(0xffE93B81).withOpacity(0.2)),
  //   charts.ColorUtil.fromDartColor(Color(0xff1EAE98).withOpacity(0.2)),
  //   charts.ColorUtil.fromDartColor(Color(0xffE1701A).withOpacity(0.2)),
  //   charts.ColorUtil.fromDartColor(Color(0xffC67ACE).withOpacity(0.2)),
  // ];

  final List<CommonListGraph> commonList = [];
  List<String>? subjectName = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    if (subjectName != null)
      subjectName = widget.subjectName!.split(",").toList();
    widget.commonDataList!.forEach((element) => commonList.add(CommonListGraph(
        iD: element.iD,
        title: element.title,
        value: element.value,
        color: element.color)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        if (widget.color != null || widget.graphTitle != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.color != null)
                Container(
                  height: 20,
                  width: 80,
                  color: widget.color!,
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(widget.graphTitle!,
                    textScaleFactor: 1.0,
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
        SizedBox(height: 20),
        Container(
          width: widget.width ?? MediaQuery.of(context).size.width,
          height: widget.height ?? MediaQuery.of(context).size.width / 1.5,
          margin: const EdgeInsets.only(left: 10.0),
          // child: widget.chartType! == 'stacked bar chart'
          //     ? new charts.BarChart(
          //         _createStackedSampleData(commonListData: commonList),
          //         animate: true,
          //         primaryMeasureAxis: new charts.NumericAxisSpec(
          //           // viewport: charts.NumericExtents(0.0, 30.0),
          //           renderSpec: charts.SmallTickRendererSpec(
          //             axisLineStyle: charts.LineStyleSpec(),
          //             labelRotation: 0,
          //           ),
          //         ),
          //
          //         domainAxis: new charts.OrdinalAxisSpec(
          //           viewport: charts.OrdinalViewport('AePS', 4),
          //           renderSpec: charts.SmallTickRendererSpec(
          //             labelRotation: 30,
          //           ),
          //         ),
          //         behaviors: [
          //           // new charts.SeriesLegend(),
          //           new charts.SlidingViewport(),
          //           new charts.PanAndZoomBehavior(),
          //         ],
          //         //behaviors: [new charts.PanAndZoomBehavior()],
          //         barGroupingType: charts.BarGroupingType.stacked,
          //         barRendererDecorator: new charts.BarLabelDecorator(
          //             insideLabelStyleSpec: new charts.TextStyleSpec(
          //                 color: charts.MaterialPalette.white),
          //             outsideLabelStyleSpec: new charts.TextStyleSpec(
          //                 color: charts.MaterialPalette.black)),
          //       )
          //     : widget.chartType! == 'bar chart'
          //         ? new charts.BarChart(
          //             _createSampleData(commonListData: commonList),
          //             animate: true,
          //             domainAxis: new charts.OrdinalAxisSpec(
          //               renderSpec: charts.SmallTickRendererSpec(
          //                 labelRotation: 45,
          //               ),
          //             ),
          //             barGroupingType: charts.BarGroupingType.grouped,
          //             barRendererDecorator: new charts.BarLabelDecorator(
          //                 insideLabelStyleSpec: new charts.TextStyleSpec(
          //                     color: charts.MaterialPalette.white),
          //                 outsideLabelStyleSpec: new charts.TextStyleSpec(
          //                     color: charts.MaterialPalette.black)),
          //           )
          //         : widget.chartType! == 'bar chart dashboard'
          //             ? new charts.BarChart(
          //                 _createSampleDataDashboard(
          //                     commonListData: commonList),
          //                 animate: true,
          //                 primaryMeasureAxis: new charts.NumericAxisSpec(
          //                     tickProviderSpec:
          //                         new charts.StaticNumericTickProviderSpec(
          //                       <charts.TickSpec<num>>[
          //                         charts.TickSpec<num>(0,
          //                             style: charts.TextStyleSpec(
          //                               color: charts.ColorUtil.fromDartColor(
          //                                   Colors.transparent),
          //                             )),
          //                         // charts.TickSpec<num>(5),
          //                         // charts.TickSpec<num>(10),
          //                       ],
          //                     ),
          //                     renderSpec: charts.SmallTickRendererSpec(
          //                       axisLineStyle: charts.LineStyleSpec(
          //                         color: charts.ColorUtil.fromDartColor(
          //                             Colors.white),
          //                       ),
          //                       labelRotation: 0,
          //                     ),
          //                     showAxisLine: false),
          //                 domainAxis: new charts.OrdinalAxisSpec(
          //                   // scaleSpec: OrdinalScaleSpec(),
          //                   // scaleSpec: charts.SmallTickRendererSpec(
          //                   //   labelStyle: new charts.TextStyleSpec(
          //                   //       color: charts.MaterialPalette.black),
          //                   // ),
          //                   renderSpec: charts.SmallTickRendererSpec(
          //                     axisLineStyle: charts.LineStyleSpec(
          //                       color: charts.ColorUtil.fromDartColor(
          //                           Colors.white),
          //                     ),
          //                     labelRotation: 45,
          //                   ),
          //                 ),
          //                 barGroupingType: charts.BarGroupingType.grouped,
          //                 // barRendererDecorator: new charts.BarLabelDecorator(
          //                 //     insideLabelStyleSpec: new charts.TextStyleSpec(
          //                 //         color: charts.MaterialPalette.white),
          //                 //     outsideLabelStyleSpec: new charts.TextStyleSpec(
          //                 //         color: charts.MaterialPalette.black)),
          //               )
          //             : widget.chartType! == 'label pie chart'
          //                 ? new charts.PieChart(
          //                     _createSampleDataGauge(
          //                         commonListData: commonList),
          //                     animate: true,
          //                     defaultRenderer: new charts.ArcRendererConfig(
          //                         arcWidth: 40,
          //                         arcRendererDecorators: [
          //                           new charts.ArcLabelDecorator()
          //                         ]))
          //                 : widget.chartType! == 'bar chart admission'
          //                     ? new charts.BarChart(
          //                         _createSampleDataBar(
          //                             commonListData: commonList),
          //                         animate: true,
          //                         barGroupingType:
          //                             charts.BarGroupingType.grouped,
          //                         barRendererDecorator:
          //                             new charts.BarLabelDecorator(
          //                                 insideLabelStyleSpec:
          //                                     new charts.TextStyleSpec(
          //                                         color: charts
          //                                             .MaterialPalette.white),
          //                                 outsideLabelStyleSpec:
          //                                     new charts.TextStyleSpec(
          //                                         color: charts
          //                                             .MaterialPalette.black)),
          //                       )
          //                     : widget.chartType! == 'line chart'
          //                         ? new charts.LineChart(
          //                             _createSampleDataLine(
          //                                 commonListData: commonList),
          //                             animate: true,
          //                             defaultRenderer:
          //                                 new charts.LineRendererConfig(
          //                                     includePoints: true),
          //                           )
          //                         : widget.chartType! == 'pie chart'
          //                             ? charts.PieChart(
          //                                 _createSampleData(
          //                                     commonListData: commonList),
          //                                 animate: true,
          //                                 behaviors: [new charts.DatumLegend()],
          //                                 defaultRenderer:
          //                                     new charts.ArcRendererConfig(
          //                                   arcWidth: 100,
          //                                   arcRendererDecorators: [
          //                                     new charts.ArcLabelDecorator(
          //                                         labelPosition: charts
          //                                             .ArcLabelPosition.inside)
          //                                   ],
          //                                 ),
          //                               )
          //                             : Container(),
        ),
      ],
    );
  }

  /// Create one series with sample hard coded data.
  // List<charts.Series<AdmissionGraph, String>> _createStackedSampleData(
  //     {List<CommonListGraph>? commonListData}) {
  //   List<List<AdmissionGraph>> stackedListFinal = [];
  //
  //   for (var i = 0; i < 4; i++) {
  //     List<AdmissionGraph> graphData = [];
  //     final stacked =
  //         commonListData!.where((element) => element.iD == i).toList();
  //     for (var j = 0; j < stacked.length; j++) {
  //       graphData.add(AdmissionGraph(
  //         title: stacked[j].title,
  //         value: stacked[j].value,
  //       ));
  //     }
  //     print("graphData $i => $graphData");
  //     stackedListFinal.add(graphData);
  //   }
  //   return [
  //     for (var i = 0; i < stackedListFinal.length; i++)
  //       new charts.Series<AdmissionGraph, String>(
  //         id: '',
  //         domainFn: (AdmissionGraph data, _) => data.title!,
  //         measureFn: (AdmissionGraph data, _) => data.value,
  //         colorFn: (AdmissionGraph value, _) => stackedChart[i],
  //         data: stackedListFinal[i],
  //         labelAccessorFn: (AdmissionGraph data, _) => data.value.toString(),
  //       ),
  //   ];
  // }

  /// Create one series with sample hard coded data.
  // List<charts.Series<GaugeSegment, String>> _createSampleDataGauge(
  //     {List<CommonListGraph>? commonListData}) {
  //   final data = [
  //     new GaugeSegment('Total', 1, attendanceChart[0]),
  //     new GaugeSegment('New', 1, attendanceChart[1]),
  //     new GaugeSegment('Old', 1, attendanceChart[2]),
  //   ];
  //
  //   return [
  //     new charts.Series<GaugeSegment, String>(
  //       id: 'Segments',
  //       domainFn: (GaugeSegment segment, _) => segment.segment,
  //       measureFn: (GaugeSegment segment, _) => segment.size,
  //       data: data,
  //       colorFn: (GaugeSegment segment, _) => segment.color!,
  //       // colorFn: (GaugeSegment segment, _) =>
  //       //     charts.ColorUtil.fromDartColor(segment.color!),
  //       labelAccessorFn: (GaugeSegment segment, _) => segment.size.toString(),
  //     )
  //   ];
  // }

  /// Create series list with multiple series
  // List<charts.Series<AdmissionGraph, String>> _createSampleDataBar(
  //     {List<CommonListGraph>? commonListData}) {
  //   List<List<AdmissionGraph>> drawBarsFinal = [];
  //
  //   for (var i = 0; i < 3; i++) {
  //     List<AdmissionGraph> barData = [];
  //     final drawBar =
  //         commonListData!.where((element) => element.iD == i).toList();
  //
  //     print("drawBar $i => $drawBar");
  //
  //     for (int j = 0; j < 3; j++) {
  //       barData.add(AdmissionGraph(
  //         title: drawBar[j].title,
  //         value: drawBar[j].value,
  //       ));
  //       print("barData $j => $barData");
  //     }
  //     drawBarsFinal.add(barData);
  //   }
  //
  //   print("drawBarsFinal.length  => $drawBarsFinal");
  //
  //   // drawBarsFinal.add(AdmissionGraph(monthName, present.length.toDouble()));
  //
  //   return [
  //     for (var i = 0; i < drawBarsFinal.length; i++)
  //       new charts.Series<AdmissionGraph, String>(
  //         id: 'Common Bar Admission',
  //         domainFn: (AdmissionGraph value, _) => value.title!,
  //         measureFn: (AdmissionGraph value, _) => value.value,
  //         data: drawBarsFinal[i],
  //         colorFn: (AdmissionGraph value, _) => attendanceChart[i],
  //         // colorFn: (AdmissionGraph marks, _) =>
  //         //     charts.ColorUtil.fromDartColor(Colors.blue),
  //         labelAccessorFn: (AdmissionGraph value, _) =>
  //             '${double.tryParse(value.value.toString())!.toInt()}',
  //       ),
  //   ];
  // }

  // List attendanceChart = [
  //   charts.ColorUtil.fromDartColor(Colors.blue.withOpacity(0.5)),
  //   charts.ColorUtil.fromDartColor(Colors.green.withOpacity(0.5)),
  //   charts.ColorUtil.fromDartColor(Colors.deepOrange.withOpacity(0.5)),
  //   charts.ColorUtil.fromDartColor(Colors.grey.withOpacity(0.5)),
  // ];
  //
  // List stackedChart = [
  //   charts.ColorUtil.fromDartColor(Colors.blue.withOpacity(0.5)),
  //   charts.ColorUtil.fromDartColor(Colors.green.withOpacity(0.5)),
  //   charts.ColorUtil.fromDartColor(Colors.orange.withOpacity(0.5)),
  //   charts.ColorUtil.fromDartColor(Colors.red.withOpacity(0.5)),
  // ];

  /// Create series list with multiple series
  // List<charts.Series<CommonListGraph, String>> _createSampleDataDashboard(
  //     {List<CommonListGraph>? commonListData}) {
  //   return [
  //     new charts.Series<CommonListGraph, String>(
  //       id: 'Common Graph',
  //       domainFn: (CommonListGraph marks, _) => marks.title!,
  //       measureFn: (CommonListGraph marks, _) => marks.value!,
  //       data: commonListData!,
  //       // colorFn: (_, __) => charts.ColorUtil.fromDartColor(
  //       //     Colors.primaries[Random().nextInt(Colors.primaries.length)]),
  //       colorFn: (CommonListGraph marks, _) =>
  //           charts.ColorUtil.fromDartColor(marks.color!),
  //       // labelAccessorFn: (CommonListGraph marks, _) =>
  //       //     '${marks.value.toString()}',
  //     ),
  //   ];
  // }
  //
  // /// Create series list with multiple series
  // List<charts.Series<CommonListGraph, String>> _createSampleData(
  //     {List<CommonListGraph>? commonListData}) {
  //   print("common List Data $commonListData");
  //   return [
  //     new charts.Series<CommonListGraph, String>(
  //       id: 'Common Graph',
  //       domainFn: (CommonListGraph marks, _) => marks.title!,
  //       measureFn: (CommonListGraph marks, _) => marks.value!,
  //       data: commonListData!,
  //       colorFn: (CommonListGraph marks, _) =>
  //           charts.ColorUtil.fromDartColor(marks.color!),
  //       labelAccessorFn: (CommonListGraph marks, _) =>
  //           '${marks.value.toString()}',
  //     ),
  //   ];
  // }
  //
  // List<charts.Series<GraphModel, int>> _createSampleDataLine(
  //     {List<CommonListGraph>? commonListData}) {
  //   List<List<GraphModel>> drawLineFinal = [];
  //
  //   for (var i = 0; i < subjectName!.length; i++) {
  //     List<GraphModel> graphData = [];
  //     final drawLine = commonListData!
  //         .where((element) => element.title == subjectName![i])
  //         .toList();
  //     for (var j = 0; j < drawLine.length; j++) {
  //       graphData.add(GraphModel(
  //         title: j,
  //         value: drawLine[j].value,
  //       ));
  //     }
  //     print("graphData $i => $graphData");
  //     drawLineFinal.add(graphData);
  //   }
  //
  //   return [
  //     for (var i = 0; i < drawLineFinal.length; i++)
  //       new charts.Series<GraphModel, int>(
  //         id: 'Sales',
  //         colorFn: (_, __) => colorsChart[i],
  //         displayName: "Charts",
  //         domainFn: (GraphModel marks, _) => marks.title!,
  //         measureFn: (GraphModel marks, _) => marks.value!,
  //         data: drawLineFinal[i],
  //       ),
  //   ];
  // }
}

class CommonListGraph {
  final int? iD;
  final String? title;
  final double? value;
  final Color? color;

  CommonListGraph({this.iD, this.color, this.title, this.value});

  @override
  String toString() {
    return "{iD : $iD, title : $title, value : $value}";
  }
}

class GraphModel {
  final int? title;
  final double? value;
  final Color? color;

  GraphModel({this.color, this.title, this.value});

  @override
  String toString() {
    return "{title : $title, value : $value, color : $color}";
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

class AdmissionGraph {
  final String? title;
  final double? value;

  AdmissionGraph({this.title, this.value});

  @override
  String toString() {
    return 'title: $title, value: $value';
  }
}

/// Sample data type.
class GaugeSegment {
  final String segment;
  final int size;
  final dynamic color;

  GaugeSegment(this.segment, this.size, this.color);
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
