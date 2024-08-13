class GetMinMaxmarksModel {
  String? minMarks = "";
  String? maxMarks = "";

  GetMinMaxmarksModel({this.maxMarks, this.minMarks});

  GetMinMaxmarksModel.fromJson(Map<String, dynamic> json) {
    this.maxMarks = json['maxmarks'] != null ? json['maxmarks'] : "";
    this.minMarks = json['minmarks'] != null ? json['minmarks'] : "";
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['maxmarks'] = this.maxMarks;
    data['minmarks'] = this.minMarks;
    return data;
  }
}
