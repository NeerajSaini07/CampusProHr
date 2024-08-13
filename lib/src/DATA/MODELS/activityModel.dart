class ActivityModel {
  String? id = "";
  String? dateAdded = "";
  String? title = "";
  String? content = "";
  String? circularFileurl = "";
  String? forStuEmp = "";
  String? byUser = "";

  ActivityModel(
      {this.id,
      this.dateAdded,
      this.title,
      this.content,
      this.circularFileurl,
      this.forStuEmp});

  ActivityModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'] != null ? json['Id'] : "";
    dateAdded = json['DateAdded'] != null ? json['DateAdded'] : "";
    title = json['Title'] != null ? json['Title'] : "";
    content = json['Content'] != null ? json['Content'] : "";
    circularFileurl =
        json['CircularFileurl'] != null ? json['CircularFileurl'] : "";
    forStuEmp = json['ForStuEmp'] != null ? json['ForStuEmp'] : "";
    byUser = json['ByUserId'] != null ? json['ByUserId'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['DateAdded'] = this.dateAdded;
    data['Title'] = this.title;
    data['Content'] = this.content;
    data['CircularFileurl'] = this.circularFileurl;
    data['ForStuEmp'] = this.forStuEmp;
    data['ByUserId'] = this.byUser;
    return data;
  }
}
