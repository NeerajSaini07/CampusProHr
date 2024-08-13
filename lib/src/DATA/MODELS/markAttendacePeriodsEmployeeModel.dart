class MarkAttendacePeriodsEmployeeModel {
  String? periodid = "";
  String? periodname = "";
  String? durationmin = "";
  String? periodtype = "";
  String? subjectid = "";

  MarkAttendacePeriodsEmployeeModel(
      {this.periodid, this.periodname, this.durationmin, this.periodtype});

  MarkAttendacePeriodsEmployeeModel.fromJson(Map<String, dynamic> json) {
    periodid = json['PeriodID'] != null ? json['PeriodID'].toString() : "";
    periodname =
        json['PeriodName'] != null ? json['PeriodName'].toString() : "";
    durationmin =
        json['DurationMin'] != null ? json['DurationMin'].toString() : "";
    periodtype =
        json['PeriodType'] != null ? json['PeriodType'].toString() : "";
    subjectid = json["SubjectId"] != null ? json["SubjectId"].toString() : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['periodid'] = this.periodid;
    data['periodname'] = this.periodname;
    data['durationmin'] = this.durationmin;
    data['periodtype'] = this.periodtype;
    data["subjectid"] = this.subjectid;
    return data;
  }
}
