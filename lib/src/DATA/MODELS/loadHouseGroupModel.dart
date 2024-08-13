class LoadHouseGroupModel {
  String? id = "";
  String? paramName = "";
  LoadHouseGroupModel({this.paramName, this.id});

  LoadHouseGroupModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'] != null ? json['Id'] : "";
    paramName = json['ParamName'] != null ? json['ParamName'] : "";
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['Id'] = this.id;
    data['ParamName'] = this.paramName;
    return data;
  }
}
