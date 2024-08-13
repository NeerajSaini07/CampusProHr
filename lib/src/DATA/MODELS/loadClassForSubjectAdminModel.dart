class LoadClassForSubjectAdminModel {
  String? classId = "";
  String? className = "";
  String? classDisplayOrder = "";

  LoadClassForSubjectAdminModel(
      {this.classId, this.className, this.classDisplayOrder});

  LoadClassForSubjectAdminModel.fromJson(Map<String, dynamic> json) {
    this.className = json['Classname'] != null ? json['Classname'] : "";
    this.classId = json['ClassId'] != null ? json['ClassId'] : "";
    this.classDisplayOrder =
        json['ClassDisplayOrder'] != null ? json['ClassDisplayOrder'] : "";
  }

  Map<String, dynamic> fromJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['Classname'] = this.className;
    data['ClassId'] = this.classId;
    data['ClassDisplayOrder'] = this.classDisplayOrder;
    return data;
  }
}
