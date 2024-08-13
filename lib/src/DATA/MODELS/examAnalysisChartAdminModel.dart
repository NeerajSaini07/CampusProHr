class ExamAnalysisChartAdminModel {
  String? combnames = '';
  String? exams = '';
  String? subjects = '';
  String? below25 = '';
  String? between25to50 = '';
  String? between50to75 = '';
  String? between75to100 = '';

  ExamAnalysisChartAdminModel(
      {this.combnames,
      this.exams,
      this.subjects,
      this.below25,
      this.between25to50,
      this.between50to75,
      this.between75to100});

  ExamAnalysisChartAdminModel.fromJson(Map<String, dynamic> json) {
    combnames = json['combnames'] ?? "";
    exams = json['exams'] ?? "";
    subjects = json['subjects'] ?? "";
    below25 = json['below25'] ?? "";
    between25to50 = json['between25to50'] ?? "";
    between50to75 = json['between50to75'] ?? "";
    between75to100 = json['between75to100'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['combnames'] = this.combnames;
    data['exams'] = this.exams;
    data['subjects'] = this.subjects;
    data['below25'] = this.below25;
    data['between25to50'] = this.between25to50;
    data['between50to75'] = this.between50to75;
    data['between75to100'] = this.between75to100;
    return data;
  }
}
