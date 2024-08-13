class AppUserListModel {
  String? classID = '';
  String? className = '';
  String? displayOrderNo = '';
  String? active = '';
  String? inActive = '';

  AppUserListModel(
      {this.classID,
      this.className,
      this.displayOrderNo,
      this.active,
      this.inActive});

  AppUserListModel.fromJson(Map<String, dynamic> json) {
    classID = json['ClassID'] ?? "";
    className = json['ClassName'] ?? "";
    displayOrderNo = json['DisplayOrderNo'] ?? "";
    active = json['Active'] ?? "";
    inActive = json['InActive'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClassID'] = this.classID;
    data['ClassName'] = this.className;
    data['DisplayOrderNo'] = this.displayOrderNo;
    data['Active'] = this.active;
    data['InActive'] = this.inActive;
    return data;
  }
}
