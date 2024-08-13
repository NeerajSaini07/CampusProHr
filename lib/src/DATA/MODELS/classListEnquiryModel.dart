class ClassListEnquiryModel {
  String? iD = "";
  String? classId = "";
  String? classname = "";
  String? classDisplayOrder = "";

  ClassListEnquiryModel(
      {this.iD, this.classId, this.classname, this.classDisplayOrder});

  ClassListEnquiryModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'] != null ? json['ID'] : "";
    classId = json['ClassId'] != null ? json['ClassId'] : "";
    classname = json['Classname'] != null ? json['Classname'] : "";
    classDisplayOrder =
        json['ClassDisplayOrder'] != null ? json['ClassDisplayOrder'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ClassId'] = this.classId;
    data['Classname'] = this.classname;
    data['ClassDisplayOrder'] = this.classDisplayOrder;
    return data;
  }
}
