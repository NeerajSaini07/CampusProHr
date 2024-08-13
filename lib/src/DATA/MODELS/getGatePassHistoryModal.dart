class GetGatePassHistoryModal {
  int? id;
  int? stuId;
  String? name;
  String? relWithStu;
  String? contactNo;
  String? purpose;
  String? time;
  String? toTime;
  String? passType;
  String? studentEmployeeName;

  GetGatePassHistoryModal(
      {this.id,
      this.stuId,
      this.name,
      this.relWithStu,
      this.contactNo,
      this.purpose,
      this.time,
      this.toTime,
      this.passType,
      this.studentEmployeeName});

  GetGatePassHistoryModal.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    stuId = json['StuId'];
    name = json['Name'];
    relWithStu = json['RelWithStu'];
    contactNo = json['ContactNo'];
    purpose = json['Purpose'];
    time = json['Time'];
    toTime = json['ToTime'];
    passType = json['PassType'];
    studentEmployeeName = json['StudentEmployeeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['StuId'] = this.stuId;
    data['Name'] = this.name;
    data['RelWithStu'] = this.relWithStu;
    data['ContactNo'] = this.contactNo;
    data['Purpose'] = this.purpose;
    data['Time'] = this.time;
    data['ToTime'] = this.toTime;
    data['PassType'] = this.passType;
    data['StudentEmployeeName'] = this.studentEmployeeName;
    return data;
  }
}
