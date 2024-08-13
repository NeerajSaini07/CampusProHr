class CoordinatorListDetailModel {
  int? empID = -1;
  String? name = "";
  String? createdBy = "";
  String? updatedBy = "";
  String? createdOn = "";
  String? updatedOn = "";

  CoordinatorListDetailModel(
      {this.empID,
      this.name,
      this.createdBy,
      this.updatedBy,
      this.createdOn,
      this.updatedOn});

  CoordinatorListDetailModel.fromJson(Map<String, dynamic> json) {
    empID = json['EmpID'] != null ? json['EmpID'] : "";
    name = json['Name'] != null ? json['Name'] : "";
    createdBy = json['CreatedBy'] != null ? json['CreatedBy'] : "";
    updatedBy = json['UpdatedBy'] != null ? json['UpdatedBy'] : "";
    createdOn = json['CreatedOn'] != null ? json['CreatedOn'] : "";
    updatedOn = json['UpdatedOn'] != null ? json['UpdatedOn'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmpID'] = this.empID;
    data['Name'] = this.name;
    data['CreatedBy'] = this.createdBy;
    data['UpdatedBy'] = this.updatedBy;
    data['CreatedOn'] = this.createdOn;
    data['UpdatedOn'] = this.updatedOn;
    return data;
  }
}
