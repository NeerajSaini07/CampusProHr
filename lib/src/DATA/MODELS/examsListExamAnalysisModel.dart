class ExamsListExamAnalysisModel {
  int? examid = -1;
  String? exam = "";

  ExamsListExamAnalysisModel({this.examid, this.exam});

  ExamsListExamAnalysisModel.fromJson(Map<String, dynamic> json) {
    examid = json['examid'] != null ? json['examid'] : -1;
    exam = json['exam'] != null ? json['exam'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['examid'] = this.examid;
    data['exam'] = this.exam;
    return data;
  }
}
