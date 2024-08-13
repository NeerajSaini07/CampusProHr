class GetPopupAlertListModel {
  String? message = "";
  int? alertId = -1;
  String? groupName = "";
  String? alertLimit1 = "";
  String? alertLimit2 = "";
  String? tillDate = "";

  GetPopupAlertListModel(
      {this.tillDate,
      this.message,
      this.groupName,
      this.alertId,
      this.alertLimit1,
      this.alertLimit2});

  GetPopupAlertListModel.fromJson(Map<String, dynamic> json) {
    this.alertLimit2 = json['AlertLimit2'] != null ? json['AlertLimit2'] : "";
    this.alertLimit1 = json['AlertLimit1'] != null ? json['AlertLimit1'] : "";
    this.alertId = json['AlertId'] != null ? json['AlertId'] : "";
    this.groupName = json['GroupName'] != null ? json['GroupName'] : "";
    this.message = json['Message'] != null ? json['Message'] : "";
    this.tillDate = json['TillDate'] != null ? json['TillDate'] : "";
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['AlertLimit2'] = this.alertLimit2;
    data['AlertLimit1'] = this.alertLimit1;
    data['AlertId'] = this.alertId;
    data['GroupName'] = this.groupName;
    data['Message'] = this.message;
    data['TillDate'] = this.tillDate;
    return data;
  }
}
