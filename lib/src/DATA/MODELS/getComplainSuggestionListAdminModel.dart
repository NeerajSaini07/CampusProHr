class GetComplainSuggestionListAdminModel {
  String? cSBy = "";
  String? className = "";
  String? guardianMobileNo = "";
  String? classSection = "";
  String? cSId = "";
  String? cS = "";
  String? cSTopic = "";
  String? cSSubject = "";
  String? cSDetail = "";
  String? tranDate = "";
  String? isActive = "";
  String? adminRemarks = "";
  String? studentId = "";

  GetComplainSuggestionListAdminModel(
      {this.cSBy,
      this.className,
      this.guardianMobileNo,
      this.classSection,
      this.cSId,
      this.cS,
      this.cSTopic,
      this.cSSubject,
      this.cSDetail,
      this.tranDate,
      this.isActive,
      this.adminRemarks,
      this.studentId});

  GetComplainSuggestionListAdminModel.fromJson(Map<String, dynamic> json) {
    cSBy = json['C_SBy'] != null ? json['C_SBy'] : "";
    className = json['ClassName'] != null ? json['ClassName'] : "";
    guardianMobileNo =
        json['GuardianMobileNo'] != null ? json['GuardianMobileNo'] : "";
    classSection = json['ClassSection'] != null ? json['ClassSection'] : "";
    cSId = json['C_SId'] != null ? json['C_SId'] : "";
    cS = json['C_S'] != null ? json['C_S'] : "";
    cSTopic = json['C_sTopic'] != null ? json['C_sTopic'] : "";
    cSSubject = json['C_SSubject'] != null ? json['C_SSubject'] : "";
    cSDetail = json['C_SDetail'] != null ? json['C_SDetail'] : "";
    tranDate = json['TranDate'] != null ? json['TranDate'] : "";
    isActive = json['IsActive'] != null ? json['IsActive'] : "";
    adminRemarks = json['AdminRemarks'] != null ? json['AdminRemarks'] : "";
    studentId = json['StudentId'] != null ? json['StudentId'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['C_SBy'] = this.cSBy;
    data['ClassName'] = this.className;
    data['GuardianMobileNo'] = this.guardianMobileNo;
    data['ClassSection'] = this.classSection;
    data['C_SId'] = this.cSId;
    data['C_S'] = this.cS;
    data['C_sTopic'] = this.cSTopic;
    data['C_SSubject'] = this.cSSubject;
    data['C_SDetail'] = this.cSDetail;
    data['TranDate'] = this.tranDate;
    data['IsActive'] = this.isActive;
    data['AdminRemarks'] = this.adminRemarks;
    data['StudentId'] = this.studentId;
    return data;
  }
}
