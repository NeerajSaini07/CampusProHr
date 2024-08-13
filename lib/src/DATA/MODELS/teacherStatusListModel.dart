class TeacherStatusListModel {
  String? id;
  String? subjectHead;
  String? admitted;
  String? notAdmitted;
  String? meetingId;
  String? classIds;
  String? subjectId;
  String? empId;
  String? isActive;
  String? meetingDate;
  String? className;
  String? classSection;
  String? meetingDate2;
  String? tJoinTime;
  String? meetingTime;

  TeacherStatusListModel(
      {this.id,
      this.subjectHead,
      this.admitted,
      this.notAdmitted,
      this.meetingId,
      this.classIds,
      this.subjectId,
      this.empId,
      this.isActive,
      this.meetingDate,
      this.className,
      this.classSection,
      this.meetingDate2,
      this.tJoinTime,
      this.meetingTime});

  TeacherStatusListModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'] ?? "";
    subjectHead = json['SubjectHead'] ?? "";
    admitted = json['Admitted'] ?? "";
    notAdmitted = json['NotAdmitted'] ?? "";
    meetingId = json['MeetingId'] ?? "";
    classIds = json['ClassIds'] ?? "";
    subjectId = json['SubjectId'] ?? "";
    empId = json['EmpId'] ?? "";
    isActive = json['isActive'] ?? "";
    meetingDate = json['MeetingDate'] ?? "";
    className = json['ClassName'] ?? "";
    classSection = json['ClassSection'] ?? "";
    meetingDate2 = json['MeetingDate2'] ?? "";
    tJoinTime = json['TJoinTime'] ?? "";
    meetingTime = json['MeetingTime'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['SubjectHead'] = this.subjectHead;
    data['Admitted'] = this.admitted;
    data['NotAdmitted'] = this.notAdmitted;
    data['MeetingId'] = this.meetingId;
    data['ClassIds'] = this.classIds;
    data['SubjectId'] = this.subjectId;
    data['EmpId'] = this.empId;
    data['isActive'] = this.isActive;
    data['MeetingDate'] = this.meetingDate;
    data['ClassName'] = this.className;
    data['ClassSection'] = this.classSection;
    data['MeetingDate2'] = this.meetingDate2;
    data['TJoinTime'] = this.tJoinTime;
    data['MeetingTime'] = this.meetingTime;
    return data;
  }
}
