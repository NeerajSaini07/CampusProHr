class AdmissionStatusModel {
  String? lbltotalstudent;
  String? lbltotalhostel;
  String? lblnewadsession;
  String? lblnewhsession;
  String? lblreaddsession;
  String? lblrehsession;
  String? lblnewtoday;
  String? lblhtoday;
  String? lblretoday;
  String? lblrehtoday;
  String? lbloldpending;
  String? lbloldpendinghos;
  String? lblpreyeartotal;
  String? lblpreyearhosteler;
  String? lblpreyearhostelernew;
  String? lblpreyearhostelerold;
  String? lblpreyearnew;
  String? lblpreyearold;
  String? txttotalpreyearhosteler;
  String? txttotalpreyearhostelernew;
  String? txttotalpreyearhostelerold;
  String? txtalldayscholarhostalr;
  String? txtalldayschoarhostalrnew;
  String? txtalldayschoarhostalrold;
  String? txttotalnewtoday;
  String? txttotaloldtoday;

  AdmissionStatusModel(
      {this.lbltotalstudent,
      this.lbltotalhostel,
      this.lblnewadsession,
      this.lblnewhsession,
      this.lblreaddsession,
      this.lblrehsession,
      this.lblnewtoday,
      this.lblhtoday,
      this.lblretoday,
      this.lblrehtoday,
      this.lbloldpending,
      this.lbloldpendinghos,
      this.lblpreyeartotal,
      this.lblpreyearhosteler,
      this.lblpreyearhostelernew,
      this.lblpreyearhostelerold,
      this.lblpreyearnew,
      this.lblpreyearold,
      this.txttotalpreyearhosteler,
      this.txttotalpreyearhostelernew,
      this.txttotalpreyearhostelerold,
      this.txtalldayscholarhostalr,
      this.txtalldayschoarhostalrnew,
      this.txtalldayschoarhostalrold,
      this.txttotalnewtoday,
      this.txttotaloldtoday});

  AdmissionStatusModel.fromJson(Map<String, dynamic> json) {
    lbltotalstudent = json['lbltotalstudent'] ?? "";
    lbltotalhostel = json['lbltotalhostel'] ?? "";
    lblnewadsession = json['lblnewadsession'] ?? "";
    lblnewhsession = json['lblnewhsession'] ?? "";
    lblreaddsession = json['lblreaddsession'] ?? "";
    lblrehsession = json['lblrehsession'] ?? "";
    lblnewtoday = json['lblnewtoday'] ?? "";
    lblhtoday = json['lblhtoday'] ?? "";
    lblretoday = json['lblretoday'] ?? "";
    lblrehtoday = json['lblrehtoday'] ?? "";
    lbloldpending = json['lbloldpending'] ?? "";
    lbloldpendinghos = json['lbloldpendinghos'] ?? "";
    lblpreyeartotal = json['lblpreyeartotal'] ?? "";
    lblpreyearhosteler = json['lblpreyearhosteler'] ?? "";
    lblpreyearhostelernew = json['lblpreyearhostelernew'] ?? "";
    lblpreyearhostelerold = json['lblpreyearhostelerold'] ?? "";
    lblpreyearnew = json['lblpreyearnew'] ?? "";
    lblpreyearold = json['lblpreyearold'] ?? "";
    txttotalpreyearhosteler = json['txttotalpreyearhosteler'] ?? "";
    txttotalpreyearhostelernew = json['txttotalpreyearhostelernew'] ?? "";
    txttotalpreyearhostelerold = json['txttotalpreyearhostelerold'] ?? "";
    txtalldayscholarhostalr = json['txtalldayscholarhostalr'] ?? "";
    txtalldayschoarhostalrnew = json['txtalldayschoarhostalrnew'] ?? "";
    txtalldayschoarhostalrold = json['txtalldayschoarhostalrold'] ?? "";
    txttotalnewtoday = json['txttotalnewtoday'] ?? "";
    txttotaloldtoday = json['txttotaloldtoday'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lbltotalstudent'] = this.lbltotalstudent;
    data['lbltotalhostel'] = this.lbltotalhostel;
    data['lblnewadsession'] = this.lblnewadsession;
    data['lblnewhsession'] = this.lblnewhsession;
    data['lblreaddsession'] = this.lblreaddsession;
    data['lblrehsession'] = this.lblrehsession;
    data['lblnewtoday'] = this.lblnewtoday;
    data['lblhtoday'] = this.lblhtoday;
    data['lblretoday'] = this.lblretoday;
    data['lblrehtoday'] = this.lblrehtoday;
    data['lbloldpending'] = this.lbloldpending;
    data['lbloldpendinghos'] = this.lbloldpendinghos;
    data['lblpreyeartotal'] = this.lblpreyeartotal;
    data['lblpreyearhosteler'] = this.lblpreyearhosteler;
    data['lblpreyearhostelernew'] = this.lblpreyearhostelernew;
    data['lblpreyearhostelerold'] = this.lblpreyearhostelerold;
    data['lblpreyearnew'] = this.lblpreyearnew;
    data['lblpreyearold'] = this.lblpreyearold;
    data['txttotalpreyearhosteler'] = this.txttotalpreyearhosteler;
    data['txttotalpreyearhostelernew'] = this.txttotalpreyearhostelernew;
    data['txttotalpreyearhostelerold'] = this.txttotalpreyearhostelerold;
    data['txtalldayscholarhostalr'] = this.txtalldayscholarhostalr;
    data['txtalldayschoarhostalrnew'] = this.txtalldayschoarhostalrnew;
    data['txtalldayschoarhostalrold'] = this.txtalldayschoarhostalrold;
    data['txttotalnewtoday'] = this.txttotalnewtoday;
    data['txttotaloldtoday'] = this.txttotaloldtoday;
    return data;
  }
}
