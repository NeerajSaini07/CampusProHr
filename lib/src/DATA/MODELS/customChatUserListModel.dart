class CustomChatUserListModel {
  String? eMPID = '';
  String? name = '';
  String? gender = '';
  String? mobileNo = '';

  CustomChatUserListModel({this.eMPID, this.name, this.gender, this.mobileNo});

  CustomChatUserListModel.fromJson(Map<String, dynamic> json) {
    eMPID = json['EMPID'] != null ? json['EMPID'] : "";
    name = json['Name'] != null ? json['Name'] : "";
    gender = json['Gender'] != null ? json['Gender'] : "";
    mobileNo = json['MobileNo'] != null ? json['MobileNO'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EMPID'] = this.eMPID;
    data['Name'] = this.name;
    data['Gender'] = this.gender;
    data['MobileNo'] = this.mobileNo;
    return data;
  }
}
