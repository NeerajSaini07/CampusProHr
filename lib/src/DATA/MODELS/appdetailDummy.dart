class AppDetailDummy {
  String? classes = "";
  String? employee = "";
  String? active = "";
  String? inActive = "";

  AppDetailDummy({this.classes, this.employee, this.active, this.inActive});
}

List<AppDetailDummy> appUserData = [
  AppDetailDummy(
      classes: "Nur", employee: "Employee", active: "1", inActive: "15"),
  AppDetailDummy(
      classes: "LKG", employee: "Employee", active: "2", inActive: "21"),
  AppDetailDummy(
      classes: "UKG", employee: "Employee", active: "4", inActive: "40"),
];
