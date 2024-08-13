class FeedbackEnquiryModel {
  int? iD = -1;
  String? name = '';
  String? mobileNo = '';
  String? admission = '';
  String? emailID = '';
  String? otherCmnt = '';
  String? createdOn = '';
  int? createdBy = 0;
  int? schoolID = 0;
  int? orgID = 0;

  FeedbackEnquiryModel(
      {this.iD,
      this.name,
      this.mobileNo,
      this.admission,
      this.emailID,
      this.otherCmnt,
      this.createdOn,
      this.createdBy,
      this.schoolID,
      this.orgID});

  FeedbackEnquiryModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'] != null ? json['ID'] : -1;
    name = json['Name'] != null ? json['Name'] : "";
    mobileNo = json['MobileNo'] != null ? json['MobileNo'] : "";
    admission = json['Admission'] != null ? json['Admission'] : "";
    emailID = json['EmailID'] != null ? json['EmailID'] : "";
    otherCmnt = json['OtherCmnt'] != null ? json['OtherCmnt'] : "";
    createdOn = json['CreatedOn'] != null ? json['CreatedOn'] : "";
    createdBy = json['CreatedBy'] != null ? json['CreatedBy'] : 0;
    schoolID = json['SchoolID'] != null ? json['SchoolID'] : 0;
    orgID = json['OrgID'] != null ? json['OrgID'] : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Name'] = this.name;
    data['MobileNo'] = this.mobileNo;
    data['Admission'] = this.admission;
    data['EmailID'] = this.emailID;
    data['OtherCmnt'] = this.otherCmnt;
    data['CreatedOn'] = this.createdOn;
    data['CreatedBy'] = this.createdBy;
    data['SchoolID'] = this.schoolID;
    data['OrgID'] = this.orgID;
    return data;
  }
}
