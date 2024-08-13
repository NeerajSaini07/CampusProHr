class GetClasswiseSubjectAdminModel {
  int? iD = -1;
  String? subjectHead = "";

  GetClasswiseSubjectAdminModel({this.iD, this.subjectHead});

  GetClasswiseSubjectAdminModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'] != null ? json['ID'] : -1;
    subjectHead = json['SubjectHead'] != null ? json['SubjectHead'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['SubjectHead'] = this.subjectHead;
    return data;
  }
}
