class SchoolBusLiveLocationModel {
  int? vId = 0;
  String? vehicleNumber = '';
  String? deviceId = '';
  String? cordinate = '';
  String? address = '';
  String? city = '';
  String? state = '';
  String? motionStatus = '';
  String? motionState = '';
  String? speed = '';
  String? shareLink = '';
  String? latitude = '';
  String? longitude = '';
  String? orientation = '';
  // List restBus=[[lat,long,or,add],[]];
  List? otherBuses = [];

  SchoolBusLiveLocationModel({
    this.vId,
    this.vehicleNumber,
    this.deviceId,
    this.cordinate,
    this.address,
    this.city,
    this.state,
    this.motionStatus,
    this.motionState,
    this.speed,
    this.shareLink,
    this.latitude,
    this.longitude,
    this.orientation,
    this.otherBuses,
  });

  SchoolBusLiveLocationModel.fromJson(Map<String, dynamic> json) {
    vId = json['VId'] != null ? json['VId'] : -1;
    vehicleNumber =
        json['Vehicle_number'] != null ? json['Vehicle_number'] : "";
    deviceId = json['device_id'] != null ? json['device_id'] : "";
    cordinate = json['cordinate'] != null ? json['cordinate'] : "";
    address = json['address'] != null ? json['address'] : "";
    city = json['city'] != null ? json['city'] : "";
    state = json['state'] != null ? json['state'] : "";
    motionStatus = json['motion_status'] != null ? json['motion_status'] : "";
    motionState = json['motion_state'] != null ? json['motion_state'] : "";
    speed = json['speed'] != null ? json['speed'] : "";
    shareLink = json['share_link'] != null ? json['share_link'] : "";
    latitude = json['Latitude'] != null ? json['Latitude'] : "";
    longitude = json['Longitude'] != null ? json['Longitude'] : "";
    orientation = json['orientation'] != null ? json['orientation'] : "";
    otherBuses = json["OtherBuses"] != null ? json["OtherBuses"] : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VId'] = this.vId;
    data['vehicle_number'] = this.vehicleNumber;
    data['device_id'] = this.deviceId;
    data['cordinate'] = this.cordinate;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['motion_status'] = this.motionStatus;
    data['motion_state'] = this.motionState;
    data['speed'] = this.speed;
    data['share_link'] = this.shareLink;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['orientation'] = this.orientation;
    return data;
  }
}

// class SchoolBusLiveLocationModel {
//   String? vehicleNumber = '';
//   String? deviceId = '';
//   String? type = '';
//   List<String>? cordinate = [];
//   String? address = '';
//   String? city = '';
//   String? state = '';
//   String? motionStatus = '';
//   double? speed = -1;
//   String? orientation = '';
//   String? shareLink = '';

//   SchoolBusLiveLocationModel(
//       {this.vehicleNumber,
//       this.deviceId,
//       this.type,
//       this.cordinate,
//       this.address,
//       this.city,
//       this.state,
//       this.motionStatus,
//       this.speed,
//       this.orientation,
//       this.shareLink});

//   SchoolBusLiveLocationModel.fromJson(Map<String, dynamic> json) {
//     vehicleNumber = json['vehicle_number'];
//     deviceId = json['device_id'];
//     type = json['type'];
//     cordinate = json['cordinate'].cast<String>();
//     address = json['address'];
//     city = json['city'];
//     state = json['state'];
//     motionStatus = json['motion_status'];
//     speed = json['speed'];
//     orientation = json['orientation'];
//     shareLink = json['share_link'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['vehicle_number'] = this.vehicleNumber;
//     data['device_id'] = this.deviceId;
//     data['type'] = this.type;
//     data['cordinate'] = this.cordinate;
//     data['address'] = this.address;
//     data['city'] = this.city;
//     data['state'] = this.state;
//     data['motion_status'] = this.motionStatus;
//     data['speed'] = this.speed;
//     data['orientation'] = this.orientation;
//     data['share_link'] = this.shareLink;
//     return data;
//   }
// }
