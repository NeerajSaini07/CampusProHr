class GetCoordinatorListModel {
  int? stuEmpID = -1;
  String? stuEmpName = "";
  String? mobileNo = "";

  GetCoordinatorListModel({this.stuEmpID, this.stuEmpName, this.mobileNo});

  GetCoordinatorListModel.fromJson(Map<String, dynamic> json) {
    stuEmpID = json['StuEmpID'] != null ? json['StuEmpID'] : "";
    stuEmpName = json['StuEmpName'] != null ? json['StuEmpName'] : "";
    mobileNo = json['mobileNo'] != null ? json['mobileNo'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StuEmpID'] = this.stuEmpID;
    data['StuEmpName'] = this.stuEmpName;
    data['mobileNo'] = this.mobileNo;
    return data;
  }
}
