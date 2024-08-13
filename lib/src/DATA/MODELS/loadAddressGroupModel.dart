class LoadAddressGroupModel {
  String? id = "";
  String? paramName = "";

  LoadAddressGroupModel({this.paramName, this.id});

  LoadAddressGroupModel.fromJson(Map<String, dynamic> json) {
    this.id = json['ID'] != null ? json['ID'] : "";
    this.paramName = json['ParamName'] != null ? json['ParamName'] : "";
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['ID'] = this.id;
    data['ParamName'] = this.id;
    return data;
  }
}
