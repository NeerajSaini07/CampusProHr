class CceSubjectTeacherRemarksListModel {
  int? iD = -1;
  String? admNo = '';
  String? name = '';
  bool? expanded = false;
  List<Remarks>? remarks = [];

  CceSubjectTeacherRemarksListModel(
      {this.iD, this.admNo, this.name, this.expanded, this.remarks});

  CceSubjectTeacherRemarksListModel.fromJson(Map<String, dynamic> json) {
    iD = json['iD'] != null ? json['iD'] : "";
    admNo = json['admNo'] != null ? json['admNo'] : "";
    name = json['name'] != null ? json['name'] : "";
    expanded = json['expanded'] != null ? json['expanded'] : false;
    if (json['remarks'] != null) {
      remarks = <Remarks>[];
      json['remarks'].forEach((v) {
        remarks!.add(new Remarks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admNo'] = this.admNo;
    data['name'] = this.name;
    if (this.remarks != null) {
      data['remarks'] = this.remarks!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return "{iD: $iD, admNo: $admNo, name: $name, expanded: $expanded, remarks: $remarks}, ";
  }
}

class Remarks {
  String? subject = '';
  String? remark = '';

  Remarks({this.subject, this.remark});

  Remarks.fromJson(Map<String, dynamic> json) {
    subject = json['subject'] != null ? json['subject'] : "";
    remark = json['remark'] != null ? json['remark'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject'] = this.subject;
    data['remark'] = this.remark;
    return data;
  }

  @override
  String toString() {
    return "{subject: $subject, remark: $remark}, ";
  }
}
