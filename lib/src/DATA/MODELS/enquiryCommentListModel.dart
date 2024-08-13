class EnquiryCommentListModel {
  int? iD = -1;
  int? enquiryID;
  String? followUpDate = '';
  String? followUpTime = '';
  String? followUpComments = '';
  int? isActive = -1;
  String? createdDate = '';
  int? createdID = -1;
  String? createdDateFormat = '';
  String? followUpDateFormat = '';
  String? createdByName = '';

  EnquiryCommentListModel(
      {this.iD,
      this.enquiryID,
      this.followUpDate,
      this.followUpTime,
      this.followUpComments,
      this.isActive,
      this.createdDate,
      this.createdID,
      this.createdDateFormat,
      this.followUpDateFormat,
      this.createdByName});

  EnquiryCommentListModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'] != null ? json['ID'] : -1;
    enquiryID = json['EnquiryID'] != null ? json['EnquiryID'] : -1;
    followUpDate = json['FollowUpDate'] != null ? json['FollowUpDate'] : "";
    followUpTime = json['FollowUpTime'] != null ? json['FollowUpTime'] : "";
    followUpComments =
        json['FollowUpComments'] != null ? json['FollowUpComments'] : "";
    isActive = json['IsActive'] != null ? json['IsActive'] : -1;
    createdDate = json['CreatedDate'] != null ? json['CreatedDate'] : "";
    createdID = json['CreatedID'] != null ? json['CreatedID'] : -1;
    createdDateFormat =
        json['CreatedDateFormat'] != null ? json['CreatedDateFormat'] : "";
    followUpDateFormat =
        json['FollowUpDateFormat'] != null ? json['FollowUpDateFormat'] : "";
    createdByName = json['CreatedByName'] != null ? json['CreatedByName'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['EnquiryID'] = this.enquiryID;
    data['FollowUpDate'] = this.followUpDate;
    data['FollowUpTime'] = this.followUpTime;
    data['FollowUpComments'] = this.followUpComments;
    data['IsActive'] = this.isActive;
    data['CreatedDate'] = this.createdDate;
    data['CreatedID'] = this.createdID;
    data['CreatedDateFormat'] = this.createdDateFormat;
    data['FollowUpDateFormat'] = this.followUpDateFormat;
    data['CreatedByName'] = this.createdByName;
    return data;
  }
}
