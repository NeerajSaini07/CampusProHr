class ClassRoomCommentsModel {
  int? commentId;
  int? circularId;
  String? commentDate1;
  String? comment;
  int? toreplycommentId;
  String? fileUrl;
  String? userType;
  int? stuEmpId;
  String? name;

  ClassRoomCommentsModel(
      {this.commentId,
      this.circularId,
      this.commentDate1,
      this.comment,
      this.toreplycommentId,
      this.fileUrl,
      this.userType,
      this.stuEmpId,
      this.name});

  ClassRoomCommentsModel.fromJson(Map<String, dynamic> json) {
    commentId = json['CommentId'] ?? -1;
    circularId = json['CircularId'] ?? -1;
    commentDate1 = json['CommentDate1'] ?? "";
    comment = json['Comment'] ?? "";
    toreplycommentId = json['toreplycommentId'] ?? -1;
    fileUrl = json['FileUrl'] ?? "";
    userType = json['UserType'] ?? "";
    stuEmpId = json['StuEmpId'] ?? -1;
    name = json['Name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CommentId'] = this.commentId;
    data['CircularId'] = this.circularId;
    data['CommentDate1'] = this.commentDate1;
    data['Comment'] = this.comment;
    data['toreplycommentId'] = this.toreplycommentId;
    data['FileUrl'] = this.fileUrl;
    data['UserType'] = this.userType;
    data['StuEmpId'] = this.stuEmpId;
    data['Name'] = this.name;
    return data;
  }
}
