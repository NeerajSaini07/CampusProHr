class MarkAttendanceListEmployeeModel {
  String? studentId = "";
  String? fatherName = "";
  String? stName = "";
  String? rollNo = "";
  String? examRollNo = "";
  String? admNo = "";
  String? attStatus = "";

  MarkAttendanceListEmployeeModel(
      {this.studentId,
      this.fatherName,
      this.stName,
      this.rollNo,
      this.examRollNo,
      this.admNo,
      this.attStatus});

  MarkAttendanceListEmployeeModel.fromJson(Map<String, dynamic> json) {
    studentId = json['StudentId'] != null ? json['StudentId'] : "";
    fatherName = json['FatherName'] != null ? json['FatherName'] : "";
    stName = json['StName'] != null ? json['StName'] : "";
    rollNo = json['RollNo'] != null ? json['RollNo'] : "";
    examRollNo = json['ExamRollNo'] != null ? json['ExamRollNo'] : "";
    admNo = json['AdmNo'] != null ? json['AdmNo'] : "";
    attStatus = json['AttStatus'] != null ? json['AttStatus'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StudentId'] = this.studentId;
    data['FatherName'] = this.fatherName;
    data['StName'] = this.stName;
    data['RollNo'] = this.rollNo;
    data['ExamRollNo'] = this.examRollNo;
    data['AdmNo'] = this.admNo;
    data['AttStatus'] = this.attStatus;
    return data;
  }
}
