class SectionListAttendanceAdminModel {
  String? id = "";
  String? classSection = "";

  SectionListAttendanceAdminModel({this.id, this.classSection});

  SectionListAttendanceAdminModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'] != null ? json['Id'] : "";
    classSection = json['ClassSection'] != null ? json['ClassSection'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ClassSection'] = this.classSection;
    return data;
  }
}
