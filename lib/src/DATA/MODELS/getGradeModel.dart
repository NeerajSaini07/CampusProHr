class GetGradeModel {
  String? grade = "";

  GetGradeModel({this.grade});

  GetGradeModel.fromJson(Map<String, dynamic> json) {
    this.grade = json['Grade'] != null ? json['Grade'] : "";
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data['Grade'] = this.grade;
    return data;
  }
}
