class LoadBusRoutesModel {
  int? routeId = -1;
  String? routeName = "";

  LoadBusRoutesModel({this.routeName, this.routeId});

  LoadBusRoutesModel.fromJson(Map<String, dynamic> json) {
    this.routeId = json['RouteID'] != null ? json['RouteID'] : -1;
    this.routeName = json['RouteName'] != null ? json['RouteName'] : "";
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['RouteID'] = this.routeId;
    data['RouteName'] = this.routeName;
    return data;
  }
}
