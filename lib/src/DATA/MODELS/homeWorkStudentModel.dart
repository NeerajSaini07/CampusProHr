class HomeWorkStudentModel {
  String? iD = "";
  String? attDate = "";
  String? homeworkMsg = "";
  String? subjectName = "";
  String? homeworkURL = "";
  String? name = "";

  HomeWorkStudentModel(
      {this.iD,
      this.attDate,
      this.homeworkMsg,
      this.subjectName,
      this.homeworkURL,
      this.name});

  HomeWorkStudentModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'] != null ? json['ID'] : "";
    attDate = json['AttDate'] != null ? json['AttDate'] : "";
    homeworkMsg = json['HomeworkMsg'] != null ? json['HomeworkMsg'] : "";
    subjectName = json['SubjectName'] != null ? json['SubjectName'] : "";
    homeworkURL = json['HomeworkURL'] != null ? json['HomeworkURL'] : "";
    name = json['Name'] != null ? json['Name'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['AttDate'] = this.attDate;
    data['HomeworkMsg'] = this.homeworkMsg;
    data['SubjectName'] = this.subjectName;
    data['HomeworkURL'] = this.homeworkURL;
    data['Name'] = this.name;
    return data;
  }
}
