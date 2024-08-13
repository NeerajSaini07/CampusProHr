class TeachersListModel {
  String? empSub = "";
  String? empId = "";
  String? subjectId = "";
  String? sessionId = "";
  String? classID = "";
  String? streamId = "";
  String? yearId = "";
  String? sectionId = "";

  TeachersListModel(
      {this.empSub,
      this.empId,
      this.subjectId,
      this.sessionId,
      this.classID,
      this.streamId,
      this.yearId,
      this.sectionId});

  TeachersListModel.fromJson(Map<String, dynamic> json) {
    empSub = json['EmpSub'] != null ? json['EmpSub'] : "";
    empId = json['EmpId'] != null ? json['EmpId'] : "";
    subjectId = json['SubjectId'] != null ? json['SubjectId'] : "";
    sessionId = json['SessionId'] != null ? json['SessionId'] : "";
    classID = json['ClassID'] != null ? json['ClassID'] : "";
    streamId = json['StreamId'] != null ? json['StreamId'] : "";
    yearId = json['YearId'] != null ? json['YearId'] : "";
    sectionId = json['SectionId'] != null ? json['SectionId'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmpSub'] = this.empSub;
    data['EmpId'] = this.empId;
    data['SubjectId'] = this.subjectId;
    data['SessionId'] = this.sessionId;
    data['ClassID'] = this.classID;
    data['StreamId'] = this.streamId;
    data['YearId'] = this.yearId;
    data['SectionId'] = this.sectionId;
    return data;
  }
}
