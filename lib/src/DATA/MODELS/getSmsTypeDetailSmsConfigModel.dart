class GetSmsTypeDetailSmsConfigModel {
  String? smsType = "";

  GetSmsTypeDetailSmsConfigModel(this.smsType);

  GetSmsTypeDetailSmsConfigModel.fromJson(Map<String, dynamic> json) {
    this.smsType = json['smstype'] != null ? json['smstype'] : "";
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['smstype'] = this.smsType;
    return data;
  }
}
