class SubjectExamMarksModel {
  String? id = '';
  String? subjecthead = '';

  SubjectExamMarksModel({this.id, this.subjecthead});

  SubjectExamMarksModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? json['id'] : "";
    subjecthead = json['subjecthead'] != null ? json['subjecthead'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subjecthead'] = this.subjecthead;
    return data;
  }
}
