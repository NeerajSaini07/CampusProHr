class VisitorListTodayGatePassModel {
  int? id;
  String? entryTime;
  String? exitTime;
  String? visitorName;
  String? number;
  String? visitorAddress;
  String? domainName;
  String? visitorImagePath;

  VisitorListTodayGatePassModel({
    this.id,
    this.entryTime,
    this.exitTime,
    this.visitorName,
    this.number,
    this.visitorAddress,
    this.domainName,
    this.visitorImagePath,
  });

  VisitorListTodayGatePassModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'] != null ? json['Id'] : "";
    entryTime = json['EntryTime'] != null ? json['EntryTime'] : "";
    exitTime = json['ExitTime'] != null ? json['ExitTime'] : "";
    visitorName = json['VisitorName'] != null ? json['VisitorName'] : "";
    number = json['Number'] != null ? json['Number'] : "";
    visitorAddress =
        json['VisitorAddress'] != null ? json['VisitorAddress'] : "";
    domainName = json['DomainName'] != null ? json['DomainName'] : "";
    visitorImagePath =
        json['VisitorImagePath'] != null ? json['VisitorImagePath'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['EntryTime'] = this.entryTime;
    data['ExitTime'] = this.exitTime;
    data['VisitorName'] = this.visitorName;
    data['Number'] = this.number;
    data['VisitorAddress'] = this.visitorAddress;
    data['DomainName'] = this.domainName;
    return data;
  }
}
