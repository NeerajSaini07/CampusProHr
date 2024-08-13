class HomeWorkCommentsModel {
  List<Table>? table = [];
  List<Table1>? table1 = [];

  HomeWorkCommentsModel({this.table, this.table1});

  HomeWorkCommentsModel.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <Table>[];
      json['Table'].forEach((v) {
        table!.add(new Table.fromJson(v));
      });
    }
    if (json['Table1'] != null) {
      table1 = <Table1>[];
      json['Table1'].forEach((v) {
        table1!.add(new Table1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.table != null) {
      data['Table'] = this.table!.map((v) => v.toJson()).toList();
    }
    if (this.table1 != null) {
      data['Table1'] = this.table1!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Table {
  int? replyId = 0;
  int? homeworkId = 0;
  String? commentDate1 = "";
  String? comment = "";
  int? isread = 0;
  int? toreplycommentId = 0;
  String? fileUrl = "";
  String? userType = "";
  int? stuEmpId = 0;
  String? name = "";
  String? studentName = "";

  Table(
      {this.replyId,
      this.homeworkId,
      this.commentDate1,
      this.comment,
      this.isread,
      this.toreplycommentId,
      this.fileUrl,
      this.userType,
      this.stuEmpId,
      this.name,
      this.studentName});

  Table.fromJson(Map<String, dynamic> json) {
    replyId = json['ReplyId'];
    homeworkId = json['HomeworkId'];
    commentDate1 = json['CommentDate1'];
    comment = json['Comment'];
    isread = json['isread'];
    toreplycommentId = json['toreplycommentId'];
    fileUrl = json['FileUrl'];
    userType = json['UserType'];
    stuEmpId = json['StuEmpId'];
    name = json['Name'];
    studentName = json['StudentName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ReplyId'] = this.replyId;
    data['HomeworkId'] = this.homeworkId;
    data['CommentDate1'] = this.commentDate1;
    data['Comment'] = this.comment;
    data['isread'] = this.isread;
    data['toreplycommentId'] = this.toreplycommentId;
    data['FileUrl'] = this.fileUrl;
    data['UserType'] = this.userType;
    data['StuEmpId'] = this.stuEmpId;
    data['Name'] = this.name;
    data['StudentName'] = this.studentName;
    return data;
  }
}

class Table1 {
  int? noofComments = -1;

  Table1({this.noofComments});

  Table1.fromJson(Map<String, dynamic> json) {
    noofComments = json['NoofComments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NoofComments'] = this.noofComments;
    return data;
  }
}
