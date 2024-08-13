class SchoolBusRouteModel {
  List<BusStopModel>? busStop = [];
  List<BusRoutePolylineModel>? polyline = [];
  String? origin;
  String? destination;

  SchoolBusRouteModel({this.busStop, this.polyline});

  SchoolBusRouteModel.fromJson(Map<String, dynamic> json) {
    if (json['BusStop'] != null) {
      busStop = <BusStopModel>[];
      json['BusStop'].forEach((v) {
        busStop!.add(new BusStopModel.fromJson(v));
      });
    }
    if (json['Polyline'] != null) {
      polyline = <BusRoutePolylineModel>[];
      json['Polyline'].forEach((v) {
        polyline!.add(new BusRoutePolylineModel.fromJson(v));
      });
    }
    this.origin = json["origin"] != null ? json["origin"] : "";
    this.destination = json["destination"] != null ? json["destination"] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.busStop != null) {
      data['BusStop'] = this.busStop!.map((v) => v.toJson()).toList();
    }
    if (this.polyline != null) {
      data['Polyline'] = this.polyline!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BusStopModel {
  String? stopName = '';
  String? lattitude = '';
  String? longitude = '';

  BusStopModel({this.stopName, this.lattitude, this.longitude});

  BusStopModel.fromJson(Map<String, dynamic> json) {
    stopName = json['StopName'];
    lattitude = json['Lattitude'];
    longitude = json['Longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StopName'] = this.stopName;
    data['Lattitude'] = this.lattitude;
    data['Longitude'] = this.longitude;
    return data;
  }
}

class BusRoutePolylineModel {
  double? lat = 0;
  double? lng = 0;

  BusRoutePolylineModel({this.lat, this.lng});

  BusRoutePolylineModel.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

// class BusStopModel {
//   String? stopName;
//   String? lattitude;
//   String? longitude;

//   BusStopModel({this.stopName, this.lattitude, this.longitude});

//   BusStopModel.fromJson(Map<String, dynamic> json) {
//     stopName = json['StopName'];
//     lattitude = json['Lattitude'];
//     longitude = json['Longitude'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['StopName'] = this.stopName;
//     data['Lattitude'] = this.lattitude;
//     data['Longitude'] = this.longitude;
//     return data;
//   }
// }

// class BusRoutePolylineModel {
//   double? lat;
//   double? lng;

//   BusRoutePolylineModel({this.lat, this.lng});

//   BusRoutePolylineModel.fromJson(Map<String, dynamic> json) {
//     lat = json['lat'];
//     lng = json['lng'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['lat'] = this.lat;
//     data['lng'] = this.lng;
//     return data;
//   }
// }
