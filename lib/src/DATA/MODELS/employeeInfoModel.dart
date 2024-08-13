class EmployeeInfoModel {
  int? empId;
  String? empno;
  String? name;
  String? fatherName;
  String? designation;
  String? grout;
  String? dateOfBirth;
  String? gender;
  String? mobileNo;
  String? department;
  int? sessionID;
  String? emailid;
  int? groupType;
  String? baseApiUrl;

  EmployeeInfoModel({
    this.empId,
    this.empno,
    this.name,
    this.fatherName,
    this.designation,
    this.grout,
    this.dateOfBirth,
    this.gender,
    this.mobileNo,
    this.department,
    this.sessionID,
    this.emailid,
    this.groupType,
    this.baseApiUrl,
  });

  EmployeeInfoModel.fromJson(Map<String, dynamic> json) {
    empId = json['EmpId'] != null ? json['EmpId'] : -1;
    empno = json['Empno'] != null ? json['Empno'] : "";
    name = json['Name'] != null ? json['Name'] : "";
    fatherName = json['FatherName'] != null ? json['FatherName'] : "";
    designation = json['Designation'] != null ? json['Designation'] : "";
    grout = json['Grout'] != null ? json['Grout'] : "";
    dateOfBirth = json['DateOfBirth'] != null ? json['DateOfBirth'] : "";
    gender = json['Gender'] != null ? json['Gender'] : "";
    mobileNo = json['MobileNo'] != null ? json['MobileNo'] : "";
    department = json['Department'] != null ? json['Department'] : "";
    sessionID = json['SessionID'] != null ? json['SessionID'] : -1;
    emailid = json['emailid'] != null ? json['emailid'] : "";
    groupType = json['GroupType'] != null ? json['GroupType'] : -1;
    baseApiUrl = json["BaseAPIURL"] != null ? json["BaseAPIURL"] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmpId'] = this.empId;
    data['Empno'] = this.empno;
    data['Name'] = this.name;
    data['FatherName'] = this.fatherName;
    data['Designation'] = this.designation;
    data['Grout'] = this.grout;
    data['DateOfBirth'] = this.dateOfBirth;
    data['Gender'] = this.gender;
    data['MobileNo'] = this.mobileNo;
    data['Department'] = this.department;
    data['SessionID'] = this.sessionID;
    data['emailid'] = this.emailid;
    data['GroupType'] = this.groupType;
    return data;
  }
}
