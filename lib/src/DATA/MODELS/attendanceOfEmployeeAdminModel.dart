class AttendanceOfEmployeeAdminModel {
  String? name = "";
  String? effectiveAbsent = "";
  String? attStatus = "";
  String? effectiveAttendance = "";
  String? leaveAvailed = "";
  String? department = "";
  String? groupName = "";
  String? empno = "";
  String? desigName = "";
  String? dateOfBirth = "";
  String? bloodGroup = "";
  String? prsAddr = "";
  String? mobileNo = "";
  String? emailID = "";
  String? designation = "";
  String? groupID = "";

  AttendanceOfEmployeeAdminModel(
      {this.name,
      this.effectiveAbsent,
      this.attStatus,
      this.effectiveAttendance,
      this.leaveAvailed,
      this.department,
      this.groupName,
      this.empno,
      this.desigName,
      this.dateOfBirth,
      this.bloodGroup,
      this.prsAddr,
      this.mobileNo,
      this.emailID,
      this.designation,
      this.groupID});

  AttendanceOfEmployeeAdminModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'] != null ? json['Name'] : "";
    effectiveAbsent =
        json['EffectiveAbsent'] != null ? json['EffectiveAbsent'] : "";
    attStatus = json['AttStatus'] != null ? json['AttStatus'] : "";
    effectiveAttendance =
        json['EffectiveAttendance'] != null ? json['EffectiveAttendance'] : "";
    leaveAvailed = json['LeaveAvailed'] != null ? json['LeaveAvailed'] : "";
    department = json['Department'] != null ? json['Department'] : "";
    groupName = json['GroupName'] != null ? json['GroupName'] : "";
    empno = json['Empno'] != null ? json['Empno'] : "";
    desigName = json['DesigName'] != null ? json['DesigName'] : "";
    dateOfBirth = json['DateOfBirth'] != null ? json['DateOfBirth'] : "";
    bloodGroup = json['BloodGroup'] != null ? json['BloodGroup'] : "";
    prsAddr = json['PrsAddr'] != null ? json['PrsAddr'] : "";
    mobileNo = json['MobileNo'] != null ? json['MobileNo'] : "";
    emailID = json['EmailID'] != null ? json['EmailID'] : "";
    designation = json['Designation'] != null ? json['Designation'] : "";
    groupID = json['GroupID'] != null ? json['GroupID'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['EffectiveAbsent'] = this.effectiveAbsent;
    data['AttStatus'] = this.attStatus;
    data['EffectiveAttendance'] = this.effectiveAttendance;
    data['LeaveAvailed'] = this.leaveAvailed;
    data['Department'] = this.department;
    data['GroupName'] = this.groupName;
    data['Empno'] = this.empno;
    data['DesigName'] = this.desigName;
    data['DateOfBirth'] = this.dateOfBirth;
    data['BloodGroup'] = this.bloodGroup;
    data['PrsAddr'] = this.prsAddr;
    data['MobileNo'] = this.mobileNo;
    data['EmailID'] = this.emailID;
    data['Designation'] = this.designation;
    data['GroupID'] = this.groupID;
    return data;
  }
}
