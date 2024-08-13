class ScheduleMeetingListAdminModel {
  int? id = -1;
  String? forStuEmp = "";
  int? isActive = -1;
  int? subjectId = 1;
  String? meetingDate1 = "";
  int? empId = -1;
  String? meetingDuration = "";
  String? meetingTime = "";
  String? meetingSubject = "";
  String? meetinglivestatus = "";
  String? runningStatus = "";

  ScheduleMeetingListAdminModel(
      {this.id,
      this.forStuEmp,
      this.isActive,
      this.subjectId,
      this.meetingDate1,
      this.empId,
      this.meetingDuration,
      this.meetingTime,
      this.meetingSubject,
      this.meetinglivestatus,
      this.runningStatus});

  ScheduleMeetingListAdminModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'] != null ? json['Id'] : -1;
    forStuEmp = json['ForStuEmp'] != null ? json['ForStuEmp'] : "";
    isActive = json['IsActive'] != null ? json['IsActive'] : -1;
    subjectId = json['SubjectId'] != null ? json['SubjectId'] : -1;
    meetingDate1 = json['MeetingDate1'] != null ? json['MeetingDate1'] : "";
    empId = json['EmpId'] != null ? json['EmpId'] : -1;
    meetingDuration =
        json['MeetingDuration'] != null ? json['MeetingDuration'] : "";
    meetingTime = json['MeetingTime'] != null ? json['MeetingTime'] : "";
    meetingSubject =
        json['MeetingSubject'] != null ? json['MeetingSubject'] : "";
    meetinglivestatus =
        json['meetinglivestatus'] != null ? json['meetinglivestatus'] : "";
    runningStatus = json['RunningStatus'] != null ? json['RunningStatus'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ForStuEmp'] = this.forStuEmp;
    data['IsActive'] = this.isActive;
    data['SubjectId'] = this.subjectId;
    data['MeetingDate1'] = this.meetingDate1;
    data['EmpId'] = this.empId;
    data['MeetingDuration'] = this.meetingDuration;
    data['MeetingTime'] = this.meetingTime;
    data['MeetingSubject'] = this.meetingSubject;
    data['meetinglivestatus'] = this.meetinglivestatus;
    data['RunningStatus'] = this.runningStatus;
    return data;
  }
}
