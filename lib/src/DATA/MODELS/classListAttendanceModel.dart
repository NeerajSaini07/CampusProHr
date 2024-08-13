class ClassListAttendanceModel {
  String? id;
  String? className;

  ClassListAttendanceModel({this.id, this.className});

  ClassListAttendanceModel.fromJson(Map<String, dynamic> json) {
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
