class LoadAllottedSubjectsModel {
  int? empId = -1;
  int? subjectId = -1;
  int? classId = -1;
  String? className = "";
  int? streamID = -1;
  int? sectionId = -1;
  String? section = "";
  int? yearId = -1;
  String? subject = "";
  String? subjectCode = "";
  String? fromDate = "";
  String? toDate = "";
  String? periodID = "";

  LoadAllottedSubjectsModel(
      {this.empId,
      this.subjectId,
      this.classId,
      this.className,
      this.streamID,
      this.sectionId,
      this.section,
      this.yearId,
      this.subject,
      this.subjectCode,
      this.fromDate,
      this.toDate,
      this.periodID});

  LoadAllottedSubjectsModel.fromJson(Map<String, dynamic> json) {
    empId = json['EmpId'] != null ? json['EmpId'] : -1;
    subjectId = json['SubjectId'] != null ? json['SubjectId'] : -1;
    classId = json['ClassId'] != null ? json['ClassId'] : -1;
    className = json['Class'] != null ? json['Class'] : "";
    streamID = json['StreamID'] != null ? json['StreamID'] : -1;
    sectionId = json['SectionId'] != null ? json['SectionId'] : -1;
    section = json['Section'] != null ? json['Section'] : "";
    yearId = json['YearId'] != null ? json['YearId'] : -1;
    subject = json['Subject'] != null ? json['Subject'] : "";
    subjectCode = json['SubjectCode'] != null ? json['SubjectCode'] : "";
    fromDate = json['FromDate'] != null ? json['FromDate'] : "";
    toDate = json['ToDate'] != null ? json['ToDate'] : "";
    periodID = json['PeriodID'] != null ? json['PeriodID'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmpId'] = this.empId;
    data['SubjectId'] = this.subjectId;
    data['ClassId'] = this.classId;
    data['Class'] = this.className;
    data['StreamID'] = this.streamID;
    data['SectionId'] = this.sectionId;
    data['Section'] = this.section;
    data['YearId'] = this.yearId;
    data['Subject'] = this.subject;
    data['SubjectCode'] = this.subjectCode;
    data['FromDate'] = this.fromDate;
    data['ToDate'] = this.toDate;
    data['PeriodID'] = this.periodID;
    return data;
  }
}
