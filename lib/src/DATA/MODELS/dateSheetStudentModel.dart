class DateSheetStudentModel {
  String? classId = "";
  String? streamId = "";
  String? yearId = "";
  String? examId = "";
  String? exam = "";
  String? subjectHead = "";
  String? subjectCode = "";
  String? examDate = "";
  String? shift = "";
  String? timing = "";
  String? syllabus = "";

  DateSheetStudentModel(
      {this.classId,
      this.streamId,
      this.yearId,
      this.examId,
      this.exam,
      this.subjectHead,
      this.subjectCode,
      this.examDate,
      this.shift,
      this.timing,
      this.syllabus});

  DateSheetStudentModel.fromJson(Map<String, dynamic> json) {
    classId = json['ClassId'] != null ? json['ClassId'] : "";
    streamId = json['StreamId'] != null ? json['StreamId'] : "";
    yearId = json['YearId'] != null ? json['YearId'] : "";
    examId = json['ExamId'] != null ? json['ExamId'] : "";
    exam = json['Exam'] != null ? json['Exam'] : "";
    subjectHead = json['SubjectHead'] != null ? json['SubjectHead'] : "";
    subjectCode = json['SubjectCode'] != null ? json['SubjectCode'] : "";
    examDate = json['ExamDate'] != null ? json['ExamDate'] : "";
    shift = json['Shift'] != null ? json['Shift'] : "";
    timing = json['Timing'] != null ? json['Timing'] : "";
    syllabus = json['Syllabus'] != null ? json['Syllabus'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClassId'] = this.classId;
    data['StreamId'] = this.streamId;
    data['YearId'] = this.yearId;
    data['ExamId'] = this.examId;
    data['Exam'] = this.exam;
    data['SubjectHead'] = this.subjectHead;
    data['SubjectCode'] = this.subjectCode;
    data['ExamDate'] = this.examDate;
    data['Shift'] = this.shift;
    data['Timing'] = this.timing;
    data['Syllabus'] = this.syllabus;
    return data;
  }
}
