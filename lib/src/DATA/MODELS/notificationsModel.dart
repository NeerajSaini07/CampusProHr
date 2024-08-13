class NotificationsModel {
  String? smsId = "";
  String? smsType = "";
  String? toNumber = "";
  String? alertDate = "";
  String? alertMessage = "";

  NotificationsModel(
      {this.smsId,
      this.smsType,
      this.toNumber,
      this.alertDate,
      this.alertMessage});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    smsId = json['SmsId'] != null ? json['SmsId'] : "";
    smsType = json['SmsType'] != null ? json['SmsType'] : "";
    toNumber = json['ToNumber'] != null ? json['ToNumber'] : "";
    alertDate = json['AlertDate'] != null ? json['AlertDate'] : "";
    alertMessage = json['AlertMessage'] != null ? json['AlertMessage'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SmsId'] = this.smsId;
    data['SmsType'] = this.smsType;
    data['ToNumber'] = this.toNumber;
    data['AlertDate'] = this.alertDate;
    data['AlertMessage'] = this.alertMessage;
    return data;
  }
}
