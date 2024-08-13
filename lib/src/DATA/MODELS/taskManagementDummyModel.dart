class TaskManagementDummyModel {
  String? sNo;
  String? taskName;
  String? startDate;
  String? dueDate;
  String? priority;
  String? status;
  String? follower;
  String? assign;
  String? edit;
  String? delete;

  TaskManagementDummyModel(
      {this.sNo,
      this.taskName,
      this.startDate,
      this.dueDate,
      this.priority,
      this.status,
      this.follower,
      this.assign,
      this.edit,
      this.delete});
}

List<TaskManagementDummyModel> taskList = [
  TaskManagementDummyModel(
    sNo: "1",
    taskName: "Unit Test",
    startDate: "21-Dec-2020",
    dueDate: "31-Dec-2020",
    priority: "High",
    status: "Pending",
    follower: "1",
    assign: "2",
    edit: "",
    delete: "",
  ),
  TaskManagementDummyModel(
    sNo: "2",
    taskName: "Class Test",
    startDate: "27-Dec-2020",
    dueDate: "31-Jan-2021",
    priority: "Low",
    status: "Completed",
    follower: "3",
    assign: "5",
    edit: "",
    delete: "",
  ),
  TaskManagementDummyModel(
    sNo: "3",
    taskName: "Examination",
    startDate: "27-Feb-2021",
    dueDate: "02-Mar-2021",
    priority: "High",
    status: "Pending",
    follower: "5",
    assign: "3",
    edit: "",
    delete: "",
  ),
];
