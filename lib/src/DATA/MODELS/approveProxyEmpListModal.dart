class ApproveProxyEmpListModal {
  int? prId;
  int? empId;
  String? checkInTime;
  String? checkOutTime;
  String? attDate;
  String? reasons;
  String? attType;
  String? status;
  int? createdBy;
  String? createdDate;
  int? attID;
  String? remark;
  String? attFor;
  String? proxyStatus;
  String? name;
  String? attendanceFor;
  String? type;

  ApproveProxyEmpListModal(
      {this.prId,
      this.empId,
      this.checkInTime,
      this.checkOutTime,
      this.attDate,
      this.reasons,
      this.attType,
      this.status,
      this.createdBy,
      this.createdDate,
      this.attID,
      this.remark,
      this.attFor,
      this.proxyStatus,
      this.name,
      this.attendanceFor,
      this.type});

  ApproveProxyEmpListModal.fromJson(Map<String, dynamic> json) {
    prId = json['Pr_id'] != null ? json['Pr_id'] : -1;
    empId = json['Emp_id'] != null ? json['Emp_id'] : -1;
    checkInTime = json['CheckIn_Time'] != null ? json['CheckIn_Time'] : "";
    checkOutTime = json['CheckOut_Time'] != null ? json['CheckOut_Time'] : "";
    attDate = json['Att_Date'] != null ? json['Att_Date'] : "";
    reasons = json['Reasons'] != null ? json['Reasons'] : "";
    attType = json['Att_Type'] != null ? json['Att_Type'] : "";
    status = json['Status'] != null ? json['Status'] : "";
    createdBy = json['created_by'] != null ? json['created_by'] : -1;
    createdDate = json['created_date'] != null ? json['created_date'] : "";
    attID = json['AttID'] != null ? json['AttID'] : -1;
    remark = json['Remark'] != null ? json['Remark'] : "";
    attFor = json['Att_For'] != null ? json['Att_For'] : "";
    proxyStatus = json['ProxyStatus'] != null ? json['ProxyStatus'] : "";
    name = json['Name'] != null ? json['Name'] : "";
    attendanceFor = json['AttendanceFor'] != null ? json['AttendanceFor'] : "";
    type = json['Type'] != null ? json['Type'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Pr_id'] = this.prId;
    data['Emp_id'] = this.empId;
    data['CheckIn_Time'] = this.checkInTime;
    data['CheckOut_Time'] = this.checkOutTime;
    data['Att_Date'] = this.attDate;
    data['Reasons'] = this.reasons;
    data['Att_Type'] = this.attType;
    data['Status'] = this.status;
    data['created_by'] = this.createdBy;
    data['created_date'] = this.createdDate;
    data['AttID'] = this.attID;
    data['Remark'] = this.remark;
    data['Att_For'] = this.attFor;
    data['ProxyStatus'] = this.proxyStatus;
    data['Name'] = this.name;
    data['AttendanceFor'] = this.attendanceFor;
    data['Type'] = this.type;
    return data;
  }
}
