class AttendanceReportEmployeeModel {
  int? studentID = -1;
  String? attendanceDate = "";
  int? periodID = -1;
  String? status = "";
  String? attendanceDate1 = "";
  String? periodName = "";
  String? stName = "";
  String? admNo = "";
  String? guardianMobileNo = "";
  String? fatherName = "";
  int? classID = -1;
  int? classSectionID = -1;
  int? streamId = -1;
  int? yearId = -1;
  String? className = "";
  String? compClass = "";
  String? classSection = "";
  String? streamName = "";
  String? year = "";
  int? empID = -1;
  int? iD = -1;
  String? subjectHead = "";
  String? subjectCode = "";
  String? periodSubject = "";

  AttendanceReportEmployeeModel(
      {this.studentID,
      this.attendanceDate,
      this.periodID,
      this.status,
      this.attendanceDate1,
      this.periodName,
      this.stName,
      this.admNo,
      this.guardianMobileNo,
      this.fatherName,
      this.classID,
      this.classSectionID,
      this.streamId,
      this.yearId,
      this.className,
      this.compClass,
      this.classSection,
      this.streamName,
      this.year,
      this.empID,
      this.iD,
      this.subjectHead,
      this.subjectCode,
      this.periodSubject});

  AttendanceReportEmployeeModel.fromJson(Map<String, dynamic> json) {
    studentID = json['StudentID'] != null ? json['StudentID'] : -1;
    attendanceDate =
        json['AttendanceDate'] != null ? json['AttendanceDate'] : "";
    periodID = json['PeriodID'] != null ? json['PeriodID'] : -1;
    status = json['Status'] != null ? json['Status'] : "";
    attendanceDate1 =
        json['AttendanceDate1'] != null ? json['AttendanceDate1'] : "";
    periodName = json['PeriodName'] != null ? json['PeriodName'] : "";
    stName = json['StName'] != null ? json['StName'] : "";
    admNo = json['AdmNo'] != null ? json['AdmNo'] : "";
    guardianMobileNo =
        json['GuardianMobileNo'] != null ? json['GuardianMobileNo'] : "";
    fatherName = json['FatherName'] != null ? json['FatherName'] : "";
    classID = json['ClassID'] != null ? json['ClassID'] : -1;
    classSectionID =
        json['ClassSectionID'] != null ? json['ClassSectionID'] : -1;
    streamId = json['StreamId'] != null ? json['StreamId'] : -1;
    yearId = json['YearId'] != null ? json['YearId'] : -1;
    className = json['ClassName'] != null ? json['ClassName'] : "";
    compClass = json['CompClass'] != null ? json['CompClass'] : "";
    classSection = json['ClassSection'] != null ? json['ClassSection'] : "";
    streamName = json['StreamName'] != null ? json['StreamName'] : "";
    year = json['Year'] != null ? json['Year'] : "";
    empID = json['EmpID'] != null ? json['EmpID'] : -1;
    iD = json['ID'] != null ? json['ID'] : -1;
    subjectHead = json['SubjectHead'] != null ? json['SubjectHead'] : "";
    subjectCode = json['SubjectCode'] != null ? json['SubjectCode'] : "";
    periodSubject = json['PeriodSubject'] != null ? json['PeriodSubject'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StudentID'] = this.studentID;
    data['AttendanceDate'] = this.attendanceDate;
    data['PeriodID'] = this.periodID;
    data['Status'] = this.status;
    data['AttendanceDate1'] = this.attendanceDate1;
    data['PeriodName'] = this.periodName;
    data['StName'] = this.stName;
    data['AdmNo'] = this.admNo;
    data['GuardianMobileNo'] = this.guardianMobileNo;
    data['FatherName'] = this.fatherName;
    data['ClassID'] = this.classID;
    data['ClassSectionID'] = this.classSectionID;
    data['StreamId'] = this.streamId;
    data['YearId'] = this.yearId;
    data['ClassName'] = this.className;
    data['CompClass'] = this.compClass;
    data['ClassSection'] = this.classSection;
    data['StreamName'] = this.streamName;
    data['Year'] = this.year;
    data['EmpID'] = this.empID;
    data['ID'] = this.iD;
    data['SubjectHead'] = this.subjectHead;
    data['SubjectCode'] = this.subjectCode;
    data['PeriodSubject'] = this.periodSubject;
    return data;
  }
}
