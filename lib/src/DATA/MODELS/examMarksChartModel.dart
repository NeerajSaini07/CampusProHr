class ExamMarksChartModel {
  String? exam = '';
  String? subjectName = '';
  String? maxMarks = '';
  String? marksObtain = '';
  String? maxObtained = '';
  String? avgObtained = '';

  ExamMarksChartModel(
      {this.exam,
      this.subjectName,
      this.maxMarks,
      this.marksObtain,
      this.maxObtained,
      this.avgObtained});

  ExamMarksChartModel.fromJson(Map<String, dynamic> json) {
    exam = json['Exam'] != null ? json['Exam'] : "";
    subjectName = json['SubjectName'] != null ? json['SubjectName'] : "";
    maxMarks = json['MaxMarks'] != null ? json['MaxMarks'] : "";
    marksObtain = json['MarksObtain'] != null ? json['MarksObtain'] : "";
    maxObtained = json['MaxObtained'] != null ? json['MaxObtained'] : "";
    avgObtained = json['AvgObtained'] != null ? json['AvgObtained'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Exam'] = this.exam;
    data['SubjectName'] = this.subjectName;
    data['MaxMarks'] = this.maxMarks;
    data['MarksObtain'] = this.marksObtain;
    data['MaxObtained'] = this.maxObtained;
    data['AvgObtained'] = this.avgObtained;
    return data;
  }
}
