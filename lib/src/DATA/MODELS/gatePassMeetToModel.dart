class GatePassMeetToModel {
  int? id;
  String? name;

  GatePassMeetToModel({this.id, this.name});

  GatePassMeetToModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    return data;
  }
}
