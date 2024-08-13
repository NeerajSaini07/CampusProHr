class NearByBusesModel {
  String? vehicleNo;
  String? deviceId;
  String? distance;

  NearByBusesModel({this.vehicleNo, this.deviceId, this.distance});

  NearByBusesModel.fromJson(Map<String, dynamic> json) {
    vehicleNo = json['VehicleNo'] ?? "";
    deviceId = json['DeviceId'] ?? "";
    distance = json['Distance'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VehicleNo'] = this.vehicleNo;
    data['DeviceId'] = this.deviceId;
    data['Distance'] = this.distance;
    return data;
  }
}
