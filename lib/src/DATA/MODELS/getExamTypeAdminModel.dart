class GetExamTypeAdminModel {
  int? examId = -1;
  String? exam = "";

  GetExamTypeAdminModel({this.exam, this.examId});

  GetExamTypeAdminModel.fromJson(Map<String, dynamic> json) {
    this.examId = json['examid'] != null ? json['examid'] : -1;
    this.exam = json['exam'] != null ? json['exam'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['exam'] = this.exam;
    data['examid'] = this.examId;
    return data;
  }
}
