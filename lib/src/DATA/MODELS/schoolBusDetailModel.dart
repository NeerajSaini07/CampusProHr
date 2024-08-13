class SchoolBusDetailModel {
  String? stopName = '';
  String? pickUpTime = '';
  String? dropOffTime = '';
  String? lattitude = '';
  String? longitude = '';
  String? busNo = '';
  String? regNo = '';
  String? trackingDeviceIMEI = '';
  String? routeName = '';
  String? driverName = '';
  String? conductorName = '';
  String? driverMobileNo = '';

  SchoolBusDetailModel(
      {this.stopName,
      this.pickUpTime,
      this.dropOffTime,
      this.lattitude,
      this.longitude,
      this.busNo,
      this.regNo,
      this.trackingDeviceIMEI,
      this.routeName,
      this.driverName,
      this.conductorName,
      this.driverMobileNo});

  SchoolBusDetailModel.fromJson(Map<String, dynamic> json) {
    stopName = json['StopName'] != null ? json['StopName'] : "";
    pickUpTime = json['PickUpTime'] != null ? json['PickUpTime'] : "";
    dropOffTime = json['DropOffTime'] != null ? json['DropOffTime'] : "";
    lattitude = json['Lattitude'] != null ? json['Lattitude'] : "";
    longitude = json['Longitude'] != null ? json['Longitude'] : "";
    busNo = json['Bus_No'] != null ? json['Bus_No'] : "";
    regNo = json['Reg_No'] != null ? json['Reg_No'] : "";
    trackingDeviceIMEI =
        json['TrackingDeviceIMEI'] != null ? json['TrackingDeviceIMEI'] : "";
    routeName = json['RouteName'] != null ? json['RouteName'] : "";
    driverName = json['DriverName'] != null ? json['DriverName'] : "";
    conductorName = json['ConductorName'] != null ? json['ConductorName'] : "";
    driverMobileNo =
        json['DriverMobileNo'] != null ? json['DriverMobileNo'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StopName'] = this.stopName;
    data['PickUpTime'] = this.pickUpTime;
    data['DropOffTime'] = this.dropOffTime;
    data['Lattitude'] = this.lattitude;
    data['Longitude'] = this.longitude;
    data['Bus_No'] = this.busNo;
    data['Reg_No'] = this.regNo;
    data['TrackingDeviceIMEI'] = this.trackingDeviceIMEI;
    data['RouteName'] = this.routeName;
    data['DriverName'] = this.driverName;
    data['ConductorName'] = this.conductorName;
    data['DriverMobileNo'] = this.driverMobileNo;
    return data;
  }
}
