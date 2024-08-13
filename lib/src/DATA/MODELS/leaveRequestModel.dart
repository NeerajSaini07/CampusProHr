class LeaveRequestModel {
  String? leaveDayType = "";
  String? leaveType = "";
  String? fromDate = "";
  String? toDate = "";
  String? leaveStatus = "";
  String? allowedFor = "";

  LeaveRequestModel(
      {this.leaveDayType,
      this.leaveType,
      this.fromDate,
      this.toDate,
      this.leaveStatus,
      this.allowedFor});

  LeaveRequestModel.fromJson(Map<String, dynamic> json) {
    leaveDayType = json['LeaveDayType'] != null ? json['LeaveDayType'] : "";
    leaveType = json['LeaveType'] != null ? json['LeaveType'] : "";
    fromDate = json['FromDate'] != null ? json['FromDate'] : "";
    toDate = json['ToDate'] != null ? json['ToDate'] : "";
    leaveStatus = json['LeaveStatus'] != null ? json['LeaveStatus'] : "";
    allowedFor = json['AllowedFor'] != null ? json['AllowedFor'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LeaveDayType'] = this.leaveDayType;
    data['LeaveType'] = this.leaveType;
    data['FromDate'] = this.fromDate;
    data['ToDate'] = this.toDate;
    data['LeaveStatus'] = this.leaveStatus;
    data['AllowedFor'] = this.allowedFor;
    return data;
  }
}
