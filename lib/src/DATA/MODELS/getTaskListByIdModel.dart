class GetTaskListByIdModel {
  int? iD;
  String? taskName;
  String? taskDetails;
  String? attachFile;
  String? startDate;
  String? dueDate;
  int? countOfUserAssignWork;
  String? assignUserID;
  String? followUPUserID;
  String? priority;
  int? status;
  int? schoolID;
  String? createdOn;
  int? createdBy;

  GetTaskListByIdModel(
      {this.iD,
      this.taskName,
      this.taskDetails,
      this.attachFile,
      this.startDate,
      this.dueDate,
      this.countOfUserAssignWork,
      this.assignUserID,
      this.followUPUserID,
      this.priority,
      this.status,
      this.schoolID,
      this.createdOn,
      this.createdBy});

  GetTaskListByIdModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    taskName = json['TaskName'];
    taskDetails = json['TaskDetails'];
    attachFile = json['AttachFile'] != null ? json['AttachFile'] : "";
    startDate = json['StartDate'];
    dueDate = json['DueDate'];
    countOfUserAssignWork = json['CountOfUserAssignWork'];
    assignUserID = json['AssignUserID'];
    followUPUserID = json['FollowUPUserID'];
    priority = json['Priority'];
    status = json['Status'];
    schoolID = json['SchoolID'];
    createdOn = json['CreatedOn'];
    createdBy = json['CreatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['TaskName'] = this.taskName;
    data['TaskDetails'] = this.taskDetails;
    data['AttachFile'] = this.attachFile;
    data['StartDate'] = this.startDate;
    data['DueDate'] = this.dueDate;
    data['CountOfUserAssignWork'] = this.countOfUserAssignWork;
    data['AssignUserID'] = this.assignUserID;
    data['FollowUPUserID'] = this.followUPUserID;
    data['Priority'] = this.priority;
    data['Status'] = this.status;
    data['SchoolID'] = this.schoolID;
    data['CreatedOn'] = this.createdOn;
    data['CreatedBy'] = this.createdBy;
    return data;
  }
}
