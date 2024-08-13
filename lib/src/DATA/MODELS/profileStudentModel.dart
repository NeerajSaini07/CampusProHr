class ProfileStudentModel {
  String? email = '';
  String? studentid = '';
  String? admNo = '';
  String? stName = '';
  String? gender = '';
  String? dOB = '';
  String? fatherName = '';
  String? motherName = '';
  String? mobileNo = '';
  String? guardianMobileNo = '';
  String? category = '';
  String? caste = '';
  String? religion = '';
  String? bloodGroup = '';
  String? prsntAddress = '';
  String? permanentAddress = '';
  String? nationality = '';
  String? pCity = '';
  String? pState = '';
  String? pO = '';
  String? village = '';
  String? presZip = '';
  String? permanentPin = '';
  String? prsntphoneno = '';
  String? className = '';
  String? streamname = '';
  String? year = '';
  String? classSection = '';
  String? motherAadharNo = '';
  String? fatherAadharNo = '';
  String? studentAadharNo = '';
  String? dobNew = '';
  String? studentImage = '';

  ProfileStudentModel(
      {this.email,
      this.studentid,
      this.admNo,
      this.stName,
      this.gender,
      this.dOB,
      this.fatherName,
      this.motherName,
      this.mobileNo,
      this.guardianMobileNo,
      this.category,
      this.caste,
      this.religion,
      this.bloodGroup,
      this.prsntAddress,
      this.permanentAddress,
      this.nationality,
      this.pCity,
      this.pState,
      this.pO,
      this.village,
      this.presZip,
      this.permanentPin,
      this.prsntphoneno,
      this.className,
      this.streamname,
      this.year,
      this.classSection,
      this.motherAadharNo,
      this.fatherAadharNo,
      this.studentAadharNo,
      this.dobNew,
      this.studentImage});

  ProfileStudentModel.fromJson(Map<String, dynamic> json) {
    email = json['Email'] != null ? json['Email'] : "";
    studentid = json['Studentid'] != null ? json['Studentid'] : "";
    admNo = json['AdmNo'] != null ? json['AdmNo'] : "";
    stName = json['StName'] != null ? json['StName'] : "";
    gender = json['Gender'] != null ? json['Gender'] : "";
    dOB = json['DOB'] != null ? json['DOB'] : "";
    fatherName = json['FatherName'] != null ? json['FatherName'] : "";
    motherName = json['MotherName'] != null ? json['MotherName'] : "";
    mobileNo = json['MobileNo'] != null ? json['MobileNo'] : "";
    guardianMobileNo =
        json['GuardianMobileNo'] != null ? json['GuardianMobileNo'] : "";
    category = json['Category'] != null ? json['Category'] : "";
    caste = json['Caste'] != null ? json['Caste'] : "";
    religion = json['Religion'] != null ? json['Religion'] : "";
    bloodGroup = json['BloodGroup'] != null ? json['BloodGroup'] : "";
    prsntAddress = json['PrsntAddress'] != null ? json['PrsntAddress'] : "";
    permanentAddress =
        json['PermanentAddress'] != null ? json['PermanentAddress'] : "";
    nationality = json['nationality'] != null ? json['nationality'] : "";
    pCity = json['pCity'] != null ? json['pCity'] : "";
    pState = json['pState'] != null ? json['pState'] : "";
    pO = json['PO'] != null ? json['PO'] : "";
    village = json['Village'] != null ? json['Village'] : "";
    presZip = json['PresZip'] != null ? json['PresZip'] : "";
    permanentPin = json['PermanentPin'] != null ? json['PermanentPin'] : "";
    prsntphoneno = json['prsntphoneno'] != null ? json['prsntphoneno'] : "";
    className = json['ClassName'] != null ? json['ClassName'] : "";
    streamname = json['streamname'] != null ? json['streamname'] : "";
    year = json['year'] != null ? json['year'] : "";
    classSection = json['ClassSection'] != null ? json['ClassSection'] : "";
    motherAadharNo =
        json['MotherAadharNo'] != null ? json['MotherAadharNo'] : "";
    fatherAadharNo =
        json['FatherAadharNo'] != null ? json['FatherAadharNo'] : "";
    studentAadharNo =
        json['StudentAadharNo'] != null ? json['StudentAadharNo'] : "";
    dobNew = json['DobNew'] != null ? json['DobNew'] : "";
    studentImage = json['StudentImage'] != null ? json['StudentImage'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Email'] = this.email;
    data['Studentid'] = this.studentid;
    data['AdmNo'] = this.admNo;
    data['StName'] = this.stName;
    data['Gender'] = this.gender;
    data['DOB'] = this.dOB;
    data['FatherName'] = this.fatherName;
    data['MotherName'] = this.motherName;
    data['MobileNo'] = this.mobileNo;
    data['GuardianMobileNo'] = this.guardianMobileNo;
    data['Category'] = this.category;
    data['Caste'] = this.caste;
    data['Religion'] = this.religion;
    data['BloodGroup'] = this.bloodGroup;
    data['PrsntAddress'] = this.prsntAddress;
    data['PermanentAddress'] = this.permanentAddress;
    data['nationality'] = this.nationality;
    data['pCity'] = this.pCity;
    data['pState'] = this.pState;
    data['PO'] = this.pO;
    data['Village'] = this.village;
    data['PresZip'] = this.presZip;
    data['PermanentPin'] = this.permanentPin;
    data['prsntphoneno'] = this.prsntphoneno;
    data['ClassName'] = this.className;
    data['streamname'] = this.streamname;
    data['year'] = this.year;
    data['ClassSection'] = this.classSection;
    data['MotherAadharNo'] = this.motherAadharNo;
    data['FatherAadharNo'] = this.fatherAadharNo;
    data['StudentAadharNo'] = this.studentAadharNo;
    data['DobNew'] = this.dobNew;
    data['StudentImage'] = this.studentImage;
    return data;
  }
}
