class EmployeeCalendarAllDateModal {
  String? id;
  String? date;
  String? type;
  String? duration;

  EmployeeCalendarAllDateModal({this.id, this.date, this.duration, this.type});

  EmployeeCalendarAllDateModal.fromJson(Map<String, dynamic> json) {
    this.date = json["date"] != null ? json["date"] : "";
    this.id = json["id"] != null ? json["id"].toString() : "";
    this.duration = json["Duration"] != null ? json["Duration"] : "";
    this.type = json["Type"] != null ? json["Type"] : "";
  }
}
