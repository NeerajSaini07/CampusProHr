class GradesListGradeEntryModel {
  String? grade = '';
  String? remarks = '';

  GradesListGradeEntryModel({this.grade, this.remarks});

  GradesListGradeEntryModel.fromJson(Map<String, dynamic> json) {
    grade = json['Grade'] != null ? json['Grade'] : "";
    remarks = json['Remarks'] != null ? json['Remarks'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Grade'] = this.grade;
    data['Remarks'] = this.remarks;
    return data;
  }
}
