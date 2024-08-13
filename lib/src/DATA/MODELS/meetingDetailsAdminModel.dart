class MeetingDetailsAdminModel {
  String? meetingId = '';
  String? meetingpwd = '';
  String? authnticateparam = '';
  String? meetingdate = '';
  String? meetingtime = '';
  String? meetingduration = '';
  String? status = '';
  int? meetingTypeId = -1;
  String? meetingSubject = '';

  MeetingDetailsAdminModel(
      {this.meetingId,
      this.meetingpwd,
      this.authnticateparam,
      this.meetingdate,
      this.meetingtime,
      this.meetingduration,
      this.status,
      this.meetingTypeId,
      this.meetingSubject});

  MeetingDetailsAdminModel.fromJson(Map<String, dynamic> json) {
    meetingId = json['MeetingId'] != null ? json['MeetingId'] : "";
    meetingpwd = json['Meetingpwd'] != null ? json['Meetingpwd'] : "";
    authnticateparam =
        json['authnticateparam'] != null ? json['authnticateparam'] : "";
    meetingdate = json['meetingdate'] != null ? json['meetingdate'] : "";
    meetingtime = json['meetingtime'] != null ? json['meetingtime'] : "";
    meetingduration =
        json['meetingduration'] != null ? json['meetingduration'] : "";
    status = json['status'] != null ? json['status'] : "";
    meetingTypeId = json['MeetingTypeId'] != null ? json['MeetingTypeId'] : -1;
    meetingSubject =
        json['MeetingSubject'] != null ? json['MeetingSubject'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MeetingId'] = this.meetingId;
    data['Meetingpwd'] = this.meetingpwd;
    data['authnticateparam'] = this.authnticateparam;
    data['meetingdate'] = this.meetingdate;
    data['meetingtime'] = this.meetingtime;
    data['meetingduration'] = this.meetingduration;
    data['status'] = this.status;
    data['MeetingTypeId'] = this.meetingTypeId;
    data['MeetingSubject'] = this.meetingSubject;
    return data;
  }
}
