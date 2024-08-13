class GetBusHistoryModel {
  String? lat;
  String? lng;

  GetBusHistoryModel({this.lat, this.lng});

  GetBusHistoryModel.fromJson(Map<String, dynamic> json) {
    lat = json['lat'] != null ? json['lat'] : "";
    lng = json['lng'] != null ? json['lng'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
