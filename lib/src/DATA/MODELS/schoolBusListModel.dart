class SchoolBusListModel {
  int? busID;
  String? regNo;
  int? noofStops;
  String? trackingDeviceIMEI;
  String? rootNo;
  String? busNo;

  SchoolBusListModel(
      {this.busID,
      this.regNo,
      this.noofStops,
      this.trackingDeviceIMEI,
      this.rootNo,
      this.busNo});

  SchoolBusListModel.fromJson(Map<String, dynamic> json) {
    busID = json['BusID'] ?? 0;
    regNo = json['Reg_No'] ?? "";
    noofStops = json['NoofStops'] ?? 0;
    trackingDeviceIMEI = json['TrackingDeviceIMEI'] ?? "";
    rootNo = json['RootNo'] ?? "";
    busNo = json["busno"] != null ? json["busno"] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BusID'] = this.busID;
    data['Reg_No'] = this.regNo;
    data['NoofStops'] = this.noofStops;
    data['TrackingDeviceIMEI'] = this.trackingDeviceIMEI;
    data['RootNo'] = this.rootNo;
    return data;
  }
}
