class ScheduleMeetingListEmployeeModel {
  int? id;
  String? forStuEmp = '';
  int? isActive;
  int? subjectId;
  String? meetingDate1 = '';
  int? empId;
  String? meetingDuration = '';
  String? meetingTime = '';
  String? meetingSubject = '';
  String? combName = '';
  String? subjectHead = '';
  String? name = '';
  String? meetinglivestatus = '';
  String? filterdate = '';
  String? email = '';
  String? meetingId = '';

  ScheduleMeetingListEmployeeModel(
      {this.id,
      this.forStuEmp,
      this.isActive,
      this.subjectId,
      this.meetingDate1,
      this.empId,
      this.meetingDuration,
      this.meetingTime,
      this.meetingSubject,
      this.combName,
      this.subjectHead,
      this.name,
      this.meetinglivestatus,
      this.filterdate,
      this.email,
      this.meetingId});

  ScheduleMeetingListEmployeeModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'] != null ? json['Id'] : -1;
    forStuEmp = json['ForStuEmp'] != null ? json['ForStuEmp'] : "";
    isActive = json['IsActive'] != null ? json['IsActive'] : -1;
    subjectId = json['SubjectId'] != null ? json['SubjectId'] : -1;
    meetingDate1 = json['MeetingDate1'] != null ? json['MeetingDate1'] : "";
    empId = json['EmpId'] != null ? json['EmpId'] : -1;
    meetingDuration =
        json['MeetingDuration'] != null ? json['MeetingDuration'] : "";
    meetingTime = json['MeetingTime'] != null ? json['MeetingTime'] : "";
    meetingSubject =
        json['MeetingSubject'] != null ? json['MeetingSubject'] : "";
    combName = json['CombName'] != null ? json['CombName'] : "";
    subjectHead = json['SubjectHead'] != null ? json['SubjectHead'] : "";
    name = json['Name'] != null ? json['Name'] : "";
    meetinglivestatus =
        json['meetinglivestatus'] != null ? json['meetinglivestatus'] : "";
    filterdate = json['filterdate'] != null ? json['filterdate'] : "";
    email = json['Email'] != null ? json['Email'] : "";
    meetingId = json['MeetingId'] != null ? json['MeetingId'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ForStuEmp'] = this.forStuEmp;
    data['IsActive'] = this.isActive;
    data['SubjectId'] = this.subjectId;
    data['MeetingDate1'] = this.meetingDate1;
    data['EmpId'] = this.empId;
    data['MeetingDuration'] = this.meetingDuration;
    data['MeetingTime'] = this.meetingTime;
    data['MeetingSubject'] = this.meetingSubject;
    data['CombName'] = this.combName;
    data['SubjectHead'] = this.subjectHead;
    data['Name'] = this.name;
    data['meetinglivestatus'] = this.meetinglivestatus;
    data['filterdate'] = this.filterdate;
    data['Email'] = this.email;
    data['MeetingId'] = this.meetingId;
    return data;
  }
}
