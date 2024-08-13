class CustomChatModel {
  String? toreplycommentId = '[';
  String? id = '';
  String? commentDate = '';
  String? comment = '';
  String? fileUrl = '';
  String? msgtype = '';
  String? commentDate1 = '';
  String? meetingId = '';

  CustomChatModel(
      {this.toreplycommentId,
      this.id,
      this.commentDate,
      this.comment,
      this.fileUrl,
      this.msgtype,
      this.commentDate1,
      this.meetingId});

  CustomChatModel.fromJson(Map<String, dynamic> json) {
    toreplycommentId =
        json['toreplycommentId'] != null ? json['toreplycommentId'] : "";
    id = json['Id'] != null ? json['Id'] : "";
    commentDate = json['CommentDate'] != null ? json['CommentDate'] : "";
    comment = json['Comment'] != null ? json['Comment'] : "";
    fileUrl = json['FileUrl'] != null ? json['FileUrl'] : "";
    msgtype = json['msgtype'] != null ? json['msgtype'] : "";
    commentDate1 = json['CommentDate1'] != null ? json['CommentDate1'] : "";
    meetingId = json['MeetingId'] != null ? json['MeetingId'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['toreplycommentId'] = this.toreplycommentId;
    data['Id'] = this.id;
    data['CommentDate'] = this.commentDate;
    data['Comment'] = this.comment;
    data['FileUrl'] = this.fileUrl;
    data['msgtype'] = this.msgtype;
    data['CommentDate1'] = this.commentDate1;
    data['MeetingId'] = this.meetingId;
    return data;
  }
}
