class StudentLeaveEmployeeModel {
  String? leaveDayType = '';
  String? name = '';
  String? requestorId = "";
  String? requestorPhone = '';
  String? leavetype = '';
  String? leaveDescription = '';
  String? fromDate = '';
  String? toDate = '';
  String? leaveStatus = '';

  StudentLeaveEmployeeModel(
      {this.leaveDayType,
      this.name,
      this.requestorId,
      this.requestorPhone,
      this.leavetype,
      this.leaveDescription,
      this.fromDate,
      this.toDate,
      this.leaveStatus});

  StudentLeaveEmployeeModel.fromJson(Map<String, dynamic> json) {
    leaveDayType = json['LeaveDayType'] != null ? json['LeaveDayType'] : "";
    name = json['Name'] != null ? json['Name'] : "";
    requestorId = json['RequestorId'] != null ? json['RequestorId'] : "";
    requestorPhone =
        json['RequestorPhone'] != null ? json['RequestorPhone'] : "";
    leavetype = json['Leavetype'] != null ? json['Leavetype'] : "";
    leaveDescription =
        json['LeaveDescription'] != null ? json['LeaveDescription'] : "";
    fromDate = json['FromDate'] != null ? json['FromDate'] : "";
    toDate = json['ToDate'] != null ? json['ToDate'] : "";
    leaveStatus = json['LeaveStatus'] != null ? json['LeaveStatus'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LeaveDayType'] = this.leaveDayType;
    data['Name'] = this.name;
    data['RequestorId'] = this.requestorId;
    data['RequestorPhone'] = this.requestorPhone;
    data['Leavetype'] = this.leavetype;
    data['LeaveDescription'] = this.leaveDescription;
    data['FromDate'] = this.fromDate;
    data['ToDate'] = this.toDate;
    data['LeaveStatus'] = this.leaveStatus;
    return data;
  }
}
