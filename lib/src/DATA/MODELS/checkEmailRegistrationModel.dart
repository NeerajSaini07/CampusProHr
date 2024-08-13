class CheckEmailRegistrationModel {
  String? loginOTPFeature = "";
  String? mailVerified = "";

  CheckEmailRegistrationModel({this.loginOTPFeature, this.mailVerified});

  CheckEmailRegistrationModel.fromJson(Map<String, dynamic> json) {
    loginOTPFeature =
        json['LoginOTPFeature'] != null ? json['LoginOTPFeature'] : "";
    mailVerified = json['MailVerified'] != null ? json['MailVerified'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LoginOTPFeature'] = this.loginOTPFeature;
    data['MailVerified'] = this.mailVerified;
    return data;
  }
}
