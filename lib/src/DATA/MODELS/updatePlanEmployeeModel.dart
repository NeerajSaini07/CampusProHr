class UpdatePlanEmployeeModel {
  String? id;
  String? title;
  String? detail;
  String? planStatus;
  String? ToDate;
  String? remark;
  String? FromDate;

  UpdatePlanEmployeeModel(
      {this.id,
      this.title,
      this.detail,
      this.planStatus,
      this.ToDate,
      this.remark,
      this.FromDate});

  UpdatePlanEmployeeModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'] != null ? json['Id'] : "";
    title = json['Title'] != null ? json['Title'] : "";
    detail = json['Detail'] != null ? json['Detail'] : "";
    planStatus = json['PlanStatus'] != null ? json['PlanStatus'] : "";
    ToDate = json['ToDate'] != null ? json['ToDate'] : "";
    remark = json['Remark'] != null ? json['Remark'] : "";
    FromDate = json['FromDate'] != null ? json['FromDate'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Title'] = this.title;
    data['Detail'] = this.detail;
    data['PlanStatus'] = this.planStatus;
    data['ToDate'] = this.ToDate;
    data['Remark'] = this.remark;
    data['FromDate'] = this.FromDate;
    return data;
  }
}
