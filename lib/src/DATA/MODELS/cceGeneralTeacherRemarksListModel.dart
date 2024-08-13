class CceGeneralTeacherRemarksListModel {
  String? studentId = "";
  String? admNo = "";
  String? stname = "";
  String? remarkID = "";

  CceGeneralTeacherRemarksListModel(
      {this.studentId, this.admNo, this.stname, this.remarkID});

  CceGeneralTeacherRemarksListModel.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'] != null ? json['studentId'] : "";
    admNo = json['AdmNo'] != null ? json['AdmNo'] : "";
    stname = json['Stname'] != null ? json['Stname'] : "";
    remarkID = json['RemarkID'] != null ? json['RemarkID'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentId'] = this.studentId;
    data['AdmNo'] = this.admNo;
    data['Stname'] = this.stname;
    data['RemarkID'] = this.remarkID;
    return data;
  }
}
