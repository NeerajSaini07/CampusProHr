class GetExamMarksForTeacherModel {
  String? studentId;
  String? rollNo;
  String? admNo;
  String? examRollNo;
  String? studentName;
  String? fatherName;
  String? internalMarks;
  String? marksObt;
  String? practical;
  String? homeWork;

  GetExamMarksForTeacherModel(
      {this.rollNo,
      this.internalMarks,
      this.admNo,
      this.fatherName,
      this.studentId,
      this.studentName,
      this.examRollNo,
      this.homeWork,
      this.marksObt,
      this.practical});

  GetExamMarksForTeacherModel.fromJson(Map<String, dynamic> json) {
    this.practical = json['Practical'] != null ? json['Practical'] : "";
    this.marksObt = json['marksobtain'] != null ? json['marksobtain'] : "";
    this.homeWork = json['Homework'] != null ? json['Homework'] : "";
    this.examRollNo = json['examrollno'] != null ? json['examrollno'] : "";
    this.studentName = json['StudentName'] != null ? json['StudentName'] : "";
    this.studentId = json['StudentId'] != null ? json['StudentId'] : "";
    this.fatherName = json['FatherName'] != null ? json['FatherName'] : "";
    this.admNo = json['AdmissionNo'] != null ? json['AdmissionNo'] : "";
    this.rollNo = json['RollNo'] != null ? json['RollNo'] : "";
    this.internalMarks =
        json['internalmarks'] != null ? json['internalmarks'] : "";
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['internalmarks'] = this.internalMarks;
    data['RollNo'] = this.rollNo;
    data['AdmissionNo'] = this.admNo;
    data['FatherName'] = this.fatherName;
    data['StudentId'] = this.studentId;
    data['StudentName'] = this.studentName;
    data['examrollno'] = this.examRollNo;
    data['Homework'] = this.homeWork;
    data['marksobtain'] = this.marksObt;
    data['Practical'] = this.practical;
    return data;
  }

  @override
  String toString() {
    return "{admNo: $admNo, studentId: $studentId, marksObt: $marksObt, practical: $practical, homeWork: $homeWork, internalMarks: $internalMarks}, ";
  }
}
