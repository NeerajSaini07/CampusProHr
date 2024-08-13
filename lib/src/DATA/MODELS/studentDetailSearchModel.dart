class StudentDetailSearchModel {
  String? admNo = '';
  String? stName = '';
  String? fatherName = '';
  String? guardianMobileNo = '';
  String? ouserName = '';
  String? oLoginId = '';
  String? oUserPassword = '';
  String? oUserType = '';
  String? isActive = '';
  String? stuEmpName = '';
  String? ouserID = '';
  String? lastOTP = '';

  StudentDetailSearchModel(
      {this.admNo,
      this.stName,
      this.fatherName,
      this.guardianMobileNo,
      this.ouserName,
      this.oLoginId,
      this.oUserPassword,
      this.oUserType,
      this.isActive,
      this.stuEmpName,
      this.ouserID,
      this.lastOTP});

  StudentDetailSearchModel.fromJson(Map<String, dynamic> json) {
    admNo = json['AdmNo'] != null ? json['AdmNo'] : "";
    stName = json['StName'] != null ? json['StName'] : "";
    fatherName = json['FatherName'] != null ? json['FatherName'] : "";
    guardianMobileNo = json['GuardianMobileNo'] != null ? json['GuardianMobileNo'] : "";
    ouserName = json['OuserName'] != null ? json['OuserName'] : "";
    oLoginId = json['OLoginId'] != null ? json['OLoginId'] : "";
    oUserPassword = json['OUserPassword'] != null ? json['OUserPassword'] : "";
    oUserType = json['OUserType'] != null ? json['OUserType'] : "";
    isActive = json['IsActive'] != null ? json['IsActive'] : "";
    stuEmpName = json['StuEmpName'] != null ? json['StuEmpName'] : "";
    ouserID = json['OuserID'] != null ? json['OuserID'] : "";
    lastOTP = json['LastOTP'] != null ? json['LastOTP'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AdmNo'] = this.admNo;
    data['StName'] = this.stName;
    data['FatherName'] = this.fatherName;
    data['GuardianMobileNo'] = this.guardianMobileNo;
    data['OuserName'] = this.ouserName;
    data['OLoginId'] = this.oLoginId;
    data['OUserPassword'] = this.oUserPassword;
    data['OUserType'] = this.oUserType;
    data['IsActive'] = this.isActive;
    data['StuEmpName'] = this.stuEmpName;
    data['OuserID'] = this.ouserID;
    data['LastOTP'] = this.lastOTP;
    return data;
  }
}
