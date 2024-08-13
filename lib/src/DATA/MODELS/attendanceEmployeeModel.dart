class AttendanceEmployeeModel {
  String? classIds = "";
  String? classSection = "";
  String? present = "";
  String? absent = "";
  String? leave = "";
  String? classID = "";
  String? streamId = "";
  String? sectionid = "";
  String? yearId = "";
  String? disPlayOrderNo = "";
  String? classId1 = "";
  String? streamId1 = "";
  int? sectionId1 = -1;
  int? yearId1 = -1;

  AttendanceEmployeeModel(
      {this.classIds,
      this.classSection,
      this.present,
      this.absent,
      this.leave,
      this.classID,
      this.streamId,
      this.sectionid,
      this.yearId,
      this.disPlayOrderNo,
      this.classId1,
      this.streamId1,
      this.sectionId1,
      this.yearId1});

  AttendanceEmployeeModel.fromJson(Map<String, dynamic> json) {
    classIds = json['ClassIds'] != null ? json['ClassIds'] : "";
    classSection = json['ClassSection'] != null ? json['ClassSection'] : "";
    present = json['Present'] != null ? json['Present'] : "";
    absent = json['Absent'] != null ? json['Absent'] : "";
    leave = json['Leave'] != null ? json['Leave'] : "";
    classID = json['ClassID'] != null ? json['ClassID'] : "";
    streamId = json['StreamId'] != null ? json['StreamId'] : "";
    sectionid = json['sectionid'] != null ? json['sectionid'] : "";
    yearId = json['YearId'] != null ? json['YearId'] : "";
    disPlayOrderNo =
        json['DisPlayOrderNo'] != null ? json['DisPlayOrderNo'] : "";
    classId1 = json['ClassId1'] != null ? json['ClassId1'] : "";
    streamId1 = json['StreamId1'] != null ? json['StreamId1'] : "";
    sectionId1 = json['SectionId1'] != null ? json['SectionId1'] : -1;
    yearId1 = json['YearId1'] != null ? json['YearId1'] : -1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClassIds'] = this.classIds;
    data['ClassSection'] = this.classSection;
    data['Present'] = this.present;
    data['Absent'] = this.absent;
    data['Leave'] = this.leave;
    data['ClassID'] = this.classID;
    data['StreamId'] = this.streamId;
    data['sectionid'] = this.sectionid;
    data['YearId'] = this.yearId;
    data['DisPlayOrderNo'] = this.disPlayOrderNo;
    data['ClassId1'] = this.classId1;
    data['StreamId1'] = this.streamId1;
    data['SectionId1'] = this.sectionId1;
    data['YearId1'] = this.yearId1;
    return data;
  }
}
