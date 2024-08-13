class ApproveLeaveListModal {
  int? leaveRequestId;
  String? fromDate;
  String? toDate;
  String? leaveDate;
  String? description;
  String? leaveName;
  String? remark;
  String? leaveStatus;
  String? name;

  ApproveLeaveListModal(
      {this.description,
      this.toDate,
      this.fromDate,
      this.name,
      this.remark,
      this.leaveName,
      this.leaveDate,
      this.leaveRequestId,
      this.leaveStatus});

  ApproveLeaveListModal.fromJson(Map<String, dynamic> json) {
    this.leaveRequestId =
        json["LeaveRequestId"] != null ? json["LeaveRequestId"] : -1;
    this.leaveDate = json["LeaveDate"] != null ? json["LeaveDate"] : "";
    this.leaveName = json["LeaveName"] != null ? json["LeaveName"] : "";
    this.fromDate = json["FromDate"] != null ? json["FromDate"] : "";
    this.toDate = json["ToDate"] != null ? json["ToDate"] : "";
    this.description = json["Description"] != null ? json["Description"] : "";
    this.remark = json["Remark"] != null ? json["Remark"] : "";
    this.leaveStatus = json["LeaveStatus"] != null ? json["LeaveStatus"] : "";
    this.name = json["Name"] != null ? json["Name"] : "";
  }
}
