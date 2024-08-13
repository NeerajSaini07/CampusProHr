import 'package:campus_pro/src/DATA/MODELS/downloadAppUserDataModel.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:convert';

import 'package:universal_html/html.dart' show AnchorElement;

Future<void> createExcel(
    {List<String>? headingList,
    List<DownloadAppUserDataModel>? dataList}) async {
  final Workbook workbook = Workbook();
  final Worksheet sheet = workbook.worksheets[0];

  for (int i = 0; i < headingList!.length; i++) {
    sheet.getRangeByName("${letters[i]}3").setText(headingList[i]);
  }

  int setFrom = 4;
  for (int i = 0; i < dataList!.length; i++) {
    for (int j = 0; j < headingList.length; j++) {
      sheet.getRangeByName("${letters[j]}$setFrom").setText(j == 0
          ? dataList[i].admno
          : j == 1
              ? dataList[i].stname
              : j == 2
                  ? dataList[i].fatherName
                  : j == 3
                      ? dataList[i].oLoginid
                      : dataList[i].ouserpassword);
    }
    setFrom = setFrom + 1;
  }
  //
  // for (var i = 0; i < dataList!.length; i++) {
  //   for (var j = 0; j < headingList!.length; j++) {
  //     print("${letters[j]}${number[i]} - ${dataList[i][j]}");
  //     sheet.getRangeByName("${letters[j]}${number[i]}").setText(dataList[i][j]);
  //   }
  // }
  //
  final List<int> bytes = workbook.saveAsStream();
  workbook.dispose();

  if (kIsWeb) {
    AnchorElement(
        href:
            'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
      ..setAttribute('download', 'Output.xlsx')
      ..click();
  } else {
    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName =
        Platform.isWindows ? '$path\\Output.xlsx' : '$path/Output.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);
  }
}

class ExcelModel {
  List<String>? headings = [];
  List<List<String>>? tableRows = [];

  ExcelModel({this.headings, this.tableRows});

  @override
  String toString() {
    return "{headings: $headings, tableRows: $tableRows}";
  }
}

List<String> number = [for (var i = 4; i <= 1000; i++) i.toString()];

List<String> letters = [
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
  "M",
  "N",
  "O",
  "P",
  "Q",
  "R",
  "S",
  "T",
  "U",
  "V",
  "W",
  "X",
  "Y",
  "Z"
];
