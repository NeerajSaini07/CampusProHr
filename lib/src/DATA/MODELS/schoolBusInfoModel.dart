class SchoolBusInfoModel {
  String? regNo;
  String? driverName;
  String? driverMobile;
  String? conductorName;
  String? conductorMobile;
  String? rootNo;

  SchoolBusInfoModel(
      {this.regNo,
      this.driverName,
      this.driverMobile,
      this.conductorName,
      this.conductorMobile,
      this.rootNo});

  SchoolBusInfoModel.fromJson(Map<String, dynamic> json) {
    regNo = json['Reg_No'] ?? "";
    driverName = json['DriverName'] ?? "";
    driverMobile = json['DriverMobile'] ?? "";
    conductorName = json['ConductorName'] ?? "";
    conductorMobile = json['ConductorMobile'] ?? "";
    rootNo = json['RootNo'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Reg_No'] = this.regNo;
    data['DriverName'] = this.driverName;
    data['DriverMobile'] = this.driverMobile;
    data['ConductorName'] = this.conductorName;
    data['ConductorMobile'] = this.conductorMobile;
    data['RootNo'] = this.rootNo;
    return data;
  }
}
