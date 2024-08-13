class GetSelectClassCoordinatorModel {
  String? classID = "";
  String? className = "";

  GetSelectClassCoordinatorModel({this.classID, this.className});

  GetSelectClassCoordinatorModel.fromJson(Map<String, dynamic> json) {
    classID = json['ClassID'] != null ? json['ClassID'] : "";
    className = json['ClassName'] != null ? json['ClassName'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClassID'] = this.classID;
    data['ClassName'] = this.className;
    return data;
  }
}
