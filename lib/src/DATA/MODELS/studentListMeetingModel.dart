class StudentListMeetingModel {
  int? classsectionid;
  int? yearid;
  int? streamid;
  int? classid;
  String? clsName = '';
  int? studentId;
  String? fatherName = '';
  String? stName = '';
  String? onlyStName = '';
  String? rollNo = '';
  String? admno = '';
  String? gender = '';
  String? guardianMobileNo = '';
  String? emailid = '';
  bool? isSelected = true;

  StudentListMeetingModel(
      {this.classsectionid,
      this.yearid,
      this.streamid,
      this.classid,
      this.clsName,
      this.studentId,
      this.fatherName,
      this.stName,
      this.onlyStName,
      this.rollNo,
      this.admno,
      this.gender,
      this.guardianMobileNo,
      this.emailid,
      this.isSelected});

  StudentListMeetingModel.fromJson(Map<String, dynamic> json) {
    classsectionid =
        json['classsectionid'] != null ? json['classsectionid'] : -1;
    yearid = json['yearid'] != null ? json['yearid'] : -1;
    streamid = json['streamid'] != null ? json['streamid'] : -1;
    classid = json['classid'] != null ? json['classid'] : -1;
    clsName = json['ClsName'] != null ? json['ClsName'] : "";
    studentId = json['StudentId'] != null ? json['StudentId'] : -1;
    fatherName = json['FatherName'] != null ? json['FatherName'] : "";
    stName = json['StName'] != null ? json['StName'] : "";
    onlyStName = json['OnlyStName'] != null ? json['OnlyStName'] : "";
    rollNo = json['RollNo'] != null ? json['RollNo'] : "";
    admno = json['admno'] != null ? json['admno'] : "";
    gender = json['Gender'] != null ? json['Gender'] : "";
    guardianMobileNo =
        json['GuardianMobileNo'] != null ? json['GuardianMobileNo'] : "";
    emailid = json['emailid'] != null ? json['emailid'] : "";
    isSelected = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['classsectionid'] = this.classsectionid;
    data['yearid'] = this.yearid;
    data['streamid'] = this.streamid;
    data['classid'] = this.classid;
    data['ClsName'] = this.clsName;
    data['StudentId'] = this.studentId;
    data['FatherName'] = this.fatherName;
    data['StName'] = this.stName;
    data['OnlyStName'] = this.onlyStName;
    data['RollNo'] = this.rollNo;
    data['admno'] = this.admno;
    data['Gender'] = this.gender;
    data['GuardianMobileNo'] = this.guardianMobileNo;
    data['emailid'] = this.emailid;
    data['isSelected'] = this.isSelected;
    return data;
  }
}
