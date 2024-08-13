class MeetingPlatformsModel {
  int? plateformid = -1;
  String? name = '';

  MeetingPlatformsModel({this.plateformid, this.name});

  MeetingPlatformsModel.fromJson(Map<String, dynamic> json) {
    plateformid = json['Plateformid'] != null ? json['Plateformid'] : -1;
    name = json['Name'] != null ? json['Name'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Plateformid'] = this.plateformid;
    data['Name'] = this.name;
    return data;
  }
}
