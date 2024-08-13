class SetPlateformModel {
  int? empJoinOnPlatformApp = -1;
  int? stuJoinOnPlatformApp = -1;

  SetPlateformModel({this.empJoinOnPlatformApp, this.stuJoinOnPlatformApp});

  SetPlateformModel.fromJson(Map<String, dynamic> json) {
    empJoinOnPlatformApp = json['EmpJoinOnPlatformApp'] != null
        ? json['EmpJoinOnPlatformApp']
        : "";
    stuJoinOnPlatformApp = json['StuJoinOnPlatformApp'] != null
        ? json['StuJoinOnPlatformApp']
        : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmpJoinOnPlatformApp'] = this.empJoinOnPlatformApp;
    data['StuJoinOnPlatformApp'] = this.stuJoinOnPlatformApp;
    return data;
  }
}
