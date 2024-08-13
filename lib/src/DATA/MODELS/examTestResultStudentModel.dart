class ExamTestResultStudentModel {
  String? examId = '';
  String? exam = '';
  String? subjectName = '';
  String? isabsent = '';
  String? maxmarks = '';
  String? total = '';
  String? grades = '';
  String? percentage = '';
  String? finalResult = '';

  ExamTestResultStudentModel(
      {this.examId,
      this.exam,
      this.subjectName,
      this.isabsent,
      this.maxmarks,
      this.total,
      this.grades,
      this.percentage,
      this.finalResult});

  ExamTestResultStudentModel.fromJson(Map<String, dynamic> json) {
    examId = json['ExamId'] != null ? json['ExamId'] : "";
    exam = json['Exam'] != null ? json['Exam'] : "";
    subjectName = json['SubjectName'] != null ? json['SubjectName'] : "";
    isabsent = json['isabsent'] != null ? json['isabsent'] : "";
    maxmarks = json['maxmarks'] != null ? json['maxmarks'] : "";
    total = json['total'] != null ? json['total'] : "";
    grades = json['Grades'] != null ? json['Grades'] : "";
    percentage = json['percentage'] != null ? json['percentage'] : "";
    finalResult = json['FinalResult'] != null ? json['FinalResult'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ExamId'] = this.examId;
    data['Exam'] = this.exam;
    data['SubjectName'] = this.subjectName;
    data['isabsent'] = this.isabsent;
    data['maxmarks'] = this.maxmarks;
    data['total'] = this.total;
    data['Grades'] = this.grades;
    data['percentage'] = this.percentage;
    data['FinalResult'] = this.finalResult;
    return data;
  }
}
