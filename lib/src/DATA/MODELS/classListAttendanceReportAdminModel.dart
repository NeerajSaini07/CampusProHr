class ClassListAttendanceReportAdminModel {
  String? id;
  String? className;

  ClassListAttendanceReportAdminModel({this.id, this.className});

  ClassListAttendanceReportAdminModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'] != null ? json['Id'] : "";
    className = json['ClassName'] != null ? json['ClassName'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ClassName'] = this.className;
    return data;
  }
}
