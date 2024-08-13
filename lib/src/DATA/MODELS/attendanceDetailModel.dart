class AttendanceDetailModel {
  String? guardianMobileNo = "";
  String? studentId = "";
  String? fatherName = "";
  String? stName = "";
  String? onlyName = "";
  String? onlyAdmNo = "";
  String? rollNo = "";
  String? attStatus = "";
  String? status1 = "";
  String? status2 = "";
  String? status3 = "";
  String? status4 = "";
  String? status5 = "";
  String? status6 = "";
  String? status7 = "";
  String? status8 = "";
  String? status9 = "";
  String? status10 = "";
  String? status1Date = "";
  String? status2Date = "";
  String? status3Date = "";
  String? status4Date = "";
  String? status5Date = "";
  String? status6Date = "";
  String? status7Date = "";
  String? status8Date = "";
  String? status9Date = "";
  String? status10Date = "";

  AttendanceDetailModel(
      {this.guardianMobileNo,
      this.studentId,
      this.fatherName,
      this.stName,
      this.onlyName,
      this.onlyAdmNo,
      this.rollNo,
      this.attStatus,
      this.status1,
      this.status2,
      this.status3,
      this.status4,
      this.status5,
      this.status6,
      this.status7,
      this.status8,
      this.status9,
      this.status10,
      this.status1Date,
      this.status2Date,
      this.status3Date,
      this.status4Date,
      this.status5Date,
      this.status6Date,
      this.status7Date,
      this.status8Date,
      this.status9Date,
      this.status10Date});

  AttendanceDetailModel.fromJson(Map<String, dynamic> json) {
    guardianMobileNo =
        json['GuardianMobileNo'] != null ? json['GuardianMobileNo'] : "";
    studentId = json['StudentId'] != null ? json['StudentId'] : "";
    fatherName = json['FatherName'] != null ? json['FatherName'] : "";
    stName = json['StName'] != null ? json['StName'] : "";
    onlyName = json['OnlyName'] != null ? json['OnlyName'] : "";
    onlyAdmNo = json['OnlyAdmNo'] != null ? json['OnlyAdmNo'] : "";
    rollNo = json['RollNo'] != null ? json['RollNo'] : "";
    attStatus = json['AttStatus'] != null ? json['AttStatus'] : "";
    status1 = json['Status1'] != null ? json['Status1'] : "";
    status2 = json['Status2'] != null ? json['Status2'] : "";
    status3 = json['Status3'] != null ? json['Status3'] : "";
    status4 = json['Status4'] != null ? json['Status4'] : "";
    status5 = json['Status5'] != null ? json['Status5'] : "";
    status6 = json['Status6'] != null ? json['Status6'] : "";
    status7 = json['Status7'] != null ? json['Status7'] : "";
    status8 = json['Status8'] != null ? json['Status8'] : "";
    status9 = json['Status9'] != null ? json['Status9'] : "";
    status10 = json['Status10'] != null ? json['Status10'] : "";
    status1Date = json['Status1Date'] != null ? json['Status1Date'] : "";
    status2Date = json['Status2Date'] != null ? json['Status2Date'] : "";
    status3Date = json['Status3Date'] != null ? json['Status3Date'] : "";
    status4Date = json['Status4Date'] != null ? json['Status4Date'] : "";
    status5Date = json['Status5Date'] != null ? json['Status5Date'] : "";
    status6Date = json['Status6Date'] != null ? json['Status6Date'] : "";
    status7Date = json['Status7Date'] != null ? json['Status7Date'] : "";
    status8Date = json['Status8Date'] != null ? json['Status8Date'] : "";
    status9Date = json['Status9Date'] != null ? json['Status9Date'] : "";
    status10Date = json['Status10Date'] != null ? json['Status10Date'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GuardianMobileNo'] = this.guardianMobileNo;
    data['StudentId'] = this.studentId;
    data['FatherName'] = this.fatherName;
    data['StName'] = this.stName;
    data['OnlyName'] = this.onlyName;
    data['OnlyAdmNo'] = this.onlyAdmNo;
    data['RollNo'] = this.rollNo;
    data['AttStatus'] = this.attStatus;
    data['Status1'] = this.status1;
    data['Status2'] = this.status2;
    data['Status3'] = this.status3;
    data['Status4'] = this.status4;
    data['Status5'] = this.status5;
    data['Status6'] = this.status6;
    data['Status7'] = this.status7;
    data['Status8'] = this.status8;
    data['Status9'] = this.status9;
    data['Status10'] = this.status10;
    data['Status1Date'] = this.status1Date;
    data['Status2Date'] = this.status2Date;
    data['Status3Date'] = this.status3Date;
    data['Status4Date'] = this.status4Date;
    data['Status5Date'] = this.status5Date;
    data['Status6Date'] = this.status6Date;
    data['Status7Date'] = this.status7Date;
    data['Status8Date'] = this.status8Date;
    data['Status9Date'] = this.status9Date;
    data['Status10Date'] = this.status10Date;
    return data;
  }
}
