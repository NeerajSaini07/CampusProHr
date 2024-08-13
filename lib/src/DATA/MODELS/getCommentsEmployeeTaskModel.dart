class GetCommentsEmployeeTaskModel {
  int? iD;
  int? taskID;
  int? userID;
  String? taskName;
  String? comments;
  String? file;
  String? craedtedOn;
  String? statusVal;
  int? status;
  String? empName;

  GetCommentsEmployeeTaskModel(
      {this.iD,
      this.taskID,
      this.userID,
      this.taskName,
      this.comments,
      this.file,
      this.craedtedOn,
      this.statusVal,
      this.status,
      this.empName});

  GetCommentsEmployeeTaskModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    taskID = json['TaskID'];
    userID = json['UserID'];
    taskName = json['TaskName'];
    comments = json['Comments'];
    file = json['File'];
    craedtedOn = json['CraedtedOn'];
    statusVal = json['StatusVal'];
    status = json['Status'];
    empName = json['EmpName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['TaskID'] = this.taskID;
    data['UserID'] = this.userID;
    data['TaskName'] = this.taskName;
    data['Comments'] = this.comments;
    data['File'] = this.file;
    data['CraedtedOn'] = this.craedtedOn;
    data['StatusVal'] = this.statusVal;
    data['Status'] = this.status;
    data['EmpName'] = this.empName;
    return data;
  }
}
