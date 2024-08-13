class GetTaskDataModel {
  int? iD = -1;
  String? taskName = "";
  String? taskDetails = "";
  String? attachFile = "";
  int? assignToCount = -1;
  int? followerCount = -1;
  int? countOfUserAssignWork = -1;
  String? startDate = "";
  String? dueDate = "";
  String? priority = "";
  int? schoolID = -1;
  String? createdOn = "";
  int? createdBy = -1;
  String? status = "";

  GetTaskDataModel(
      {this.iD,
      this.taskName,
      this.taskDetails,
      this.attachFile,
      this.assignToCount,
      this.followerCount,
      this.countOfUserAssignWork,
      this.startDate,
      this.dueDate,
      this.priority,
      this.schoolID,
      this.createdOn,
      this.createdBy,
      this.status});

  GetTaskDataModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'] != null ? json['ID'] : -1;
    taskName = json['TaskName'] != null ? json['TaskName'] : "";
    taskDetails = json['TaskDetails'] != null ? json['TaskDetails'] : "";
    attachFile = json['AttachFile'] != null ? json['AttachFile'] : "";
    assignToCount = json['AssignToCount'] != null ? json['AssignToCount'] : -1;
    followerCount = json['FollowerCount'] != null ? json['FollowerCount'] : -1;
    countOfUserAssignWork = json['CountOfUserAssignWork'] != null
        ? json['CountOfUserAssignWork']
        : -1;
    startDate = json['StartDate'] != null ? json['StartDate'] : "";
    dueDate = json['DueDate'] != null ? json['DueDate'] : "";
    priority = json['Priority'] != null ? json['Priority'] : "";
    schoolID = json['SchoolID'] != null ? json['SchoolID'] : -1;
    createdOn = json['CreatedOn'] != null ? json['CreatedOn'] : "";
    createdBy = json['CreatedBy'] != null ? json['CreatedBy'] : -1;
    status = json['Status'] != null ? json['Status'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['TaskName'] = this.taskName;
    data['TaskDetails'] = this.taskDetails;
    data['AttachFile'] = this.attachFile;
    data['AssignToCount'] = this.assignToCount;
    data['FollowerCount'] = this.followerCount;
    data['CountOfUserAssignWork'] = this.countOfUserAssignWork;
    data['StartDate'] = this.startDate;
    data['DueDate'] = this.dueDate;
    data['Priority'] = this.priority;
    data['SchoolID'] = this.schoolID;
    data['CreatedOn'] = this.createdOn;
    data['CreatedBy'] = this.createdBy;
    data['Status'] = this.status;
    return data;
  }
}
