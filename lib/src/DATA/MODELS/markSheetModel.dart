class MarkSheetStudentModel {
  String? tempMarkSheetId = '';
  String? cGPAType = '';
  String? applyWeightage = '';
  String? calcOnlyMains = '';
  String? marksheetType = '';
  String? show = '';
  String? format = '';
  String? exam = '';

  MarkSheetStudentModel(
      {this.tempMarkSheetId,
      this.cGPAType,
      this.applyWeightage,
      this.calcOnlyMains,
      this.marksheetType,
      this.show,
      this.format,
      this.exam});

  MarkSheetStudentModel.fromJson(Map<String, dynamic> json) {
    tempMarkSheetId =
        json['tempMarkSheetId'] != null ? json['tempMarkSheetId'] : "";
    cGPAType = json['CGPAType'] != null ? json['CGPAType'] : "";
    applyWeightage =
        json['ApplyWeightage'] != null ? json['ApplyWeightage'] : "";
    calcOnlyMains = json['CalcOnlyMains'] != null ? json['CalcOnlyMains'] : "";
    marksheetType = json['MarksheetType'] != null ? json['MarksheetType'] : "";
    show = json['Show'] != null ? json['Show'] : "";
    format = json['Format'] != null ? json['Format'] : "";
    exam = json['Exam'] != null ? json['Exam'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tempMarkSheetId'] = this.tempMarkSheetId;
    data['CGPAType'] = this.cGPAType;
    data['ApplyWeightage'] = this.applyWeightage;
    data['CalcOnlyMains'] = this.calcOnlyMains;
    data['MarksheetType'] = this.marksheetType;
    data['Show'] = this.show;
    data['Format'] = this.format;
    data['Exam'] = this.exam;
    return data;
  }
}
