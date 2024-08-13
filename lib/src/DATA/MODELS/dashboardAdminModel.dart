class DashboardAdminModel {
  String? feeCollection = '';
  String? adminName = '';
  String? payment = '';
  int? sessionID = -1;
  String? totalStudent = '';
  String? presentStudent = '';
  String? schoolName = '';
  String? absentStudent = '';
  String? leaveStudent = '';

  DashboardAdminModel(
      {this.feeCollection,
      this.adminName,
      this.payment,
      this.sessionID,
      this.totalStudent,
      this.presentStudent,
      this.schoolName,
      this.absentStudent,
      this.leaveStudent});

  DashboardAdminModel.fromJson(Map<String, dynamic> json) {
    feeCollection = json['FeeCollection'] != "-" && json['FeeCollection'] != null
        ? json['FeeCollection']
        : "0";
    adminName = json['AdminName'] != "-" && json['AdminName'] != null
        ? json['AdminName']
        : "0";
    payment = json['Payment'] != "-" && json['Payment'] != null
        ? json['Payment']
        : "0";
    sessionID = json['SessionID'] != "-" && json['SessionID'] != null
        ? json['SessionID']
        : "0";
    totalStudent = json['TotalStudent'] != "-" && json['TotalStudent'] != null
        ? json['TotalStudent']
        : "0";
    presentStudent = json['PresentStudent'] != "-" && json['PresentStudent'] != null
        ? json['PresentStudent']
        : "0";
    schoolName = json['SchoolName'] != "-" && json['SchoolName'] != null
        ? json['SchoolName']
        : "0";
    absentStudent = json['AbsentStudent'] != "-" && json['AbsentStudent'] != null
        ? json['AbsentStudent']
        : "0";
    leaveStudent = json['LeaveStudent'] != "-" && json['LeaveStudent'] != null
        ? json['LeaveStudent']
        : "0";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FeeCollection'] = this.feeCollection;
    data['AdminName'] = this.adminName;
    data['Payment'] = this.payment;
    data['SessionID'] = this.sessionID;
    data['TotalStudent'] = this.totalStudent;
    data['PresentStudent'] = this.presentStudent;
    data['SchoolName'] = this.schoolName;
    data['AbsentStudent'] = this.absentStudent;
    data['LeaveStudent'] = this.leaveStudent;
    return data;
  }
}
