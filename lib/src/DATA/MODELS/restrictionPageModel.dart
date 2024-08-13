class RestrictionPageModel {
  int? messageid;
  int? messagetype;
  int? alertLimit1;
  int? alertLimit2;
  String? message;
  String? fromDate;
  int? gotopayment;

  RestrictionPageModel(
      {this.messageid,
      this.messagetype,
      this.alertLimit1,
      this.alertLimit2,
      this.message,
      this.fromDate,
      this.gotopayment});

  RestrictionPageModel.fromJson(Map<String, dynamic> json) {
    messageid = json['Messageid'] ?? -1;
    messagetype = json['Messagetype'] ?? -1;
    alertLimit1 = json['AlertLimit1'] ?? -1;
    alertLimit2 = json['AlertLimit2'] ?? -1;
    message = json['Message'] ?? "";
    fromDate = json['FromDate'] ?? "";
    gotopayment = json['gotopayment'] ?? -1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Messageid'] = this.messageid;
    data['Messagetype'] = this.messagetype;
    data['AlertLimit1'] = this.alertLimit1;
    data['AlertLimit2'] = this.alertLimit2;
    data['Message'] = this.message;
    data['FromDate'] = this.fromDate;
    data['gotopayment'] = this.gotopayment;
    return data;
  }
}
