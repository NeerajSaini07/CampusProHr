class ClassListPrevHwNotDoneStatusModel {
  String? classID;
  String? compClass;
  String? noOfStudent;
  String? studentId;
  String? admNo;
  String? stName;
  String? guardianMobileNo;
  String? fatherName;
  String? prsntAddress;
  String? schoolId;
  String? orgId;
  String? sessionId;

  ClassListPrevHwNotDoneStatusModel(
      {this.classID,
      this.compClass,
      this.noOfStudent,
      this.studentId,
      this.admNo,
      this.stName,
      this.guardianMobileNo,
      this.fatherName,
      this.prsntAddress,
      this.schoolId,
      this.orgId,
      this.sessionId});

  ClassListPrevHwNotDoneStatusModel.fromJson(Map<String, dynamic> json) {
    classID = json['ClassID'] != null ? json['ClassID'] : "";
    compClass = json['CompClass'] != null ? json['CompClass'] : "";
    noOfStudent = json['NoOfStudent'] != null ? json['NoOfStudent'] : "";
    studentId = json['StudentId'] != null ? json['StudentId'] : "";
    admNo = json['AdmNo'] != null ? json['AdmNo'] : "";
    stName = json['StName'] != null ? json['StName'] : "";
    guardianMobileNo =
        json['GuardianMobileNo'] != null ? json['GuardianMobileNo'] : "";
    fatherName = json['FatherName'] != null ? json['FatherName'] : "";
    prsntAddress = json['PrsntAddress'] != null ? json['PrsntAddress'] : "";
    schoolId = json['SchoolId'] != null ? json['SchoolId'] : "";
    orgId = json['OrgId'] != null ? json['OrgId'] : "";
    sessionId = json['SessionId'] != null ? json['SessionId'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClassID'] = this.classID;
    data['CompClass'] = this.compClass;
    data['NoOfStudent'] = this.noOfStudent;
    data['StudentId'] = this.studentId;
    data['AdmNo'] = this.admNo;
    data['StName'] = this.stName;
    data['GuardianMobileNo'] = this.guardianMobileNo;
    data['FatherName'] = this.fatherName;
    data['PrsntAddress'] = this.prsntAddress;
    data['SchoolId'] = this.schoolId;
    data['OrgId'] = this.orgId;
    data['SessionId'] = this.sessionId;
    return data;
  }
}
