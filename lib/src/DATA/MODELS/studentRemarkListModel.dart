class StudentRemarkListModel {
  String? remark = '';
  String? id = '';
  String? studentId = '';
  String? guardianMobileNo = '';
  String? stName = '';
  String? compClass = '';
  String? fatherName = '';
  String? sessionId = '';
  String? addedOnDate = '';
  String? empName = '';
  String? empMobileNo = '';
  String? extraRemark = '';

  StudentRemarkListModel(
      {this.remark,
      this.id,
      this.studentId,
      this.guardianMobileNo,
      this.stName,
      this.compClass,
      this.fatherName,
      this.sessionId,
      this.addedOnDate,
      this.empName,
      this.empMobileNo,
      this.extraRemark});

  StudentRemarkListModel.fromJson(Map<String, dynamic> json) {
    remark = json['Remark'] != null ? json['Remark'] : "";
    id = json['Id'] != null ? json['Id'] : "";
    studentId = json['StudentId'] != null ? json['StudentId'] : "";
    guardianMobileNo =
        json['GuardianMobileNo'] != null ? json['GuardianMobileNo'] : "";
    stName = json['StName'] != null ? json['StName'] : "";
    compClass = json['CompClass'] != null ? json['CompClass'] : "";
    fatherName = json['FatherName'] != null ? json['FatherName'] : "";
    sessionId = json['SessionId'] != null ? json['SessionId'] : "";
    addedOnDate = json['AddedOnDate'] != null ? json['AddedOnDate'] : "";
    empName = json['EmpName'] != null ? json['EmpName'] : "";
    empMobileNo = json['EmpMobileNo'] != null ? json['EmpMobileNo'] : "";
    extraRemark = json['ExtraRemark'] != null ? json['ExtraRemark'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Remark'] = this.remark;
    data['Id'] = this.id;
    data['StudentId'] = this.studentId;
    data['GuardianMobileNo'] = this.guardianMobileNo;
    data['StName'] = this.stName;
    data['CompClass'] = this.compClass;
    data['FatherName'] = this.fatherName;
    data['SessionId'] = this.sessionId;
    data['AddedOnDate'] = this.addedOnDate;
    data['EmpName'] = this.empName;
    data['EmpMobileNo'] = this.empMobileNo;
    data['ExtraRemark'] = this.extraRemark;
    return data;
  }
}
