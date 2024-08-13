class GradeEntryListModel {
  int? studentId = 0;
  String? admNo = '';
  String? stName = '';
  String? rollNo = '';
  String? grade = '';

  GradeEntryListModel(
      {this.studentId, this.admNo, this.stName, this.rollNo, this.grade});

  GradeEntryListModel.fromJson(Map<String, dynamic> json) {
    studentId = json['StudentId'] != null ? json['StudentId'] : "";
    admNo = json['AdmNo'] != null ? json['AdmNo'] : "";
    stName = json['stName'] != null ? json['stName'] : "";
    rollNo = json['RollNo'] != null ? json['RollNo'] : "";
    grade = json['Grade'] != null ? json['Grade'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StudentId'] = this.studentId;
    data['AdmNo'] = this.admNo;
    data['stName'] = this.stName;
    data['RollNo'] = this.rollNo;
    data['Grade'] = this.grade;
    return data;
  }
}
