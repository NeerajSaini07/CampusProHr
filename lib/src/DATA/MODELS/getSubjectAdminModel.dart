class GetSubjectAdminModel {
  String? id = "";
  String? subjectName = "";

  GetSubjectAdminModel({this.id, this.subjectName});

  GetSubjectAdminModel.fromJson(Map<String, dynamic> json) {
    this.subjectName = json['subjecthead'] != null ? json['subjecthead'] : "";
    this.id = json['id'] != null ? json['id'] : "";
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['subjecthead'] = this.subjectName;
    data['id'] = this.id;
    return data;
  }
}
