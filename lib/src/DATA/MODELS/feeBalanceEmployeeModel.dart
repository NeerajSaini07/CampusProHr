class FeeBalanceEmployeeModel {
  String? studentID;
  String? admNo;
  String? studentName;
  String? fatherName;
  String? guardianMobileNo;
  String? balAmount;

  FeeBalanceEmployeeModel(
      {this.studentID,
      this.admNo,
      this.studentName,
      this.fatherName,
      this.guardianMobileNo,
      this.balAmount});

  FeeBalanceEmployeeModel.fromJson(Map<String, dynamic> json) {
    studentID = json['StudentID'] != null ? json['StudentID'] : "";
    admNo = json['AdmNo'] != null ? json['AdmNo'] : "";
    studentName = json['StudentName'] != null ? json['StudentName'] : "";
    fatherName = json['FatherName'] != null ? json['FatherName'] : "";
    guardianMobileNo =
        json['GuardianMobileNo'] != null ? json['GuardianMobileNo'] : "";
    balAmount = json['BalAmount'] != null ? json['BalAmount'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StudentID'] = this.studentID;
    data['AdmNo'] = this.admNo;
    data['StudentName'] = this.studentName;
    data['FatherName'] = this.fatherName;
    data['GuardianMobileNo'] = this.guardianMobileNo;
    data['BalAmount'] = this.balAmount;
    return data;
  }
}
