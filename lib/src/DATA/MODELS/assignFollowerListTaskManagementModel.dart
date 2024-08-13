class AssignFollowerListTaskManagementModel {
  int? iD;
  int? taskID;
  int? userID;
  String? comments;
  String? attachFile;
  int? totalComnt;
  String? statusVal;
  String? taskName;
  String? empName;
  String? lastUpdated;
  int? taskStatus;

  AssignFollowerListTaskManagementModel(
      {this.iD,
      this.taskID,
      this.userID,
      this.comments,
      this.attachFile,
      this.totalComnt,
      this.statusVal,
      this.taskName,
      this.empName,
      this.lastUpdated,
      this.taskStatus});

  AssignFollowerListTaskManagementModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    taskID = json['TaskID'];
    userID = json['UserID'];
    comments = json['Comments'];
    attachFile = json['AttachFile'];
    totalComnt = json['TotalComnt'];
    statusVal = json['StatusVal'];
    taskName = json['TaskName'];
    empName = json['EmpName'];
    lastUpdated = json['LastUpdated'];
    taskStatus = json['TaskStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['TaskID'] = this.taskID;
    data['UserID'] = this.userID;
    data['Comments'] = this.comments;
    data['AttachFile'] = this.attachFile;
    data['TotalComnt'] = this.totalComnt;
    data['StatusVal'] = this.statusVal;
    data['TaskName'] = this.taskName;
    data['EmpName'] = this.empName;
    data['LastUpdated'] = this.lastUpdated;
    data['TaskStatus'] = this.taskStatus;
    return data;
  }
}
