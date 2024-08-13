class UserSchoolDetailModel {
  String? logoImgPath;
  String? schoolName;

  UserSchoolDetailModel({this.logoImgPath, this.schoolName});

  UserSchoolDetailModel.fromJson(Map<String, dynamic> json) {
    logoImgPath = json['LogoImgPath'] != null ? json['LogoImgPath'] : "";
    schoolName = json['SchoolName'] != null ? json['SchoolName'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LogoImgPath'] = this.logoImgPath;
    data['SchoolName'] = this.schoolName;
    return data;
  }
}
