import 'package:campus_pro/src/UTILS/appImages.dart';

class CategoryDummyModel {
  int? id;
  String? image;
  String? title;

  CategoryDummyModel({this.id, this.image, this.title});
}

/// Student Dashboard

List<CategoryDummyModel> studentCategoryListAcademics = [
  // CategoryDummyModel(id: 4, image: AppImages.feePaymentImage, title: "Fees"),
  CategoryDummyModel(
      id: 13, image: AppImages.attendanceIcon, title: "Attendance"),
  // CategoryDummyModel(
  //     id: 54, image: AppImages.attendanceIcon, title: "Attendance"),
  CategoryDummyModel(id: 1, image: AppImages.homeworkImage, title: "Homework"),
  CategoryDummyModel(
      id: 2, image: AppImages.classroomImage, title: "Classroom"),
  CategoryDummyModel(
      id: 6, image: AppImages.onlineTestImage, title: "Examination"),
];

List<CategoryDummyModel> studentCategoryListCircular = [
  CategoryDummyModel(id: 4, image: AppImages.feePaymentImage, title: "Fees"),
  CategoryDummyModel(
      id: 3, image: AppImages.notifyImage, title: "Notifications"),
  CategoryDummyModel(
      id: 3, image: "assets/drawer/circular.png", title: "Circular"),
  CategoryDummyModel(
      id: 80, image: "assets/drawer/sub-activity.png", title: "Activity"),
];

List<CategoryDummyModel> studentCategoryListOthers = [
  CategoryDummyModel(
      id: 7, image: "assets/drawer/calendar.png", title: "Calendar"),
  CategoryDummyModel(
      id: 43,
      image: "assets/drawer/studentBusLocation.png",
      title: "Student Bus Location"),
  CategoryDummyModel(
      id: 30, image: "assets/drawer/feedback.png", title: "Feedback"),
];

///

/// employee dashboard

List<CategoryDummyModel> employeeCategoryListAcademics = [
  CategoryDummyModel(
      id: 8, image: AppImages.classroomImage, title: "Classroom"),
  CategoryDummyModel(id: 11, image: AppImages.homeworkImage, title: "Homework"),
  // CategoryDummyModel(
  //     id: 35, image: AppImages.stuSearchImage, title: "Student Remark"),
  // CategoryDummyModel(
  //     id: 75, image: AppImages.weekPlanImage, title: "Week Plan"),
  CategoryDummyModel(
      id: 14, image: AppImages.markAttendanceImage, title: "Mark Attendance"),
  CategoryDummyModel(
      id: 12, image: AppImages.examMarkEntry, title: "Exam Marks"),
  CategoryDummyModel(
      id: 17,
      image: "assets/drawer/sub-studentLeave.png",
      title: "Student Leave"),
];

List<CategoryDummyModel> employeeCategoryListCirculars = [
  CategoryDummyModel(
      id: 10, image: "assets/drawer/sub-circular.png", title: "Circular"),
  CategoryDummyModel(
      id: 25,
      image: "assets/drawer/sub-notification.png",
      title: "Notification"),
  CategoryDummyModel(
      id: 5, image: "assets/drawer/sub-activity.png", title: "Activity"),
  CategoryDummyModel(
      id: 35,
      image: "assets/drawer/sub-studentRemark.png",
      title: "Student Remark"),
];

List<CategoryDummyModel> employeeCategoryListOthers = [
  CategoryDummyModel(
      id: 75, image: AppImages.weekPlanImage, title: "Week Plan"),
  CategoryDummyModel(
      id: 54,
      image: "assets/drawer/changePassword.png",
      title: "Change Password"),
  CategoryDummyModel(
      id: 16,
      image: "assets/drawer/sub_leaveemployee.png",
      title: "Employee Leave"),
];

///

/// coordinator

