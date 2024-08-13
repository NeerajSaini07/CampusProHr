class GetStudentListResultAnnounceModel {
  int? studentID = -1;
  String? admNo = "";
  String? stName = "";
  String? fatherName = "";
  String? gender = "";

  GetStudentListResultAnnounceModel(
      {this.studentID, this.admNo, this.stName, this.fatherName, this.gender});

  GetStudentListResultAnnounceModel.fromJson(Map<String, dynamic> json) {
    studentID = json['StudentID'] != null ? json['StudentID'] : "";
    admNo = json['AdmNo'] != null ? json['AdmNo'] : "";
    stName = json['StName'] != null ? json['StName'] : "";
    fatherName = json['FatherName'] != null ? json['FatherName'] : "";
    gender = json['Gender'] != null ? json['Gender'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StudentID'] = this.studentID;
    data['AdmNo'] = this.admNo;
    data['StName'] = this.stName;
    data['FatherName'] = this.fatherName;
    data['Gender'] = this.gender;
    return data;
  }
}
