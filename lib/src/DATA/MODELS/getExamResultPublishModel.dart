class GetExamResultPublishModel {
  String? classId = "";
  String? compClass = "";
  String? jsn = "";
  GetExamResultPublishModel(this.classId, this.jsn, this.compClass);

  GetExamResultPublishModel.fromJson(Map<String, dynamic> json) {
    classId = json['ClassID'] != null ? json['ClassID'] : "";
    compClass = json['CompClass'] != null ? json['CompClass'] : "";
    jsn = json['Json'] != null ? json['Json'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['ClassID'] = this.classId;
    data['compClass'] = this.compClass;
    data['json'] = this.jsn;
    return data;
  }
}
