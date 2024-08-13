class OnlineMeetingsModel {
  String? forStuEmp = "";
  String? circularId = "";
  String? circularDate = "";
  String? cirNo = "";
  String? cirSubject = "";
  String? cirContent = "";
  String? forAll = "";
  String? classId = "";
  String? sectionId = "";
  String? streamId = "";
  String? yearId = "";
  String? groupId = "";
  String? isActive = "";
  String? meetingId = "";
  String? userId = "";
  String? timeStamp = "";
  String? byUserId = "";
  String? circularFileurl = "";
  String? eMPID = "";
  String? classroomid = "";
  String? stuemptype = "";
  String? stuempid = "";
  String? subjectName = "";
  String? circularDate1 = "";
  String? subjecthead = "";
  String? meetingDateTime = "";
  String? meetingLiveStatus = "";

  OnlineMeetingsModel(
      {this.forStuEmp,
      this.circularId,
      this.circularDate,
      this.cirNo,
      this.cirSubject,
      this.cirContent,
      this.forAll,
      this.classId,
      this.sectionId,
      this.streamId,
      this.yearId,
      this.groupId,
      this.isActive,
      this.meetingId,
      this.userId,
      this.timeStamp,
      this.byUserId,
      this.circularFileurl,
      this.eMPID,
      this.classroomid,
      this.stuemptype,
      this.stuempid,
      this.subjectName,
      this.circularDate1,
      this.subjecthead,
      this.meetingDateTime,
      this.meetingLiveStatus});

  OnlineMeetingsModel.fromJson(Map<String, dynamic> json) {
    forStuEmp = json['ForStuEmp'] != null ? json['ForStuEmp'] : "";
    circularId = json['CircularId'] != null ? json['CircularId'] : "";
    circularDate = json['CircularDate'] != null ? json['CircularDate'] : "";
    cirNo = json['CirNo'] != null ? json['CirNo'] : "";
    cirSubject = json['CirSubject'] != null ? json['CirSubject'] : "";
    cirContent = json['CirContent'] != null ? json['CirContent'] : "";
    forAll = json['ForAll'] != null ? json['ForAll'] : "";
    classId = json['ClassId'] != null ? json['ClassId'] : "";
    sectionId = json['SectionId'] != null ? json['SectionId'] : "";
    streamId = json['StreamId'] != null ? json['StreamId'] : "";
    yearId = json['YearId'] != null ? json['YearId'] : "";
    groupId = json['GroupId'] != null ? json['GroupId'] : "";
    isActive = json['isActive'] != null ? json['isActive'] : "";
    meetingId = json['MeetingId'] != null ? json['MeetingId'] : "";
    userId = json['UserId'] != null ? json['UserId'] : "";
    timeStamp = json['TimeStamp'] != null ? json['TimeStamp'] : "";
    byUserId = json['ByUserId'] != null ? json['ByUserId'] : "";
    circularFileurl =
        json['CircularFileurl'] != null ? json['CircularFileurl'] : "";
    eMPID = json['EMPID'] != null ? json['EMPID'] : "";
    classroomid = json['classroomid'] != null ? json['classroomid'] : "";
    stuemptype = json['stuemptype'] != null ? json['stuemptype'] : "";
    stuempid = json['stuempid'] != null ? json['stuempid'] : "";
    subjectName = json['SubjectName'] != null ? json['SubjectName'] : "";
    circularDate1 = json['CircularDate1'] != null ? json['CircularDate1'] : "";
    subjecthead = json['subjecthead'] != null ? json['subjecthead'] : "";
    meetingDateTime =
        json['MeetingDateTime'] != null ? json['MeetingDateTime'] : "";
    meetingLiveStatus =
        json['MeetingLiveStatus'] != null ? json['MeetingLiveStatus'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ForStuEmp'] = this.forStuEmp;
    data['CircularId'] = this.circularId;
    data['CircularDate'] = this.circularDate;
    data['CirNo'] = this.cirNo;
    data['CirSubject'] = this.cirSubject;
    data['CirContent'] = this.cirContent;
    data['ForAll'] = this.forAll;
    data['ClassId'] = this.classId;
    data['SectionId'] = this.sectionId;
    data['StreamId'] = this.streamId;
    data['YearId'] = this.yearId;
    data['GroupId'] = this.groupId;
    data['isActive'] = this.isActive;
    data['MeetingId'] = this.meetingId;
    data['UserId'] = this.userId;
    data['TimeStamp'] = this.timeStamp;
    data['ByUserId'] = this.byUserId;
    data['CircularFileurl'] = this.circularFileurl;
    data['EMPID'] = this.eMPID;
    data['classroomid'] = this.classroomid;
    data['stuemptype'] = this.stuemptype;
    data['stuempid'] = this.stuempid;
    data['SubjectName'] = this.subjectName;
    data['CircularDate1'] = this.circularDate1;
    data['subjecthead'] = this.subjecthead;
    data['MeetingDateTime'] = this.meetingDateTime;
    data['MeetingLiveStatus'] = this.meetingLiveStatus;
    return data;
  }
}
