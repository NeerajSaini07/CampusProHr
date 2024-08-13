class LoadStudentForSubjectListModel {
  String? studentDetailId = "";
  String? admNo = "";
  String? examRollNo = "";
  String? stName = "";
  String? fatherName = "";
  String? term1Grade = "";
  String? term2Grade = "";

  LoadStudentForSubjectListModel(this.admNo, this.stName, this.examRollNo,
      this.fatherName, this.studentDetailId, this.term1Grade, this.term2Grade);

  LoadStudentForSubjectListModel.fromJson(Map<String, dynamic> json) {
    studentDetailId = json['StudentDetailID'];
    admNo = json['AdmNo'];
    examRollNo = json['ExamRollNo'];
    stName = json['StName'];
    fatherName = json['FatherName'];
    term1Grade = json['Term1Grade'];
    term2Grade = json['Term2Grade'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['StudentDetailID'] = studentDetailId;
    data['AdmNo'] = admNo;
    data['ExamRollNo'] = examRollNo;
    data['StName'] = stName;
    data['FatherName'] = fatherName;
    data['Term1Grade'] = term1Grade;
    data['Term2Grade'] = term2Grade;
    return data;
  }
}
