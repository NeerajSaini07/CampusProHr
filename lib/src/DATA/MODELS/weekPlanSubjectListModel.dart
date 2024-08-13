import 'package:flutter/material.dart';

class WeekPlanSubjectListModel {
  String? subjectId = '';
  String? subjectHead = '';

  WeekPlanSubjectListModel({this.subjectId, this.subjectHead});

  WeekPlanSubjectListModel.fromJson(Map<String, dynamic> json) {
    subjectId = json['SubjectId'] != null ? json['SubjectId'] : "";
    subjectHead = json['SubjectHead'] != null ? json['SubjectHead'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SubjectId'] = this.subjectId;
    data['SubjectHead'] = this.subjectHead;
    return data;
  }
}
