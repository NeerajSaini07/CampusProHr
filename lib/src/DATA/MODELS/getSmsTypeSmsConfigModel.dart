class GetSmsTypeSmsConfigModel {
  String? smsType = "";

  GetSmsTypeSmsConfigModel(this.smsType);
  GetSmsTypeSmsConfigModel.fromJson(Map<String, dynamic> json) {
    this.smsType = json['smstype'] != null ? json['smstype'] : "";
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['smstype'] = this.smsType;
    return data;
  }
}
