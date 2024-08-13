class CceAttendanceClassDataModel {
  String? studentId = "";
  String? admNo = "";
  String? stName = "";
  String? rollNo = "";
  String? examRollNo = "";
  String? totalDays = "";
  String? attendance = "";
  String? cceAttendance = "";

  CceAttendanceClassDataModel(
      this.studentId,
      this.rollNo,
      this.admNo,
      this.stName,
      this.examRollNo,
      this.attendance,
      this.totalDays,
      this.cceAttendance);

  CceAttendanceClassDataModel.fromJson(Map<String, dynamic> json) {
    studentId = json['studentid'];
    admNo = json['admno'];
    stName = json['stname'];
    rollNo = json['rollno'];
    examRollNo = json['examrollno'];
    totalDays = json['totaldays'];
    attendance = json['attendance'];
    cceAttendance = json["cceattendance"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, String>();

    data['studentid'] = studentId;
    data['admno'] = admNo;
    data['stname'] = stName;
    data['rollno'] = rollNo;
    data['examrollno'] = examRollNo;
    data['totaldays'] = totalDays;
    data['attendance'] = attendance;
    return data;
  }
}
