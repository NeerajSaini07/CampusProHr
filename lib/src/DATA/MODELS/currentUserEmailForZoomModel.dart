class CurrentUserEmailForZoomModel {
  String? aPIKEY = '';
  String? aPISECRET = '';
  String? jWtToken = '';
  String? hostEmail = '';
  int? createmeetingapi = -1;
  int? empID = -1;
  String? hostPass = '';

  CurrentUserEmailForZoomModel(
      {this.aPIKEY,
      this.aPISECRET,
      this.jWtToken,
      this.hostEmail,
      this.createmeetingapi,
      this.empID,
      this.hostPass});

  CurrentUserEmailForZoomModel.fromJson(Map<String, dynamic> json) {
    aPIKEY = json['API_KEY'] != null ? json['API_KEY'] : "";
    aPISECRET = json['API_SECRET'] != null ? json['API_SECRET'] : "";
    jWtToken = json['JWtToken'] != null ? json['JWtToken'] : "";
    hostEmail = json['Host_Email'] != null ? json['Host_Email'] : "";
    createmeetingapi =
        json['Createmeetingapi'] != null ? json['Createmeetingapi'] : -1;
    empID = json['EmpID'] != null ? json['EmpID'] : -1;
    hostPass = json['Host_Pass'] != null ? json['Host_Pass'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['API_KEY'] = this.aPIKEY;
    data['API_SECRET'] = this.aPISECRET;
    data['JWtToken'] = this.jWtToken;
    data['Host_Email'] = this.hostEmail;
    data['Createmeetingapi'] = this.createmeetingapi;
    data['EmpID'] = this.empID;
    data['Host_Pass'] = this.hostPass;
    return data;
  }
}
