class FeeBalanceClassListEmployeeModel {
  String? classId;
  String? className;
  String? isClassTeacher;
  String? allowSendHomework;

  FeeBalanceClassListEmployeeModel(
      {this.classId,
      this.className,
      this.isClassTeacher,
      this.allowSendHomework});

  FeeBalanceClassListEmployeeModel.fromJson(Map<String, dynamic> json) {
    classId = json['ClassId'] != null ? json['ClassId'] : "";
    className = json['ClassName'] != null ? json['ClassName'] : "";
    isClassTeacher =
        json['IsClassTeacher'] != null ? json['IsClassTeacher'] : "";
    allowSendHomework =
        json['AllowSendHomework'] != null ? json['AllowSendHomework'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClassId'] = this.classId;
    data['ClassName'] = this.className;
    data['IsClassTeacher'] = this.isClassTeacher;
    data['AllowSendHomework'] = this.allowSendHomework;
    return data;
  }
}
