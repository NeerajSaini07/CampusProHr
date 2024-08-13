class ClassRoomsStudentModel {
  String? id = '';
  String? forStuEmp = '';
  String? circularId = '';
  String? cirNo = '';
  String? cirSubject = '';
  String? cirContent = '';
  String? forAll = '';
  String? classId = '';
  String? sectionId = '';
  String? streamId = '';
  String? yearId = '';
  String? groupId = '';
  String? isActive = '';
  String? meetingId = '';
  String? circularFileUrl = '';
  String? empId = '';
  String? classroomId = '';
  String? stuEmpType = '';
  String? stuEmpId = '';
  String? subjectName = '';
  String? circularDate1 = '';
  String? subjectHead = '';

  ClassRoomsStudentModel(
      {this.id,
      this.forStuEmp,
      this.circularId,
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
      this.circularFileUrl,
      this.empId,
      this.classroomId,
      this.stuEmpType,
      this.stuEmpId,
      this.subjectName,
      this.circularDate1,
      this.subjectHead});

  ClassRoomsStudentModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'] != null ? json['Id'] : "";
    forStuEmp = json['ForStuEmp'] != null ? json['ForStuEmp'] : "";
    circularId = json['CircularId'] != null ? json['CircularId'] : "";
    cirNo = json['CirNo'] != null ? json['CirNo'] : "";
    cirSubject = json['CirSubject'] != null ? json['CirSubject'] : "";
    cirContent = json['CirContent'] != null ? json['CirContent'] : "";
    forAll = json['ForAll'] != null ? json['ForAll'] : "";
    classId = json['ClassId'] != null ? json['ClassId'] : "";
    sectionId = json['SectionId'] != null ? json['SectionId'] : "";
    streamId = json['StreamId'] != null ? json['StreamId'] : "";
    yearId = json['YearId'] != null ? json['YearId'] : "";
    groupId = json['GroupId'] != null ? json['GroupId'] : "";
    isActive = json['IsActive'] != null ? json['IsActive'] : "";
    meetingId = json['MeetingId'] != null ? json['MeetingId'] : "";
    circularFileUrl =
        json['CircularFileUrl'] != null ? json['CircularFileUrl'] : "";
    empId = json['EmpId'] != null ? json['EmpId'] : "";
    classroomId = json['ClassroomId'] != null ? json['ClassroomId'] : "";
    stuEmpType = json['StuEmpType'] != null ? json['StuEmpType'] : "";
    stuEmpId = json['StuEmpId'] != null ? json['StuEmpId'] : "";
    subjectName = json['SubjectName'] != null ? json['SubjectName'] : "";
    circularDate1 = json['CircularDate1'] != null ? json['CircularDate1'] : "";
    subjectHead = json['SubjectHead'] != null ? json['SubjectHead'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ForStuEmp'] = this.forStuEmp;
    data['CircularId'] = this.circularId;
    data['CirNo'] = this.cirNo;
    data['CirSubject'] = this.cirSubject;
    data['CirContent'] = this.cirContent;
    data['ForAll'] = this.forAll;
    data['ClassId'] = this.classId;
    data['SectionId'] = this.sectionId;
    data['StreamId'] = this.streamId;
    data['YearId'] = this.yearId;
    data['GroupId'] = this.groupId;
    data['IsActive'] = this.isActive;
    data['MeetingId'] = this.meetingId;
    data['CircularFileUrl'] = this.circularFileUrl;
    data['EmpId'] = this.empId;
    data['ClassroomId'] = this.classroomId;
    data['StuEmpType'] = this.stuEmpType;
    data['StuEmpId'] = this.stuEmpId;
    data['SubjectName'] = this.subjectName;
    data['CircularDate1'] = this.circularDate1;
    data['SubjectHead'] = this.subjectHead;
    return data;
  }
}
