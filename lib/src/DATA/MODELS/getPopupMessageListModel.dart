class GetPopupMessageListModel {
  String? message = "";
  int? messageId = -1;
  String? groupName = "";
  String? tillDate = "";

  GetPopupMessageListModel(
      {this.message, this.messageId, this.groupName, this.tillDate});

  GetPopupMessageListModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null ? json['Message'] : "";
    messageId = json['MessageId'] != null ? json['MessageId'] : "";
    groupName = json['GroupName'] != null ? json['GroupName'] : "";
    tillDate = json['TillDate'] != null ? json['TillDate'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    data['MessageId'] = this.messageId;
    data['GroupName'] = this.groupName;
    data['TillDate'] = this.tillDate;
    return data;
  }
}
