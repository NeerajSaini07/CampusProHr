class OtpUserListModel {
  int? userId = -1;
  String? userName = '';
  String? loginId = '';
  String? designation = '';
  String? oTP = '';
  int? isActive = -1;
  bool? showOtp = false;

  OtpUserListModel(
      {this.userId,
      this.userName,
      this.loginId,
      this.designation,
      this.oTP,
      this.isActive,
      this.showOtp});

  OtpUserListModel.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'] ?? -1;
    userName = json['UserName'] ?? "";
    loginId = json['LoginId'] ?? "";
    designation = json['Designation'] ?? "";
    oTP = json['OTP'] ?? "";
    isActive = json['IsActive'] ?? -1;
    showOtp = json['showOtp'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['UserName'] = this.userName;
    data['LoginId'] = this.loginId;
    data['Designation'] = this.designation;
    data['OTP'] = this.oTP;
    data['IsActive'] = this.isActive;
    data['showOtp'] = this.showOtp;
    return data;
  }

  @override
  String toString() {
    return "{userId: $userId, userName: $userName, showOtp: $showOtp}";
  }
}
