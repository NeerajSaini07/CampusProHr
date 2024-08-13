class StudentInfoModel {
  String? authCheck = "";
  String? schoolname = "";
  String? schoolAddress = "";
  String? sessionId = "";
  String? sessionStr = "";
  String? studentId = "";
  String? admNo = "";
  String? stName = "";
  String? fatherName = "";
  String? gender = "";
  String? dOB = "";
  String? compClass = "";
  String? classId = "";
  String? streamId = "";
  String? yearId = "";
  String? mobile = "";
  String? classSectionId = "";
  String? retMessage = "";
  String? attStatus = "";
  String? imageUrl = "";
  String? showFeeReceipt = "";
  String? emailId = "";

  StudentInfoModel(
      {this.authCheck,
      this.schoolname,
      this.schoolAddress,
      this.sessionId,
      this.sessionStr,
      this.studentId,
      this.admNo,
      this.stName,
      this.fatherName,
      this.gender,
      this.dOB,
      this.compClass,
      this.classId,
      this.streamId,
      this.yearId,
      this.mobile,
      this.classSectionId,
      this.retMessage,
      this.attStatus,
      this.imageUrl,
      this.showFeeReceipt,
      this.emailId});

  StudentInfoModel.fromJson(Map<String, dynamic> json) {
    authCheck = json['AuthCheck'] != null ? json['AuthCheck'] : "";
    schoolname = json['Schoolname'] != null ? json['Schoolname'] : "";
    schoolAddress = json['SchoolAddress'] != null ? json['SchoolAddress'] : "";
    sessionId = json['SessionId'] != null ? json['SessionId'] : "";
    sessionStr = json['SessionStr'] != null ? json['SessionStr'] : "";
    studentId = json['StudentId'] != null ? json['StudentId'] : "";
    admNo = json['AdmNo'] != null ? json['AdmNo'] : "";
    stName = json['StName'] != null ? json['StName'] : "";
    fatherName = json['FatherName'] != null ? json['FatherName'] : "";
    gender = json['Gender'] != null ? json['Gender'] : "";
    dOB = json['DOB'] != null ? json['DOB'] : "";
    compClass = json['CompClass'] != null ? json['CompClass'] : "";
    classId = json['ClassId'] != null ? json['ClassId'] : "";
    streamId = json['StreamId'] != null ? json['StreamId'] : "";
    yearId = json['YearId'] != null ? json['YearId'] : "";
    mobile = json['Mobile'] != null ? json['Mobile'] : "";
    classSectionId =
        json['ClassSectionId'] != null ? json['ClassSectionId'] : "";
    retMessage = json['RetMessage'] != null ? json['RetMessage'] : "";
    attStatus = json['AttStatus'] != null ? json['AttStatus'] : "";
    imageUrl = json['imageUrl'] != null ? json['imageUrl'] : "";
    showFeeReceipt =
        json['showFeeReceipt'] != null ? json['showFeeReceipt'] : "";
    emailId = json['emailid'] != null ? json['emailid'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AuthCheck'] = this.authCheck;
    data['Schoolname'] = this.schoolname;
    data['SchoolAddress'] = this.schoolAddress;
    data['SessionId'] = this.sessionId;
    data['SessionStr'] = this.sessionStr;
    data['StudentId'] = this.studentId;
    data['AdmNo'] = this.admNo;
    data['StName'] = this.stName;
    data['FatherName'] = this.fatherName;
    data['Gender'] = this.gender;
    data['DOB'] = this.dOB;
    data['CompClass'] = this.compClass;
    data['ClassId'] = this.classId;
    data['StreamId'] = this.streamId;
    data['YearId'] = this.yearId;
    data['Mobile'] = this.mobile;
    data['ClassSectionId'] = this.classSectionId;
    data['RetMessage'] = this.retMessage;
    data['AttStatus'] = this.attStatus;
    data['imageUrl'] = this.imageUrl;
    data['showFeeReceipt'] = this.showFeeReceipt;
    data['emailid'] = this.emailId;
    return data;
  }
}
