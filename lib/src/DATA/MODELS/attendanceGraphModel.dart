class AttendanceGraphModel {
  String? attDate = "";
  String? newAttDate = "";
  String? attStatus = "";

  AttendanceGraphModel({this.attDate, this.newAttDate, this.attStatus});

  AttendanceGraphModel.fromJson(Map<String, dynamic> json) {
    attDate = json['AttDate'] != null ? json['AttDate'] : "";
    newAttDate = json['NewAttDate'] != null ? json['NewAttDate'] : "";
    attStatus = json['AttStatus'] != null ? json['AttStatus'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AttDate'] = this.attDate;
    data['NewAttDate'] = this.newAttDate;
    data['AttStatus'] = this.attStatus;
    return data;
  }

  @override
  String toString() {
    return 'attDate:$attDate, newAttDate:$newAttDate, attStatus:$attStatus';
  }
}
