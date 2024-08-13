class ClassroomEmployeeModel {
  String? classId = '';
  String? sectionId = '';
  String? streamId = '';
  String? yearId = '';
  String? eMPID = '';
  String? circularId = '';
  String? cirNo = '';
  String? circularDate = '';
  String? cirSubject = '';
  String? cirContent = '';
  String? forStuEmp = '';
  String? meetingId = '';
  String? circularFileurl = '';
  String? schoolid = '';
  String? organizationid = '';
  String? sessionid = '';
  String? iSACTIVE = '';
  String? stuid = '';
  String? stName = '';
  String? combName = '';
  String? subjectName = '';

  ClassroomEmployeeModel(
      {this.classId,
      this.sectionId,
      this.streamId,
      this.yearId,
      this.eMPID,
      this.circularId,
      this.cirNo,
      this.circularDate,
      this.cirSubject,
      this.cirContent,
      this.forStuEmp,
      this.meetingId,
      this.circularFileurl,
      this.schoolid,
      this.organizationid,
      this.sessionid,
      this.iSACTIVE,
      this.stuid,
      this.stName,
      this.combName,
      this.subjectName});

  ClassroomEmployeeModel.fromJson(Map<String, dynamic> json) {
    classId = json['ClassId'] != null ? json['ClassId'] : "";
    sectionId = json['SectionId'] != null ? json['SectionId'] : "";
    streamId = json['StreamId'] != null ? json['StreamId'] : "";
    yearId = json['YearId'] != null ? json['YearId'] : "";
    eMPID = json['EMPID'] != null ? json['EMPID'] : "";
    circularId = json['CircularId'] != null ? json['CircularId'] : "";
    cirNo = json['CirNo'] != null ? json['CirNo'] : "";
    circularDate = json['CircularDate'] != null ? json['CircularDate'] : "";
    cirSubject = json['CirSubject'] != null ? json['CirSubject'] : "";
    cirContent = json['CirContent'] != null ? json['CirContent'] : "";
    forStuEmp = json['ForStuEmp'] != null ? json['ForStuEmp'] : "";
    meetingId = json['MeetingId'] != null ? json['MeetingId'] : "";
    circularFileurl = json['CircularFileurl'] != null ? json['CircularFileurl'] : "";
    schoolid = json['schoolid'] != null ? json['schoolid'] : "";
    organizationid = json['organizationid'] != null ? json['organizationid'] : "";
    sessionid = json['sessionid'] != null ? json['sessionid'] : "";
    iSACTIVE = json['ISACTIVE'] != null ? json['ISACTIVE'] : "";
    stuid = json['Stuid'] != null ? json['Stuid'] : "";
    stName = json['stName'] != null ? json['stName'] : "";
    combName = json['CombName'] != null ? json['CombName'] : "";
    subjectName = json['SubjectName'] != null ? json['SubjectName'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClassId'] = this.classId;
    data['SectionId'] = this.sectionId;
    data['StreamId'] = this.streamId;
    data['YearId'] = this.yearId;
    data['EMPID'] = this.eMPID;
    data['CircularId'] = this.circularId;
    data['CirNo'] = this.cirNo;
    data['CircularDate'] = this.circularDate;
    data['CirSubject'] = this.cirSubject;
    data['CirContent'] = this.cirContent;
    data['ForStuEmp'] = this.forStuEmp;
    data['MeetingId'] = this.meetingId;
    data['CircularFileurl'] = this.circularFileurl;
    data['schoolid'] = this.schoolid;
    data['organizationid'] = this.organizationid;
    data['sessionid'] = this.sessionid;
    data['ISACTIVE'] = this.iSACTIVE;
    data['Stuid'] = this.stuid;
    data['stName'] = this.stName;
    data['CombName'] = this.combName;
    data['SubjectName'] = this.subjectName;
    return data;
  }
}
