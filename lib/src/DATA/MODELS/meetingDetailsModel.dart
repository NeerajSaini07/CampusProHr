class MeetingDetailsModel {
  String? meetingSubject = "";
  String? meetingpwd = "";
  String? meetingduration = "";
  String? authnticateparam = "";
  String? meetingTypeId = "";
  String? status = "";
  String? meetingtime = "";
  String? meetingId = "";
  String? meetingdate = "";

  MeetingDetailsModel(
      {this.meetingSubject,
      this.meetingpwd,
      this.meetingduration,
      this.authnticateparam,
      this.meetingTypeId,
      this.status,
      this.meetingtime,
      this.meetingId,
      this.meetingdate});

  MeetingDetailsModel.fromJson(Map<String, dynamic> json) {
    meetingSubject =
        json['MeetingSubject'] != null ? json['MeetingSubject'] : "";
    meetingpwd = json['Meetingpwd'] != null ? json['Meetingpwd'] : "";
    meetingduration =
        json['meetingduration'] != null ? json['meetingduration'] : "";
    authnticateparam =
        json['authnticateparam'] != null ? json['authnticateparam'] : "";
    meetingTypeId = json['MeetingTypeId'] != null ? json['MeetingTypeId'] : "";
    status = json['status'] != null ? json['status'] : "";
    meetingtime = json['meetingtime'] != null ? json['meetingtime'] : "";
    meetingId = json['MeetingId'] != null ? json['MeetingId'] : "";
    meetingdate = json['meetingdate'] != null ? json['meetingdate'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MeetingSubject'] = this.meetingSubject;
    data['Meetingpwd'] = this.meetingpwd;
    data['meetingduration'] = this.meetingduration;
    data['authnticateparam'] = this.authnticateparam;
    data['MeetingTypeId'] = this.meetingTypeId;
    data['status'] = this.status;
    data['meetingtime'] = this.meetingtime;
    data['MeetingId'] = this.meetingId;
    data['meetingdate'] = this.meetingdate;
    return data;
  }
}
