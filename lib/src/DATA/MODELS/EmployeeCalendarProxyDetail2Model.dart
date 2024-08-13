class EmployeeCalendarProxyDetail2Model {
  String? approverName;
  String? approver;
  String? approvedDay;
  String? approvedDate;
  String? remark;
  String? status;

  EmployeeCalendarProxyDetail2Model(
      {this.approverName,
      this.approver,
      this.approvedDay,
      this.approvedDate,
      this.remark,
      this.status});

  EmployeeCalendarProxyDetail2Model.fromJson(Map<String, dynamic> json) {
    approverName = json['ApproverName'] != null ? json['ApproverName'] : "";
    approver = json['Approver'] != null ? json['Approver'].toString() : "";
    approvedDay = json['ApprovedDay'] != null ? json['ApprovedDay'] : "";
    approvedDate = json['ApprovedDate'] != null ? json['ApprovedDate'] : "";
    remark = json['Remark'] != null ? json['Remark'] : "";
    status = json['Status'] != null ? json['Status'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ApproverName'] = this.approverName;
    data['Approver'] = this.approver;
    data['ApprovedDay'] = this.approvedDay;
    data['ApprovedDate'] = this.approvedDate;
    data['Remark'] = this.remark;
    data['Status'] = this.status;
    return data;
  }
}
