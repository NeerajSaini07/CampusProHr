class YearSessionListExamAnalysisModel {
  int? id = -1;
  String? sessionFrom = "";

  YearSessionListExamAnalysisModel({this.id, this.sessionFrom});

  YearSessionListExamAnalysisModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'] != null ? json['Id'] : -1;
    sessionFrom = json['SessionFrom'] != null ? json['SessionFrom'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['SessionFrom'] = this.sessionFrom;
    return data;
  }
}
