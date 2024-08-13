class LoadUserTypeSendSmsModel {
  String? id = "";
  String? userType = "";
  String? shortName = "";

  LoadUserTypeSendSmsModel({this.id, this.userType, this.shortName});

  LoadUserTypeSendSmsModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'] != null ? json['id'] : "";
    this.shortName = json['shortname'] != null ? json['shortname'] : "";
    this.userType = json['usertype'] != null ? json['usertype'] : "";
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['shortname'] = this.shortName;
    data['usertype'] = this.userType;
    return data;
  }
}
