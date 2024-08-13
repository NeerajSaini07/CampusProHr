class LoadClassForSmsModel {
  String? classId = "";
  String? classname = "";
  String? classDisplayOrder = "";

  LoadClassForSmsModel({this.classId, this.classname, this.classDisplayOrder});

  LoadClassForSmsModel.fromJson(Map<String, dynamic> json) {
    classId = json['ClassId'] != null ? json['ClassId'] : "";
    classname = json['Classname'] != null ? json['Classname'] : "";
    classDisplayOrder =
        json['ClassDisplayOrder'] != null ? json['ClassDisplayOrder'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClassId'] = this.classId;
    data['Classname'] = this.classname;
    data['ClassDisplayOrder'] = this.classDisplayOrder;
    return data;
  }
}
