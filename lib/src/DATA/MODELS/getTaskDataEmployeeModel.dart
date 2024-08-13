class GetTaskDataEmployeeModel {
  int? iD;
  String? taskName;
  String? taskDetails;
  String? attachFile;
  String? startDate;
  String? dueDate;
  String? priority;
  bool? isActive;
  int? schoolID;
  String? action;
  String? userCurrentStatus;
  String? status;

  GetTaskDataEmployeeModel(
      {this.iD,
      this.taskName,
      this.taskDetails,
      this.attachFile,
      this.startDate,
      this.dueDate,
      this.priority,
      this.isActive,
      this.schoolID,
      this.action,
      this.userCurrentStatus,
      this.status});

  GetTaskDataEmployeeModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    taskName = json['TaskName'];
    taskDetails = json['TaskDetails'];
    attachFile = json['AttachFile'];
    startDate = json['StartDate'];
    dueDate = json['DueDate'];
    priority = json['Priority'];
    isActive = json['IsActive'];
    schoolID = json['SchoolID'];
    action = json['Action'];
    userCurrentStatus = json['UserCurrentStatus'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['TaskName'] = this.taskName;
    data['TaskDetails'] = this.taskDetails;
    data['AttachFile'] = this.attachFile;
    data['StartDate'] = this.startDate;
    data['DueDate'] = this.dueDate;
    data['Priority'] = this.priority;
    data['IsActive'] = this.isActive;
    data['SchoolID'] = this.schoolID;
    data['Action'] = this.action;
    data['UserCurrentStatus'] = this.userCurrentStatus;
    data['Status'] = this.status;
    return data;
  }
}