List<CategoryDummyModel> cordinatorCategoryListAcademics = [
  CategoryDummyModel(
      id: 29, image: AppImages.homeworkImage, title: "Homework Status"),
  CategoryDummyModel(
      id: 38, image: AppImages.teacherIcon, title: "Teacher Assign"),
  CategoryDummyModel(
      id: 20, image: AppImages.attendanceIcon, title: "Attendance"),
  CategoryDummyModel(
      id: 48, image: AppImages.meetingStatusImage, title: "Meeting Status"),
];

List<CategoryDummyModel> cordinatorCategoryListCirculars = [
  CategoryDummyModel(id: 28, image: AppImages.circularIcon, title: "Circular"),
  CategoryDummyModel(
      id: 25, image: AppImages.notifyImage, title: "Notification"),
  CategoryDummyModel(id: 27, image: AppImages.activityIcon, title: "Activity"),
];

///

/// app manager dashboard

List<CategoryDummyModel> managerCategoryListAcademics = [
  CategoryDummyModel(
      id: 29, image: AppImages.homeworkImage, title: "Homework Status"),
  CategoryDummyModel(
      id: 38, image: AppImages.teacherIcon, title: "Teacher Assign"),
  CategoryDummyModel(
      id: 70, image: AppImages.suggestionImage, title: "Suggestion"),
  CategoryDummyModel(
      id: 20, image: AppImages.attendanceImage, title: "Attendance"),
  CategoryDummyModel(
      id: 48, image: AppImages.meetingStatusImage, title: "Meeting Status"),
];

List<CategoryDummyModel> managerCategoryListCirculars = [
  CategoryDummyModel(id: 10, image: AppImages.circularIcon, title: "Circular"),
  CategoryDummyModel(
      id: 25, image: AppImages.notifyImage, title: "Notification"),
  CategoryDummyModel(
      id: 64, image: AppImages.popUpConfigIcon, title: "PopUp Config"),
  CategoryDummyModel(id: 27, image: AppImages.activityIcon, title: "Activity"),
];

///

/// Admin dashboard

List<CategoryDummyModel> adminCategoryListCircular = [
  // CategoryDummyModel(
  //     id: 39, image: AppImages.admissionStatusImage, title: "Admission Status"),
  // CategoryDummyModel(
  //     id: 47, image: AppImages.dayClosingImage, title: "Day Closing"),
  CategoryDummyModel(id: 25, image: AppImages.bellIcon, title: "Notification"),

  CategoryDummyModel(
      id: 70, image: AppImages.suggestionImage, title: "Suggestions"),
  // CategoryDummyModel(
  //     id: 68, image: AppImages.enquiryManagementImage, title: "Enquiry"),
  CategoryDummyModel(
      id: 34, image: AppImages.studentDetailImage, title: "Student Detail"),
  // CategoryDummyModel(
  //     id: 24, image: AppImages.resultAnnounceImage, title: "Results"),
  CategoryDummyModel(
      id: 48, image: AppImages.meetingStatusImage, title: "Meeting Status"),
];

List<CategoryDummyModel> adminCategoryListAcademics = [
  CategoryDummyModel(
      id: 39, image: AppImages.admissionStatusImage, title: "Admission Status"),
  CategoryDummyModel(
      id: 47, image: AppImages.dayClosingImage, title: "Day Closing"),
  CategoryDummyModel(
      id: 68, image: AppImages.enquiryManagementImage, title: "Enquiry"),
  CategoryDummyModel(
      id: 24, image: AppImages.resultAnnounceImage, title: "Results"),
];

///

List<CategoryDummyModel> schoolBusGridList = [
  CategoryDummyModel(
      id: 0, image: AppImages.busLocationImage, title: "Live Tracking"),
  CategoryDummyModel(id: 1, image: AppImages.busStopsImage, title: "Bus Stops"),
  CategoryDummyModel(
      id: 2, image: AppImages.busDetailsImage, title: "Bus Details"),
  CategoryDummyModel(
      id: 3, image: AppImages.busHistoryImage, title: "Bus History"),
];
