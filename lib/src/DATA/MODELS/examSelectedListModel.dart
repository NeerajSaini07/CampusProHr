class ExamSelectedListModel {
  String? examID = "";
  String? exam = "";
  String? displayOrder = "";

  ExamSelectedListModel({this.examID, this.exam, this.displayOrder});

  ExamSelectedListModel.fromJson(Map<String, dynamic> json) {
    examID = json['ExamID'] != null ? json['ExamID'] : "";
    exam = json['Exam'] != null ? json['Exam'] : "";
    displayOrder = json['DisplayOrder'] != null ? json['DisplayOrder'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ExamID'] = this.examID;
    data['Exam'] = this.exam;
    data['DisplayOrder'] = this.displayOrder;
    return data;
  }
}
