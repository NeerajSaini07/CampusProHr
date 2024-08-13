class TeacherRemarksListModel {
  String? id = '';
  String? remark = '';

  TeacherRemarksListModel({this.id, this.remark});

  TeacherRemarksListModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'] != null ? json['Id'] : "";
    remark = json['Remark'] != null ? json['Remark'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Remark'] = this.remark;
    return data;
  }

  @override
  String toString() {
    return "{id: $id, remark: $remark},";
  }
}
