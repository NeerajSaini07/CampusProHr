class StaffMeetingsEmployeeDashboardModel {
  int? id = -1;
  int? schoolId = -1;
  int? organizationId = -1;
  String? forStuEmp = '';
  String? comment = '';
  int? meetingId = -1;
  String? meetingDate = '';
  String? meetinglivestatus = '';
  String? runningStatus = '';

  StaffMeetingsEmployeeDashboardModel(
      {this.id,
      this.schoolId,
      this.organizationId,
      this.forStuEmp,
      this.comment,
      this.meetingId,
      this.meetingDate,
      this.meetinglivestatus,
      this.runningStatus});

  StaffMeetingsEmployeeDashboardModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    schoolId = json['SchoolId'];
    organizationId = json['OrganizationId'];
    forStuEmp = json['ForStuEmp'];
    comment = json['Comment'];
    meetingId = json['MeetingId'];
    meetingDate = json['MeetingDate'];
    meetinglivestatus = json['meetinglivestatus'];
    runningStatus = json['RunningStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['SchoolId'] = this.schoolId;
    data['OrganizationId'] = this.organizationId;
    data['ForStuEmp'] = this.forStuEmp;
    data['Comment'] = this.comment;
    data['MeetingId'] = this.meetingId;
    data['MeetingDate'] = this.meetingDate;
    data['meetinglivestatus'] = this.meetinglivestatus;
    data['RunningStatus'] = this.runningStatus;
    return data;
  }
}
