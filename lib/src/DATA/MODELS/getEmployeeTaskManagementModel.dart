class GetEmployeeTaskManagementModel {
  int? id = -1;
  String? name = "";

  GetEmployeeTaskManagementModel({this.id, this.name});

  GetEmployeeTaskManagementModel.fromJson(Map<String, dynamic> json) {
    this.id = json['ID'] != null ? json['ID'] : -1;
    this.name = json['Name'] != null ? json['Name'] : "";
  }
}
