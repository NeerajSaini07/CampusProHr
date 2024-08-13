class ClassListHwStatusAdminModel {
  String? className = "";
  String? draft = "";
  String? sentMessage = "";
  String? homeworkURL = "";

  ClassListHwStatusAdminModel(
      {this.className, this.draft, this.sentMessage, this.homeworkURL});

  ClassListHwStatusAdminModel.fromJson(Map<String, dynamic> json) {
    className = json['ClassName'] != null ? json['ClassName'] : "";
    draft = json['Draft'] != null ? json['Draft'] : "";
    sentMessage = json['SentMessage'] != null ? json['SentMessage'] : "";
    homeworkURL = json['HomeworkURL'] != null ? json['HomeworkURL'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClassName'] = this.className;
    data['Draft'] = this.draft;
    data['SentMessage'] = this.sentMessage;
    data['HomeworkURL'] = this.homeworkURL;
    return data;
  }
}
