import '../../UTILS/appImages.dart';

class UserTypeDummy {
  int? id = 0;
  String? image = "";
  String? name = "";
  String? schoolName = "";
  String? userType = "";

  UserTypeDummy(
      {this.id, this.image, this.name, this.schoolName, this.userType});
}

List<UserTypeDummy> usertypelist = [
  UserTypeDummy(
      id: 12,
      image: AppImages.logo,
      name: "Faizan",
      schoolName: "XYZ School",
      userType: "Employee"),
  UserTypeDummy(
      id: 13,
      image: AppImages.logo,
      name: "Surendra",
      schoolName: "ABCD School",
      userType: "Admin"),
  UserTypeDummy(
      id: 14,
      image: AppImages.logo,
      name: "Prince",
      schoolName: "QWE School",
      userType: "Student"),
  UserTypeDummy(
      id: 15,
      image: AppImages.logo,
      name: "Vicky",
      schoolName: "MNB School",
      userType: "Manager"),
];
