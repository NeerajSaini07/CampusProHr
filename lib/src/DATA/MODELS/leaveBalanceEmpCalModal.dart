class LeaveBalanceEmpCalModal {
  String? leaveName;
  String? leaveID;
  String? totalBalance;
  String? isLimit;
  String? monthlyLimit;

  LeaveBalanceEmpCalModal(
      {this.leaveID, this.leaveName, this.monthlyLimit, this.totalBalance});

  LeaveBalanceEmpCalModal.fromJson(Map<String, dynamic> json) {
    this.totalBalance =
        json["TotalBalance"] != null ? json["TotalBalance"].toString() : "";
    this.monthlyLimit =
        json["MonthlyLimit"] != null ? json["MonthlyLimit"].toString() : "";
    this.leaveName = json["LeaveName"] != null ? json["LeaveName"] : "";
    this.isLimit = json["IsLimit"] != null ? json["IsLimit"].toString() : "";
    this.leaveID = json["LeaveId"] != null ? json["LeaveId"].toString() : "";
  }
}
