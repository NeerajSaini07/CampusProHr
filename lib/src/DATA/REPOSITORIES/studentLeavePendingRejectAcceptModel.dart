class studentLeavePendingRejectAcceptModel {
  String? message = "";
  String? status = "";

  studentLeavePendingRejectAcceptModel({this.message, this.status});

  studentLeavePendingRejectAcceptModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    data['Status'] = this.status;
    return data;
  }
}
