class SignInModel {
  String? validated = "";
  String? validateMessage = "";
  String? oUserid = "";
  String? oUserName = "";
  String? sendOTP = "";
  String? token = "";

  SignInModel(
      {this.validated,
      this.validateMessage,
      this.oUserid,
      this.oUserName,
      this.sendOTP,
      this.token});

  SignInModel.fromJson(Map<String, dynamic> json) {
    validated = json['Validated'] != null ? json['Validated'] : "";
    validateMessage =
        json['ValidateMessage'] != null ? json['ValidateMessage'] : "";
    oUserid = json['OUserid'] != null ? json['OUserid'] : "";
    oUserName = json['OUserName'] != null ? json['OUserName'] : "";
    sendOTP = json['SendOTP'] != null ? json['SendOTP'] : "";
    token = json['Token'] != null ? json['Token'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Validated'] = this.validated;
    data['ValidateMessage'] = this.validateMessage;
    data['OUserid'] = this.oUserid;
    data['OUserName'] = this.oUserName;
    data['SendOTP'] = this.sendOTP;
    data['Token'] = this.token;
    return data;
  }
}
