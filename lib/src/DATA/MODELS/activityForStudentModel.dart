class ActivityForStudentModel {
  String? id = "";
  String? title = "";
  String? dateAdded = "";
  String? htmlContent = "";
  String? circularFileUrl = "";

  ActivityForStudentModel(this.id, this.dateAdded, this.title,
      this.circularFileUrl, this.htmlContent);

  ActivityForStudentModel.fromJson(Map<String, dynamic> json) {
    this.id = json['Id'] != null ? json['Id'] : "";
    this.title = json['Title'] != null ? json['Title'] : "";
    this.dateAdded = json['DateAdded'] != null ? json['DateAdded'] : "";
    this.htmlContent = json['HtmlContent'] != null ? json['HtmlContent'] : "";
    this.circularFileUrl =
        json['CircularFileUrl'] != null ? json['CircularFileUrl'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['Id'] = this.id;
    data['Title'] = this.title;
    data['DateAdded'] = this.dateAdded;
    data['HtmlContent'] = this.htmlContent;
    data['CircularFileUrl'] = this.circularFileUrl;
    return data;
  }
}
