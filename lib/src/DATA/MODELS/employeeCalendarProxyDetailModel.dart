class EmployeeCalendarProxyDetailModel {
  String? empName;
  String? createdDate;
  String? requestDate;
  String? requestDay;
  String? departmentName;
  String? attendanceFor;
  String? checkInTime;
  String? checkOutTime;
  String? reasons;
  String? description;

  EmployeeCalendarProxyDetailModel(
      {this.empName,
      this.createdDate,
      this.requestDate,
      this.requestDay,
      this.departmentName,
      this.attendanceFor,
      this.checkInTime,
      this.checkOutTime,
      this.reasons,
      this.description});

  EmployeeCalendarProxyDetailModel.fromJson(Map<String, dynamic> json) {
    empName = json['EmpName'] != null ? json['EmpName'] : "";
    createdDate = json['CreatedDate'] != null ? json['CreatedDate'] : "";
    requestDate = json['RequestDate'] != null ? json['RequestDate'] : "";
    requestDay = json['RequestDay'] != null ? json['RequestDay'] : "";
    departmentName =
        json['DepartmentName'] != null ? json['DepartmentName'] : "";
    attendanceFor = json['AttendanceFor'] != null ? json['AttendanceFor'] : "";
    checkInTime = json['CheckInTime'] != null ? json['CheckInTime'] : "";
    checkOutTime = json['CheckOut_Time'] != null ? json['CheckOut_Time'] : "";
    reasons = json['Reasons'] != null ? json['Reasons'] : "";
    description = json["Description"] != null ? json["Description"] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmpName'] = this.empName;
    data['CreatedDate'] = this.createdDate;
    data['RequestDate'] = this.requestDate;
    data['RequestDay'] = this.requestDay;
    data['DepartmentName'] = this.departmentName;
    data['AttendanceFor'] = this.attendanceFor;
    data['CheckInTime'] = this.checkInTime;
    data['CheckOut_Time'] = this.checkOutTime;
    data['Reasons'] = this.reasons;
    return data;
  }
}
