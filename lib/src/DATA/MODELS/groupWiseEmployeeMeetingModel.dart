class GroupWiseEmployeeMeetingModel {
  String? iD = '';
  String? paramname = '';

  GroupWiseEmployeeMeetingModel({this.iD, this.paramname});

  GroupWiseEmployeeMeetingModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'] != null ? json['ID'] : "";
    paramname = json['Paramname'] != null ? json['Paramname'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Paramname'] = this.paramname;
    return data;
  }
}
