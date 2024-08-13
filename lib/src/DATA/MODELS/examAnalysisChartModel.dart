class ExamAnalysisChartModel {
  String? combnames = "";
  String? exams = "";
  String? subjects = "";
  String? marks = "";

  ExamAnalysisChartModel(
      {this.combnames, this.exams, this.subjects, this.marks});

  ExamAnalysisChartModel.fromJson(Map<String, dynamic> json) {
    combnames = json['combnames'] != null ? json['combnames'] : "";
    exams = json['exams'] != null ? json['exams'] : "";
    subjects = json['subjects'] != null ? json['subjects'] : "";
    marks = json['Marks'] != null ? json['Marks'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['combnames'] = this.combnames;
    data['exams'] = this.exams;
    data['subjects'] = this.subjects;
    data['Marks'] = this.marks;
    return data;
  }
}
