class SubjectListExamAnalysisModel {
  int? id = -1;
  String? subjecthead = '';

  SubjectListExamAnalysisModel({this.id, this.subjecthead});

  SubjectListExamAnalysisModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? -1;
    subjecthead = json['subjecthead'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subjecthead'] = this.subjecthead;
    return data;
  }
}
