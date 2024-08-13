class GetEmployeeOnlineClassCredentialsModel {
  int? empId = -1;
  String? name = "";
  String? mobileNo = "";
  String? aPIKEY = "";
  String? aPISECRET = "";
  String? jWtToken = "";
  String? hostEmail = "";
  String? hostPass = "";

  GetEmployeeOnlineClassCredentialsModel(
      {this.empId,
      this.name,
      this.mobileNo,
      this.aPIKEY,
      this.aPISECRET,
      this.jWtToken,
      this.hostEmail,
      this.hostPass});

  GetEmployeeOnlineClassCredentialsModel.fromJson(Map<String, dynamic> json) {
    empId = json['EmpId'] != null ? json['EmpId'] : "";
    name = json['Name'] != null ? json['Name'] : "";
    mobileNo = json['MobileNo'] != null ? json['MobileNo'] : "";
    aPIKEY = json['API_KEY'] != null ? json['API_KEY'] : "";
    aPISECRET = json['API_SECRET'] != null ? json['API_SECRET'] : "";
    jWtToken = json['JWtToken'] != null ? json['JWtToken'] : "";
    hostEmail = json['Host_Email'] != null ? json['Host_Email'] : "";
    hostPass = json['Host_Pass'] != null ? json['Host_Pass'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmpId'] = this.empId;
    data['Name'] = this.name;
    data['MobileNo'] = this.mobileNo;
    data['API_KEY'] = this.aPIKEY;
    data['API_SECRET'] = this.aPISECRET;
    data['JWtToken'] = this.jWtToken;
    data['Host_Email'] = this.hostEmail;
    data['Host_Pass'] = this.hostPass;
    return data;
  }
}
