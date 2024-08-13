class LoadEmployeeGroupsModel {
  int? id = -1;
  String? paramName = "";

  LoadEmployeeGroupsModel({this.id, this.paramName});

  LoadEmployeeGroupsModel.fromJson(Map<String, dynamic> json) {
    this.id = json['ID'] != null ? json['ID'] : -1;
    this.paramName = json['ParamName'] != null ? json['ParamName'] : "";
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['ID'] = this.id;
    data['ParamName'] = this.paramName;
    return data;
  }
}
