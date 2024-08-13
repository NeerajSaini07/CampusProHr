class ResultAnnounceClassModel {
  String? id = "";
  String? className = "";
  int? classDisplayOrder = -1;

  ResultAnnounceClassModel({this.id, this.className, this.classDisplayOrder});

  ResultAnnounceClassModel.fromJson(Map<String, dynamic> json) {
    id = json['ID'] != null ? json['ID'].toString() : "";
    className = json['ClassName'] != null ? json['ClassName'] : "";
    classDisplayOrder =
        json['ClassDisplayOrder'] != null ? json['ClassDisplayOrder'] : -1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ID'] = this.id;
    data['ClassName'] = this.className;
    data['ClassDisplayOrder'] = this.classDisplayOrder;
    return data;
  }
}
