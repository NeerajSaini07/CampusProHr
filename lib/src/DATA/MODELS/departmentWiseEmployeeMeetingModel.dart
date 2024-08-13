class DepartmentWiseEmployeeMeetingModel {
  int? empId = 0;
  String? empno = '';
  String? name = '';
  String? paramName = '';
  String? gender = '';
  String? emailId = '';

  DepartmentWiseEmployeeMeetingModel(
      {this.empId, this.empno, this.name, this.paramName, this.gender});

  DepartmentWiseEmployeeMeetingModel.fromJson(Map<String, dynamic> json) {
    empId = json['EmpId'] != null ? json['EmpId'] : -1;
    empno = json['Empno'] != null ? json['Empno'] : "";
    name = json['Name'] != null ? json['Name'] : "";
    paramName = json['ParamName'] != null ? json['ParamName'] : "";
    gender = json['Gender'] != null ? json['Gender'] : "";
    emailId = json['EmailId'] != null ? json['EmailId'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmpId'] = this.empId;
    data['Empno'] = this.empno;
    data['Name'] = this.name;
    data['ParamName'] = this.paramName;
    data['Gender'] = this.gender;
    data['EmailId'] = this.emailId;
    return data;
  }
}
