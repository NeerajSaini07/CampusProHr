import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ExcelReport extends StatefulWidget {
  static const routeName = 'test-test';
  final data;
  final schoolName;
  final className;
  final sectionName;

  const ExcelReport(
      {this.data, this.schoolName, this.className, this.sectionName});

  @override
  _ExcelReportState createState() => _ExcelReportState();
}

class _ExcelReportState extends State<ExcelReport> {
  bool isChecked = false;
  bool isExcelChecked = false;

  Future<void> createExcel() async {
    if (widget.data!.length > 0) {
      // try {
      print(widget.data!.length);

      Map<String, List> PeriodList = {};
      List dateList = [];
      List nameList = [];
      List checkList = [];
      Map<String, List<Map<String, List>>> finalList = {};

      for (var i in widget.data) {
        if (dateList.contains(i.attendanceDate1)) {
        } else {
          dateList.add(i.attendanceDate1);
        }
      }

      for (var i in widget.data) {
        if (PeriodList.containsKey(i.attendanceDate1)) {
          PeriodList[i.attendanceDate1]!.add(i.periodSubject);
        } else {
          PeriodList.addAll({
            i.attendanceDate1: [i.periodSubject]
          });
        }
      }

      // print(PeriodList);
      //
      // for (var i in PeriodList.values) {
      //   print(i.toSet());
      // }

      for (var i in widget.data) {
        if (checkList.contains(i.stName)) {
          finalList[i.stName]!.add({
            i.attendanceDate1: [i.status, i.periodSubject]
          });
          // // print(finalList[i.stName]![int.parse(i.attendanceDate1)]);
          //  finalList[i.stName]![i.attendanceDate1].add({[i.status, i.periodName]
          //  });
        } else {
          checkList.add(i.stName);
          finalList.addAll({
            i.stName: [
              {
                i.attendanceDate1: [i.status, i.periodSubject]
              },
              {
                'Data': [
                  i.admNo,
                  i.className,
                  i.classSection,
                  i.guardianMobileNo
                ]
              }
            ]
          });
        }
      }

      // for (var i in widget.data) {
      //   if (periodsList.contains(i.periodName)) {
      //     periodsList[i.periodName].addAll()
      //   } else {
      //     periodsList.add({i.periodName:i.status});
      //   }
      // }

      // print(nameList);
      // print(PeriodList);
      print(finalList);

      final Workbook workbook = Workbook();
      final Worksheet sheet = workbook.worksheets[0];

      //Todo
      sheet.getRangeByName('C2').setText('${widget.schoolName}');
      sheet.getRangeByName('B3').setText('Class :');
      sheet.getRangeByName('C3').setText('${widget.className}');
      sheet.getRangeByName('D3').setText('${widget.sectionName}');
      //Todo
      sheet.getRangeByName('A5').setText('AdmNo');
      sheet.getRangeByName('B5').setText('StName');
      sheet.getRangeByName('C5').setText('Father\'s Name');
      sheet.getRangeByName('D5').setText('Mobile No');
      sheet.getRangeByName('E5').setText('ClassName');
      sheet.getRangeByName('F5').setText('Section');
      //sheet.getRangeByName('E1').setText('PeriodName');
      var item = 7;
      for (int i = 0; i < dateList.length; i++) {
        //Todo
        var ListDay = PeriodList.keys;
        // for (var j in PeriodList.keys) {
        for (var j in ListDay) {
          // print(j.toSet());
          //print(j);
          if (dateList[i] == j) {
            // for (var z in PeriodList.values){
            //   var setList=z.toSet();
            //   for(var )
            // }
            var setList = PeriodList[j]!.toSet();
            List pdList = setList.toList();
            print(pdList);

            if (pdList.contains(null) == true) {
              pdList.remove(null);
              //print(pdList);
              pdList.sort();
              //print('After sort $pdList');
              var sizeList = pdList.length;
              // print(sizeList);
              // print(dateList[i]);
              for (int v = 0; v < sizeList; v++) {
                sheet.getRangeByIndex(5, item + v).setText(dateList[i]);
              }
              // for (int v = 0; v <= sizeList; v++) {
              //   sheet.getRangeByIndex(2, item + v).setText(pdList[v]);
              // }
              for (int v = 0; v < sizeList; v++) {
                sheet.getRangeByIndex(6, item + v).setText(pdList[v]);
              }

              item += sizeList;
            } else {
              pdList.sort();
              var sizeList = setList.length;
              //print(sizeList);
              for (int v = 0; v < sizeList; v++) {
                sheet.getRangeByIndex(5, item + v).setText(dateList[i]);
              }
              // for (int v = 0; v <= sizeList; v++) {
              //   sheet.getRangeByIndex(2, item + v).setText(pdList[v]);
              // }
              for (int v = 0; v < sizeList; v++) {
                sheet.getRangeByIndex(6, item + v).setText(pdList[v]);
              }

              item += sizeList;
            }
          }
          //sheet.getRangeByIndex(1, 7 + i).setText(dateList[i]);
        }
      }

      for (int i = 8; i < widget.data!.length + 8; i++) {
        // print(widget.data[i - 8].periodSubject);
        if (nameList.contains(widget.data[i - 8]!.stName)) {
          var ind = nameList.indexOf(widget.data[i - 8]!.stName);
          // print(ind);
          for (var v = 7; v < item; v++) {
            // print(sheet.getRangeByIndex(5, v).getText());
            if (sheet.getRangeByIndex(5, v).getText() ==
                widget.data[i - 8]!.attendanceDate1) {
              for (var j = 0; j < 8; j++) {
                if (sheet.getRangeByIndex(5, v + j).getText() ==
                    widget.data[i - 8]!.attendanceDate1) {
                  if (sheet.getRangeByIndex(6, v + j).getText() ==
                      widget.data[i - 8]!.periodSubject) {
                    print(
                        'ind ${widget.data[i - 8]!.stName}--${widget.data[i - 8]!.periodSubject}--${widget.data[i - 8]!.status}');
                    //print(ind + 8);
                    //print(sheet.getRangeByIndex(ind + 8, v + j).getText());
                    // print(i);
                    if (sheet.getRangeByIndex(ind + 8, v + j).getText() ==
                        null) {
                      sheet
                          .getRangeByIndex(ind + 8, v + j)
                          .setText(widget.data[i - 8]!.status);
                    }
                  }
                }
              }
            }
          }
        } else {
          // nameList.add(widget.data[i - 3]!.stName);
          // sheet.getRangeByName('A$i').setText(widget.data[i - 3]!.admNo);
          // sheet.getRangeByName('B$i').setText(widget.data[i - 3]!.stName);
          // sheet.getRangeByName('C$i').setText(widget.data[i - 3]!.fatherName);
          // sheet
          //     .getRangeByName('D$i')
          //     .setText(widget.data[i - 3]!.guardianMobileNo);
          // sheet.getRangeByName('E$i').setText(widget.data[i - 3]!.className);
          // sheet.getRangeByName('F$i').setText(widget.data[i - 3]!.classSection);
          //Todo
          // print(i);
          print(
              'ind ${widget.data[i - 8]!.stName}--${widget.data[i - 8]!.periodSubject}--${widget.data[i - 8]!.status}');
          if (widget.data[i - 8]!.periodSubject != null) {
            nameList.add(widget.data[i - 8]!.stName);
            var ind = nameList.indexOf(widget.data[i - 8]!.stName);
            print(ind);
            var finalInd = ind + 8;
            sheet
                .getRangeByName('A$finalInd')
                .setText(widget.data[i - 8]!.admNo);
            sheet
                .getRangeByName('B$finalInd')
                .setText(widget.data[i - 8]!.stName);
            sheet
                .getRangeByName('C$finalInd')
                .setText(widget.data[i - 8]!.fatherName);
            sheet
                .getRangeByName('D$finalInd')
                .setText(widget.data[i - 8]!.guardianMobileNo);
            sheet
                .getRangeByName('E$finalInd')
                .setText(widget.data[i - 8]!.className);
            sheet
                .getRangeByName('F$finalInd')
                .setText(widget.data[i - 8]!.classSection);

            for (var v = 7; v < item; v++) {
              //print(sheet.getRangeByIndex(5, v).getText());
              if (sheet.getRangeByIndex(5, v).getText() ==
                  widget.data[i - 8]!.attendanceDate1) {
                for (var j = 0; j < 8; j++) {
                  if (sheet.getRangeByIndex(6, v + j).getText() ==
                      widget.data[i - 8]!.periodSubject) {
                    if (sheet.getRangeByIndex(ind + 8, v + j).getText() ==
                        null) {
                      sheet
                          .getRangeByIndex(finalInd, v + j)
                          .setText(widget.data[i - 8]!.status);
                      break;
                    }
                  }
                }
              }
            }
          }

          //sheet.getRangeByName('G$i').setText();
          // widget.data[i-3]!.periodName;
          //widget.data[i-3]!.attendanceDate1
          // for (int v =7;v<item;v++){
          //   widget.data[i-3]!.attendanceDate1 == sheet.getRangeByIndex(1, v,1,item);
          //
          // }
        }
      }
      // print(sheet.getRangeByName('G1').getText());
      //print(item);
      for (var i = 7; i < item; i++) {
        print(sheet.getRangeByIndex(1, i).getText());
      }

      // for (var i in sheet.getRangeByIndex(2, 1,2,item).getText()){
      //
      // }

      // print(sheet);

      final List<int> bytes = workbook.saveAsStream();
      workbook.dispose();

      final String path = (await getApplicationSupportDirectory()).path;

      final String fileName = '$path/Output.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);

      // final _result = await OpenFile.open(fileName);
      // print('Testtttt ${_result.type}');
      // // done

      OpenFile.open(fileName);
      Navigator.pop(context);
      // setState(() {
      //   isExcelChecked = true;
      //   isChecked = true;
      // });

      // OpenFile.open(fileName).whenComplete(() {
      //   setState(() {
      //     isChecked = false;
      //   });
      //   if (isOpen == false) {
      //     setState(() {
      //       isExcelChecked = true;
      //       isChecked = true;
      //     });
      //   } else {
      //     OpenFile.open(fileName);
      //     setState(() {
      //       isChecked = false;
      //     });
      //     Navigator.pop(context);
      //   }
      // });

      // if (OpenFile.open(fileName) == true) {
      //   await OpenFile.open(fileName);
      //   Navigator.pop(context);
      // } else {
      //   setState(() {
      //     isExcelChecked = true;
      //     isChecked = true;
      //   });
      // }
      // Navigator.pop(context);
      // } catch (e) {
      //   print('Helllllllllllllllo');
      //   if (widget.data!.length > 0) {
      //     setState(() {
      //       isExcelChecked = true;
      //       isChecked = true;
      //     });
      //   } else {
      //     setState(() {
      //       isExcelChecked = true;
      //       isChecked = true;
      //     });
      //   }
      //   Text('$e');
      // }
    } else {
      setState(() {
        isChecked = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createExcel();
    //Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: isChecked == false
              ? Text('Back')
              // ? Text('Please download excel to use this feature.')
              : isExcelChecked != true
                  ? Text('No Data')
                  : Text('Please download excel to use this feature.'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
