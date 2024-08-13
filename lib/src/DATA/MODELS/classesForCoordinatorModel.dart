class ClassesForCoordinatorModel {
  String? className;
  String? classId;

  ClassesForCoordinatorModel({this.className, this.classId});

  ClassesForCoordinatorModel.fromJson(Map<String, dynamic> json) {
    this.classId = json['ClassId'];
    this.className = json['ClassName'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['ClassId'] = classId;
    data['ClassName'] = className;
    return data;
  }
}
