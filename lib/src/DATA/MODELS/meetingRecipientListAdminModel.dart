class MeetingRecipientListAdminModel {
  String? stName = '';
  String? meetingTime = '';
  String? joiningTime = '';
  String? jDate = '';
  String? jTime2 = '';
  String? jTime = '';
  String? admNo = '';
  String? gender = '';
  String? guardianMobileNo = '';
  int? sid = -1;

  MeetingRecipientListAdminModel(
      {this.stName,
      this.meetingTime,
      this.joiningTime,
      this.jDate,
      this.jTime2,
      this.jTime,
      this.admNo,
      this.gender,
      this.guardianMobileNo,
      this.sid});

  MeetingRecipientListAdminModel.fromJson(Map<String, dynamic> json) {
    stName = json['stName'] != null ? json['stName'] : "";
    meetingTime = json['MeetingTime'] != null ? json['MeetingTime'] : "";
    joiningTime = json['JoiningTime'] != null ? json['JoiningTime'] : "";
    jDate = json['JDate'] != null ? json['JDate'] : "";
    jTime2 = json['JTime2'] != null ? json['JTime2'] : "";
    jTime = json['JTime'] != null ? json['JTime'] : "";
    admNo = json['admNo'] != null ? json['admNo'] : "";
    gender = json['gender'] != null ? json['gender'] : "";
    guardianMobileNo =
        json['GuardianMobileNo'] != null ? json['GuardianMobileNo'] : "";
    sid = json['sid'] != null ? json['sid'] : -1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stName'] = this.stName;
    data['MeetingTime'] = this.meetingTime;
    data['JoiningTime'] = this.joiningTime;
    data['JDate'] = this.jDate;
    data['JTime2'] = this.jTime2;
    data['JTime'] = this.jTime;
    data['admNo'] = this.admNo;
    data['gender'] = this.gender;
    data['GuardianMobileNo'] = this.guardianMobileNo;
    data['sid'] = this.sid;
    return data;
  }
}
