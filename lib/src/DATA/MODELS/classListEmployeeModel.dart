class ClassListEmployeeModel {
  String? iD = '';
  String? className = '';

  ClassListEmployeeModel({this.iD, this.className});

  ClassListEmployeeModel.fromJson(Map<String, dynamic> json) {
    iD = json['Id'] != null ? json['Id'] : "";
    className = json['ClassName'] != null ? json['ClassName'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.iD;
    data['ClassName'] = this.className;
    return data;
  }
}
