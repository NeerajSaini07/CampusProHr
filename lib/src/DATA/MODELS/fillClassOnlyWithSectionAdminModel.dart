class FillClassOnlyWithSectionAdminModel {
  String? classId = "";
  String? classname = "";
  int? classDisplayOrder = -1;

  FillClassOnlyWithSectionAdminModel(
      {this.classId, this.classname, this.classDisplayOrder});

  FillClassOnlyWithSectionAdminModel.fromJson(Map<String, dynamic> json) {
    classId = json['ClassId'] != null ? json['ClassId'] : "";
    classname = json['Classname'] != null ? json['Classname'] : "";
    classDisplayOrder =
        json['ClassDisplayOrder'] != null ? json['ClassDisplayOrder'] : -1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClassId'] = this.classId;
    data['Classname'] = this.classname;
    data['ClassDisplayOrder'] = this.classDisplayOrder;
    return data;
  }
}
