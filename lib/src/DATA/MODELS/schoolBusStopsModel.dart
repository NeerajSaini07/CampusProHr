class SchoolBusStopsModel {
  String? routeName;
  int? stopID;
  String? stopName;
  String? pickUpTime;
  String? dropOffTime;
  String? lattitude;
  String? longitude;

  SchoolBusStopsModel(
      {this.routeName,
      this.stopID,
      this.stopName,
      this.pickUpTime,
      this.dropOffTime,
      this.lattitude,
      this.longitude});

  SchoolBusStopsModel.fromJson(Map<String, dynamic> json) {
    routeName = json['RouteName'] ?? "";
    stopID = json['StopID'] ?? 0;
    stopName = json['StopName'] ?? "";
    pickUpTime = json['PickUpTime'] ?? "";
    dropOffTime = json['DropOffTime'] ?? "";
    lattitude = json['Lattitude'] ?? "";
    longitude = json['Longitude'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RouteName'] = this.routeName;
    data['StopID'] = this.stopID;
    data['StopName'] = this.stopName;
    data['PickUpTime'] = this.pickUpTime;
    data['DropOffTime'] = this.dropOffTime;
    data['Lattitude'] = this.lattitude;
    data['Longitude'] = this.longitude;
    return data;
  }
}
