class CalenderStudentModel {
  String? eventId = '';
  String? eventStartDate = '';
  String? startDate = '';
  String? endDate = '';
  String? eventEndDate = '';
  String? eventDesc = '';
  String? groupid = '';
  String? start = '';
  String? end = '';
  String? title = '';

  CalenderStudentModel(
      {this.eventId,
      this.eventStartDate,
      this.startDate,
      this.endDate,
      this.eventEndDate,
      this.eventDesc,
      this.groupid,
      this.start,
      this.end,
      this.title});

  CalenderStudentModel.fromJson(Map<String, dynamic> json) {
    eventId = json['EventId'] != null ? json['EventId'] : "";
    eventStartDate =
        json['EventStartDate'] != null ? json['EventStartDate'] : "";
    startDate = json['StartDate'] != null ? json['StartDate'] : "";
    endDate = json['EndDate'] != null ? json['EndDate'] : "";
    eventEndDate = json['EventEndDate'] != null ? json['EventEndDate'] : "";
    eventDesc = json['EventDesc'] != null ? json['EventDesc'] : "";
    groupid = json['groupid'] != null ? json['groupid'] : "";
    start = json['start'] != null ? json['start'] : "";
    end = json['end'] != null ? json['end'] : "";
    title = json['title'] != null ? json['title'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EventId'] = this.eventId;
    data['EventStartDate'] = this.eventStartDate;
    data['StartDate'] = this.startDate;
    data['EndDate'] = this.endDate;
    data['EventEndDate'] = this.eventEndDate;
    data['EventDesc'] = this.eventDesc;
    data['groupid'] = this.groupid;
    data['start'] = this.start;
    data['end'] = this.end;
    data['title'] = this.title;
    return data;
  }
}
