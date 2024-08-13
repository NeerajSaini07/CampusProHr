class TeachersListMeetingModel {
  String? empId = '';
  String? name = '';

  TeachersListMeetingModel({this.empId, this.name});

  TeachersListMeetingModel.fromJson(Map<String, dynamic> json) {
    empId = json['EmpId'] ?? "";
    name = json['Name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmpId'] = this.empId;
    data['Name'] = this.name;
    return data;
  }
}
