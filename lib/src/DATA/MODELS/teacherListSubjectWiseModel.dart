class TeacherListSubjectWiseModel {
  int? empId = -1;
  String? name = "";
  String? gender = "";
  String? mobileNo = "";

  TeacherListSubjectWiseModel(
      {this.empId, this.name, this.gender, this.mobileNo});

  TeacherListSubjectWiseModel.fromJson(Map<String, dynamic> json) {
    empId = json['EmpId'] != null ? json['EmpId'] : -1;
    name = json['Name'] != null ? json['Name'] : "";
    gender = json['Gender'] != null ? json['Gender'] : "";
    mobileNo = json['MobileNo'] != null ? json['MobileNo'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmpId'] = this.empId;
    data['Name'] = this.name;
    data['Gender'] = this.gender;
    data['MobileNo'] = this.mobileNo;
    return data;
  }
}
