class ViewEnquiryModel {
  int? iD = -1;
  String? name = "";
  String? fatherName = "";
  String? motherName = "";
  String? contactNo = "";
  String? emailID = "";
  int? schoolID = -1;
  int? enquiryType = -1;
  String? comments = "";
  int? referenceID = -1;
  int? enquiryFor = -1;
  int? classID = -1;
  String? className = "";
  String? enquiryForVal = "";
  String? registrationID = "";
  String? guardianMobileNo = "";
  int? paymentStatus = -1;
  String? referenceNameVal = "";
  String? statusVal = "";
  String? enqueryTypeVal = "";
  String? enquiryDate = "";
  bool? isSms = false;
  bool? isEmail = false;
  String? enquiryDateFormat = "";
  int? status = -1;
  String? createdDate = "";
  int? createdID = -1;
  String? oldSchoolName = "";
  String? presentAddress = "";
  String? whatsAppNo = "";

  ViewEnquiryModel(
      {this.iD,
      this.name,
      this.fatherName,
      this.motherName,
      this.contactNo,
      this.emailID,
      this.schoolID,
      this.enquiryType,
      this.comments,
      this.referenceID,
      this.enquiryFor,
      this.classID,
      this.className,
      this.enquiryForVal,
      this.registrationID,
      this.guardianMobileNo,
      this.paymentStatus,
      this.referenceNameVal,
      this.statusVal,
      this.enqueryTypeVal,
      this.enquiryDate,
      this.isSms,
      this.isEmail,
      this.enquiryDateFormat,
      this.status,
      this.createdDate,
      this.createdID,
      this.oldSchoolName,
      this.presentAddress,
      this.whatsAppNo});

  ViewEnquiryModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'] != null ? json['ID'] : -1;
    name = json['Name'] != null ? json['Name'] : "";
    fatherName = json['FatherName'] != null ? json['FatherName'] : "";
    motherName = json['MotherName'] != null ? json['MotherName'] : "";
    contactNo = json['ContactNo'] != null ? json['ContactNo'] : "";
    emailID = json['EmailID'] != null ? json['EmailID'] : "";
    schoolID = json['SchoolID'] != null ? json['SchoolID'] : -1;
    enquiryType = json['EnquiryType'] != null ? json['EnquiryType'] : -1;
    comments = json['Comments'] != null ? json['Comments'] : "";
    referenceID = json['ReferenceID'] != null ? json['ReferenceID'] : -1;
    enquiryFor = json['EnquiryFor'] != null ? json['EnquiryFor'] : -1;
    classID = json['ClassID'] != null ? json['ClassID'] : -1;
    className = json['ClassName'] != null ? json['ClassName'] : "";
    enquiryForVal = json['EnquiryForVal'] != null ? json['EnquiryForVal'] : "";
    registrationID =
        json['RegistrationID'] != null ? json['RegistrationID'] : "";
    guardianMobileNo =
        json['GuardianMobileNo'] != null ? json['GuardianMobileNo'] : "";
    paymentStatus = json['PaymentStatus'] != null ? json['PaymentStatus'] : -1;
    referenceNameVal =
        json['ReferenceNameVal'] != null ? json['ReferenceNameVal'] : "";
    statusVal = json['StatusVal'] != null ? json['StatusVal'] : "";
    enqueryTypeVal =
        json['EnqueryTypeVal'] != null ? json['EnqueryTypeVal'] : "";
    enquiryDate = json['EnquiryDate'] != null ? json['EnquiryDate'] : "";
    isSms = json['IsSms'] != null ? json['IsSms'] : false;
    isEmail = json['IsEmail'] != null ? json['IsEmail'] : false;
    enquiryDateFormat =
        json['EnquiryDateFormat'] != null ? json['EnquiryDateFormat'] : "";
    status = json['Status'] != null ? json['Status'] : -1;
    createdDate = json['CreatedDate'] != null ? json['CreatedDate'] : "";
    createdID = json['CreatedID'] != null ? json['CreatedID'] : -1;
    oldSchoolName = json['OldSchoolName'] != null ? json['OldSchoolName'] : "";
    presentAddress =
        json['PresentAddress'] != null ? json['PresentAddress'] : "";
    whatsAppNo = json['WhatsAppNo'] != null ? json['WhatsAppNo'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Name'] = this.name;
    data['FatherName'] = this.fatherName;
    data['MotherName'] = this.motherName;
    data['ContactNo'] = this.contactNo;
    data['EmailID'] = this.emailID;
    data['SchoolID'] = this.schoolID;
    data['EnquiryType'] = this.enquiryType;
    data['Comments'] = this.comments;
    data['ReferenceID'] = this.referenceID;
    data['EnquiryFor'] = this.enquiryFor;
    data['ClassID'] = this.classID;
    data['ClassName'] = this.className;
    data['EnquiryForVal'] = this.enquiryForVal;
    data['RegistrationID'] = this.registrationID;
    data['GuardianMobileNo'] = this.guardianMobileNo;
    data['PaymentStatus'] = this.paymentStatus;
    data['ReferenceNameVal'] = this.referenceNameVal;
    data['StatusVal'] = this.statusVal;
    data['EnqueryTypeVal'] = this.enqueryTypeVal;
    data['EnquiryDate'] = this.enquiryDate;
    data['IsSms'] = this.isSms;
    data['IsEmail'] = this.isEmail;
    data['EnquiryDateFormat'] = this.enquiryDateFormat;
    data['Status'] = this.status;
    data['CreatedDate'] = this.createdDate;
    data['CreatedID'] = this.createdID;
    data['OldSchoolName'] = this.oldSchoolName;
    data['PresentAddress'] = this.presentAddress;
    data['WhatsAppNo'] = this.whatsAppNo;
    return data;
  }

  @override
  String toString() {
    return "fatherName $fatherName, motherName $motherName, emailID $emailID";
  }
}
