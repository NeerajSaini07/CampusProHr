class UserTypeModel {
  String? buttonConfigString = "";
  String? schoolName = "";
  String? attStartTime = "";
  String? attCloseTime = "";
  String? showFeeReceipt = "";
  String? editAmount = "";
  String? incrementMonthId = "";
  String? currentSessionid = "";
  String? organizationId = "";
  String? schoolId = "";
  String? stuEmpId = "";
  String? stuEmpName = "";
  String? ouserType = "";
  String? headerImgPath = "";
  String? logoImgPath = "";
  String? websiteUrl = "";
  String? bloggerUrl = "";
  String? busId = "";
  String? sendOtpToVisitor = "";
  String? letPayOldFeeMonths = "";
  String? fillFeeAmount = "";
  String? testUrl = "";
  String? isShowMobileNo = "";
  String? empJoinOnPlatformApp = "";
  String? stuJoinOnPlatformApp = "";
  String? baseDomainURL = "";
  String? appUrl = "";
  //
  String? dashboardUrl = "";
  String? dashboardType = "";

  UserTypeModel(
      {this.buttonConfigString,
      this.schoolName,
      this.attStartTime,
      this.attCloseTime,
      this.showFeeReceipt,
      this.editAmount,
      this.incrementMonthId,
      this.currentSessionid,
      this.organizationId,
      this.schoolId,
      this.stuEmpId,
      this.stuEmpName,
      this.ouserType,
      this.headerImgPath,
      this.logoImgPath,
      this.websiteUrl,
      this.bloggerUrl,
      this.busId,
      this.sendOtpToVisitor,
      this.letPayOldFeeMonths,
      this.fillFeeAmount,
      this.testUrl,
      this.isShowMobileNo,
      this.empJoinOnPlatformApp,
      this.stuJoinOnPlatformApp,
      this.baseDomainURL,
      this.appUrl,
      this.dashboardType,
      this.dashboardUrl});

  UserTypeModel.fromJson(Map<String, dynamic> json) {
    buttonConfigString =
        json['ButtonConfigString'] != null ? json['ButtonConfigString'] : "";
    schoolName = json['SchoolName'] != null ? json['SchoolName'] : "";
    attStartTime = json['AttStartTime'] != null ? json['AttStartTime'] : "";
    attCloseTime = json['AttCloseTime'] != null ? json['AttCloseTime'] : "";
    showFeeReceipt =
        json['ShowFeeReceipt'] != null ? json['ShowFeeReceipt'] : "";
    editAmount = json['EditAmount'] != null ? json['EditAmount'] : "";
    incrementMonthId =
        json['IncrementMonthId'] != null ? json['IncrementMonthId'] : "";
    currentSessionid =
        json['CurrentSessionid'] != null ? json['CurrentSessionid'] : "";
    organizationId =
        json['OrganizationId'] != null ? json['OrganizationId'] : "";
    schoolId = json['SchoolId'] != null ? json['SchoolId'] : "";
    stuEmpId = json['StuEmpId'] != null ? json['StuEmpId'] : "";
    stuEmpName = json['StuEmpName'] != null ? json['StuEmpName'] : "";
    ouserType = json['OuserType'] != null ? json['OuserType'] : "";
    headerImgPath = json['HeaderImgPath'] != null ? json['HeaderImgPath'] : "";
    logoImgPath = json['LogoImgPath'] != null ? json['LogoImgPath'] : "";
    websiteUrl = json['WebsiteUrl'] != null ? json['WebsiteUrl'] : "";
    bloggerUrl = json['BloggerUrl'] != null ? json['BloggerUrl'] : "";
    busId = json['BusId'] != null ? json['BusId'] : "";
    sendOtpToVisitor =
        json['SendOtpToVisitor'] != null ? json['SendOtpToVisitor'] : "";
    letPayOldFeeMonths =
        json['LetPayOldFeeMonths'] != null ? json['LetPayOldFeeMonths'] : "";
    fillFeeAmount = json['FillFeeAmount'] != null ? json['FillFeeAmount'] : "";
    testUrl = json['TestUrl'] != null ? json['TestUrl'] : "";
    isShowMobileNo =
        json['IsShowMobileNo'] != null ? json['IsShowMobileNo'] : "";
    empJoinOnPlatformApp = json['EmpJoinOnPlatformApp'] != null
        ? json['EmpJoinOnPlatformApp']
        : "";
    stuJoinOnPlatformApp = json['StuJoinOnPlatformApp'] != null
        ? json['StuJoinOnPlatformApp']
        : "";
    baseDomainURL = json['BaseDomainURL'] != null ? json['BaseDomainURL'] : "";
    appUrl = json['AppUrl'] != null ? json['AppUrl'] : "";
    //
    dashboardType = json["Flag"];
    dashboardUrl = json["Url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ButtonConfigString'] = this.buttonConfigString;
    data['SchoolName'] = this.schoolName;
    data['AttStartTime'] = this.attStartTime;
    data['AttCloseTime'] = this.attCloseTime;
    data['ShowFeeReceipt'] = this.showFeeReceipt;
    data['EditAmount'] = this.editAmount;
    data['IncrementMonthId'] = this.incrementMonthId;
    data['CurrentSessionid'] = this.currentSessionid;
    data['OrganizationId'] = this.organizationId;
    data['SchoolId'] = this.schoolId;
    data['StuEmpId'] = this.stuEmpId;
    data['StuEmpName'] = this.stuEmpName;
    data['OuserType'] = this.ouserType;
    data['HeaderImgPath'] = this.headerImgPath;
    data['LogoImgPath'] = this.logoImgPath;
    data['WebsiteUrl'] = this.websiteUrl;
    data['BloggerUrl'] = this.bloggerUrl;
    data['BusId'] = this.busId;
    data['SendOtpToVisitor'] = this.sendOtpToVisitor;
    data['LetPayOldFeeMonths'] = this.letPayOldFeeMonths;
    data['FillFeeAmount'] = this.fillFeeAmount;
    data['TestUrl'] = this.testUrl;
    data['IsShowMobileNo'] = this.isShowMobileNo;
    data['EmpJoinOnPlatformApp'] = this.empJoinOnPlatformApp;
    data['StuJoinOnPlatformApp'] = this.stuJoinOnPlatformApp;
    data['BaseDomainURL'] = this.baseDomainURL;
    data['AppUrl'] = this.appUrl;
    return data;
  }
}
