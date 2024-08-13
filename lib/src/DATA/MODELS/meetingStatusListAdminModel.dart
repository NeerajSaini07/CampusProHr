class MeetingStatusListAdminModel {
  int? id = -1;
  String? subject = '';
  int? admitted = -1;
  int? notAdmitted = -1;
  String? meetingId = '';
  String? classids = '';
  int? subjectid = -1;
  int? empid = -1;
  int? isActive = -1;
  String? meetingdetails = '';
  String? meetingDatetime = '';
  String? email = '';
  String? meetingLiveStatus = '';
  String? runningStatus = '';

  MeetingStatusListAdminModel(
      {this.id,
      this.subject,
      this.admitted,
      this.notAdmitted,
      this.meetingId,
      this.classids,
      this.subjectid,
      this.empid,
      this.isActive,
      this.meetingdetails,
      this.meetingDatetime,
      this.email,
      this.meetingLiveStatus,
      this.runningStatus});

  MeetingStatusListAdminModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'] != null ? json['Id'] : -1;
    subject = json['Subject'] != null ? json['Subject'] : "";
    admitted = json['Admitted'] != null ? json['Admitted'] : -1;
    notAdmitted = json['NotAdmitted'] != null ? json['NotAdmitted'] : -1;
    meetingId = json['MeetingId'] != null ? json['MeetingId'] : "";
    classids = json['classids'] != null ? json['classids'] : "";
    subjectid = json['subjectid'] != null ? json['subjectid'] : -1;
    empid = json['empid'] != null ? json['empid'] : -1;
    isActive = json['IsActive'] != null ? json['IsActive'] : -1;
    meetingdetails =
        json['Meetingdetails'] != null ? json['Meetingdetails'] : "";
    meetingDatetime =
        json['MeetingDatetime'] != null ? json['MeetingDatetime'] : "";
    email = json['Email'] != null ? json['Email'] : "";
    meetingLiveStatus =
        json['MeetingLiveStatus'] != null ? json['MeetingLiveStatus'] : "";
    runningStatus = json['RunningStatus'] != null ? json['RunningStatus'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Subject'] = this.subject;
    data['Admitted'] = this.admitted;
    data['NotAdmitted'] = this.notAdmitted;
    data['MeetingId'] = this.meetingId;
    data['classids'] = this.classids;
    data['subjectid'] = this.subjectid;
    data['empid'] = this.empid;
    data['IsActive'] = this.isActive;
    data['Meetingdetails'] = this.meetingdetails;
    data['MeetingDatetime'] = this.meetingDatetime;
    data['Email'] = this.email;
    data['MeetingLiveStatus'] = this.meetingLiveStatus;
    data['RunningStatus'] = this.runningStatus;
    return data;
  }
}
