class ResultAnnounceExamModel {
  int? examId = -1;
  String? exam = "";

  ResultAnnounceExamModel({this.examId, this.exam});

  ResultAnnounceExamModel.fromJson(Map<String, dynamic> json) {
    examId = json['ExamId'] != null ? json['ExamId'] : -1;
    exam = json['Exam'] != null ? json['Exam'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ExamId'] = this.examId;
    data['Exam'] = this.exam;
    return data;
  }
}
