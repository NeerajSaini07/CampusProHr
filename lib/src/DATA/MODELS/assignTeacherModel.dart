class AssignTeacherModel {
  String? teacherid = "";
  String? empID = "";
  String? teacherName = "";
  String? mobileNo = "";

  AssignTeacherModel(
      {this.teacherid, this.empID, this.teacherName, this.mobileNo});

  AssignTeacherModel.fromJson(Map<String, dynamic> json) {
    teacherid = json['Teacherid'] != null ? json['Teacherid'] : "";
    empID = json['EmpID'] != null ? json['EmpID'] : "";
    teacherName = json['TeacherName'] != null ? json['TeacherName'] : "";
    mobileNo = json['MobileNo'] != null ? json['MobileNo'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Teacherid'] = this.teacherid;
    data['EmpID'] = this.empID;
    data['TeacherName'] = this.teacherName;
    data['MobileNo'] = this.mobileNo;
    return data;
  }
}
