class StudentListForChangeRollNoModel {
  String? studentId = "";
  String? fatherName = "";
  String? stName = "";
  String? onlyStName = "";
  String? rollNo = "";
  String? examRollNo = "";
  String? admNo = "";
  String? attStatus = "";
  String? gender = "";

  StudentListForChangeRollNoModel(
      this.studentId,
      this.gender,
      this.stName,
      this.fatherName,
      this.examRollNo,
      this.rollNo,
      this.admNo,
      this.attStatus,
      this.onlyStName);

  StudentListForChangeRollNoModel.fromJson(Map<String, dynamic> json) {
    this.studentId = json['StudentId'] != null ? json['StudentId'] : "";
    this.onlyStName = json['OnlyStName'] != null ? json['OnlyStName'] : "";
    this.attStatus = json['AttStatus'] != null ? json['AttStatus'] : "";
    this.admNo = json['AdmNo'] != null ? json['AdmNo'] : "";
    this.rollNo = json['RollNo'] != null ? json['RollNo'] : "";
    this.examRollNo = json['ExamRollNo'] != null ? json['ExamRollNo'] : "";
    this.fatherName = json['FatherName'] != null ? json['FatherName'] : "";
    this.stName = json['StName'] != null ? json['StName'] : "";
    this.gender = json['Gender'] != null ? json['Gender'] : "";
  }
}
