class AssignAdminModel {
  String? empId = '';
  String? name = '';
  String? mobileNo = '';

  AssignAdminModel({this.empId, this.name, this.mobileNo});

  AssignAdminModel.fromJson(Map<String, dynamic> json) {
    empId = json['EmpId'] != null ? json['EmpId'] : "";
    name = json['Name'] != null ? json['Name'] : "";
    mobileNo = json['MobileNo'] != null ? json['MobileNo'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmpId'] = this.empId;
    data['Name'] = this.name;
    data['MobileNo'] = this.mobileNo;
    return data;
  }
}
