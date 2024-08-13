class SubjectListEmployeeModel {
  int? subjectId = -1;
  String? subjectHead = '';

  SubjectListEmployeeModel({this.subjectId, this.subjectHead});

  SubjectListEmployeeModel.fromJson(Map<String, dynamic> json) {
    subjectId = json['SubjectId'] != null ? json['SubjectId'] : -1;
    subjectHead = json['SubjectHead'] != null ? json['SubjectHead'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SubjectId'] = this.subjectId;
    data['SubjectHead'] = this.subjectHead;
    return data;
  }
}
