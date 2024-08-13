class RemarkForStudentListModel {
  String? remarkId = "";
  String? remark = "";

  RemarkForStudentListModel({this.remarkId, this.remark});

  RemarkForStudentListModel.fromJson(Map<String, dynamic> json) {
    remarkId = json['RemarkId'] != null ? json['RemarkId'] : "";
    remark = json['Remark'] != null ? json['Remark'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RemarkId'] = this.remarkId;
    data['Remark'] = this.remark;
    return data;
  }
}
