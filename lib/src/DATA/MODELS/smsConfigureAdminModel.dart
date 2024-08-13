class SmsConfigureAdminModel {
  String? iD;
  String? username;

  SmsConfigureAdminModel({this.iD, this.username});
}

List<SmsConfigureAdminModel> userListDummy = [
  SmsConfigureAdminModel(iD: "1", username: "Admin"),
  SmsConfigureAdminModel(iD: "2", username: "Employee"),
  SmsConfigureAdminModel(iD: "3", username: "Student"),
  SmsConfigureAdminModel(iD: "4", username: "App Manager"),
];

class SmsTypeModel {
  String? iD;
  bool? isSelected= false;
  String? smsName;

  SmsTypeModel({this.iD, this.isSelected, this.smsName});
}

List<SmsTypeModel> smsListDummy = [
  SmsTypeModel(iD: "1", isSelected: false, smsName: "Admission"),
  SmsTypeModel(iD: "2", isSelected: false, smsName: "Attendance"),
  SmsTypeModel(iD: "3", isSelected: false, smsName: "Birthday"),
  SmsTypeModel(iD: "4", isSelected: false, smsName: "Closing"),
  SmsTypeModel(iD: "5", isSelected: false, smsName: "Admission"),
  SmsTypeModel(iD: "6", isSelected: false, smsName: "Attendance"),
  SmsTypeModel(iD: "7", isSelected: false, smsName: "Birthday"),
  SmsTypeModel(iD: "8", isSelected: false, smsName: "Closing"),
  SmsTypeModel(iD: "9", isSelected: false, smsName: "Admission"),
  SmsTypeModel(iD: "10", isSelected: false, smsName: "Attendance"),
  SmsTypeModel(iD: "11", isSelected: false, smsName: "Birthday"),
  SmsTypeModel(iD: "12", isSelected: false, smsName: "Closing"),
];
