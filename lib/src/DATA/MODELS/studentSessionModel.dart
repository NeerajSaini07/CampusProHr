class StudentSessionModel {
  String? id = '';
  String? sessionFrom = '';
  String? status = '';

  StudentSessionModel({this.id, this.sessionFrom, this.status});

  StudentSessionModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'] != null ? json['Id'] : "";
    sessionFrom = json['SessionFrom'] != null ? json['SessionFrom'] : "";
    status = json['Status'] != null ? json['Status'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['SessionFrom'] = this.sessionFrom;
    data['Status'] = this.status;
    return data;
  }
}
