class DashboardEnquiryModel {
  Data? data;

  DashboardEnquiryModel({this.data});

  DashboardEnquiryModel.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<GetDashBoardDeatils>? getDashBoardDeatils = [];
  List<WeekChartData>? weekChartData = [];
  List<MonthlyChartData>? monthlyChartData = [];
  List<HowPeopleReachus>? howPeopleReachus = [];
  List<GetTop5Enquiry>? getTop5Enquiry = [];
  List<TodayFollowUp>? todayFollowUp = [];

  Data(
      {this.getDashBoardDeatils,
      this.weekChartData,
      this.monthlyChartData,
      this.howPeopleReachus,
      this.getTop5Enquiry,
      this.todayFollowUp});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['GetDashBoardDeatils'] != null) {
      getDashBoardDeatils = <GetDashBoardDeatils>[];
      json['GetDashBoardDeatils'].forEach((v) {
        getDashBoardDeatils!.add(new GetDashBoardDeatils.fromJson(v));
      });
    }
    if (json['WeekChartData'] != null) {
      weekChartData = <WeekChartData>[];
      json['WeekChartData'].forEach((v) {
        weekChartData!.add(new WeekChartData.fromJson(v));
      });
    }
    if (json['MonthlyChartData'] != null) {
      monthlyChartData = <MonthlyChartData>[];
      json['MonthlyChartData'].forEach((v) {
        monthlyChartData!.add(new MonthlyChartData.fromJson(v));
      });
    }
    if (json['HowPeopleReachus'] != null) {
      howPeopleReachus = <HowPeopleReachus>[];
      json['HowPeopleReachus'].forEach((v) {
        howPeopleReachus!.add(new HowPeopleReachus.fromJson(v));
      });
    }
    if (json['GetTop5Enquiry'] != null) {
      getTop5Enquiry = <GetTop5Enquiry>[];
      json['GetTop5Enquiry'].forEach((v) {
        getTop5Enquiry!.add(new GetTop5Enquiry.fromJson(v));
      });
    }
    if (json['TodayFollowUp'] != null) {
      todayFollowUp = <TodayFollowUp>[];
      json['TodayFollowUp'].forEach((v) {
        todayFollowUp!.add(new TodayFollowUp.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getDashBoardDeatils != null) {
      data['GetDashBoardDeatils'] =
          this.getDashBoardDeatils!.map((v) => v.toJson()).toList();
    }
    if (this.weekChartData != null) {
      data['WeekChartData'] =
          this.weekChartData!.map((v) => v.toJson()).toList();
    }
    if (this.monthlyChartData != null) {
      data['MonthlyChartData'] =
          this.monthlyChartData!.map((v) => v.toJson()).toList();
    }
    if (this.howPeopleReachus != null) {
      data['HowPeopleReachus'] =
          this.howPeopleReachus!.map((v) => v.toJson()).toList();
    }
    if (this.getTop5Enquiry != null) {
      data['GetTop5Enquiry'] =
          this.getTop5Enquiry!.map((v) => v.toJson()).toList();
    }
    if (this.todayFollowUp != null) {
      data['TodayFollowUp'] =
          this.todayFollowUp!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetDashBoardDeatils {
  String? chart1Data = '';
  double? totalFollowUp = 0;
  double? toatlFollowUpCount = 0;
  double? closed = 0;
  double? closeCount = 0;
  double? converted = 0;
  double? convertedCount = 0;
  double? registered = 0;
  double? registeredCount = 0;
  int? totalEnquiry = 0;

  GetDashBoardDeatils(
      {this.chart1Data,
      this.totalFollowUp,
      this.toatlFollowUpCount,
      this.closed,
      this.closeCount,
      this.converted,
      this.convertedCount,
      this.registered,
      this.registeredCount,
      this.totalEnquiry});

  GetDashBoardDeatils.fromJson(Map<String, dynamic> json) {
    chart1Data = json['Chart1Data'];
    totalFollowUp = json['TotalFollowUp'];
    toatlFollowUpCount = json['ToatlFollowUpCount'];
    closed = json['Closed'];
    closeCount = json['CloseCount'];
    converted = json['Converted'];
    convertedCount = json['ConvertedCount'];
    registered = json['Registered'];
    registeredCount = json['RegisteredCount'];
    totalEnquiry = json['TotalEnquiry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Chart1Data'] = this.chart1Data;
    data['TotalFollowUp'] = this.totalFollowUp;
    data['ToatlFollowUpCount'] = this.toatlFollowUpCount;
    data['Closed'] = this.closed;
    data['CloseCount'] = this.closeCount;
    data['Converted'] = this.converted;
    data['ConvertedCount'] = this.convertedCount;
    data['Registered'] = this.registered;
    data['RegisteredCount'] = this.registeredCount;
    data['TotalEnquiry'] = this.totalEnquiry;
    return data;
  }
}

class WeekChartData {
  String? dayName = '';
  String? phoneCount = '';
  String? totalEnquiry = '';
  String? visitorsCount = '';
  String? emailCount = '';
  String? onlineCount = '';

  WeekChartData(
      {this.dayName,
      this.phoneCount,
      this.totalEnquiry,
      this.visitorsCount,
      this.emailCount,
      this.onlineCount});

  WeekChartData.fromJson(Map<String, dynamic> json) {
    dayName = json['DayName'];
    phoneCount = json['PhoneCount'];
    totalEnquiry = json['TotalEnquiry'];
    visitorsCount = json['VisitorsCount'];
    emailCount = json['EmailCount'];
    onlineCount = json['OnlineCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DayName'] = this.dayName;
    data['PhoneCount'] = this.phoneCount;
    data['TotalEnquiry'] = this.totalEnquiry;
    data['VisitorsCount'] = this.visitorsCount;
    data['EmailCount'] = this.emailCount;
    data['OnlineCount'] = this.onlineCount;
    return data;
  }
}

class MonthlyChartData {
  String? monthName = '';
  String? monthPhoneCount = '';
  String? monthTotalEnquiry = '';
  String? monthVisitorsCount = '';
  String? monthEmailCount = '';
  String? totalOnlineCount = '';

  MonthlyChartData(
      {this.monthName,
      this.monthPhoneCount,
      this.monthTotalEnquiry,
      this.monthVisitorsCount,
      this.monthEmailCount,
      this.totalOnlineCount});

  MonthlyChartData.fromJson(Map<String, dynamic> json) {
    monthName = json['MonthName'];
    monthPhoneCount = json['MonthPhoneCount'];
    monthTotalEnquiry = json['MonthTotalEnquiry'];
    monthVisitorsCount = json['MonthVisitorsCount'];
    monthEmailCount = json['MonthEmailCount'];
    totalOnlineCount = json['TotalOnlineCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MonthName'] = this.monthName;
    data['MonthPhoneCount'] = this.monthPhoneCount;
    data['MonthTotalEnquiry'] = this.monthTotalEnquiry;
    data['MonthVisitorsCount'] = this.monthVisitorsCount;
    data['MonthEmailCount'] = this.monthEmailCount;
    data['TotalOnlineCount'] = this.totalOnlineCount;
    return data;
  }
}

class HowPeopleReachus {
  int? iD = 0;
  String? referenceName = '';
  bool? isActive = false;
  double? totalSrch = 0;
  int? totalSrchCount = 0;
  int? totalEnquiry = 0;

  HowPeopleReachus(
      {this.iD,
      this.referenceName,
      this.isActive,
      this.totalSrch,
      this.totalSrchCount,
      this.totalEnquiry});

  HowPeopleReachus.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    referenceName = json['ReferenceName'];
    isActive = json['IsActive'];
    totalSrch = json['TotalSrch'];
    totalSrchCount = json['TotalSrchCount'];
    totalEnquiry = json['TotalEnquiry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ReferenceName'] = this.referenceName;
    data['IsActive'] = this.isActive;
    data['TotalSrch'] = this.totalSrch;
    data['TotalSrchCount'] = this.totalSrchCount;
    data['TotalEnquiry'] = this.totalEnquiry;
    return data;
  }
}

class GetTop5Enquiry {
  int? iD = 0;
  String? name = '';
  String? fatherName = '';
  String? motherName = '';
  String? contactNo = '';
  String? emailID = '';
  int? enquiryType = 0;
  String? comments = '';
  int? referenceID = 0;
  int? enquiryFor = 0;
  int? classID = 0;
  String? enquiryForVal = '';
  String? referenceNameVal = '';
  String? statusVal = '';
  String? enquiryDate = '';
  bool? isSms = false;
  bool? isEmail = false;
  String? enquiryDateFormat = '';
  int? status = 0;
  String? createdDate = '';
  int? createdID = 0;

  GetTop5Enquiry(
      {this.iD,
      this.name,
      this.fatherName,
      this.motherName,
      this.contactNo,
      this.emailID,
      this.enquiryType,
      this.comments,
      this.referenceID,
      this.enquiryFor,
      this.classID,
      this.enquiryForVal,
      this.referenceNameVal,
      this.statusVal,
      this.enquiryDate,
      this.isSms,
      this.isEmail,
      this.enquiryDateFormat,
      this.status,
      this.createdDate,
      this.createdID});

  GetTop5Enquiry.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    fatherName = json['FatherName'];
    motherName = json['MotherName'];
    contactNo = json['ContactNo'];
    emailID = json['EmailID'];
    enquiryType = json['EnquiryType'];
    comments = json['Comments'];
    referenceID = json['ReferenceID'];
    enquiryFor = json['EnquiryFor'];
    classID = json['ClassID'];
    enquiryForVal = json['EnquiryForVal'];
    referenceNameVal = json['ReferenceNameVal'];
    statusVal = json['StatusVal'];
    enquiryDate = json['EnquiryDate'];
    isSms = json['IsSms'];
    isEmail = json['IsEmail'];
    enquiryDateFormat = json['EnquiryDateFormat'];
    status = json['Status'];
    createdDate = json['CreatedDate'];
    createdID = json['CreatedID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Name'] = this.name;
    data['FatherName'] = this.fatherName;
    data['MotherName'] = this.motherName;
    data['ContactNo'] = this.contactNo;
    data['EmailID'] = this.emailID;
    data['EnquiryType'] = this.enquiryType;
    data['Comments'] = this.comments;
    data['ReferenceID'] = this.referenceID;
    data['EnquiryFor'] = this.enquiryFor;
    data['ClassID'] = this.classID;
    data['EnquiryForVal'] = this.enquiryForVal;
    data['ReferenceNameVal'] = this.referenceNameVal;
    data['StatusVal'] = this.statusVal;
    data['EnquiryDate'] = this.enquiryDate;
    data['IsSms'] = this.isSms;
    data['IsEmail'] = this.isEmail;
    data['EnquiryDateFormat'] = this.enquiryDateFormat;
    data['Status'] = this.status;
    data['CreatedDate'] = this.createdDate;
    data['CreatedID'] = this.createdID;
    return data;
  }
}

class TodayFollowUp {
  int? iD = 0;
  String? name = '';
  String? fatherName = '';
  String? motherName = '';
  String? contactNo = '';
  String? emailID = '';
  int? followupid = 0;
  int? enquiryType = 0;
  String? comments = '';
  int? referenceID = 0;
  int? enquiryFor = 0;
  int? classID = 0;
  String? followUpDateFormat = '';
  String? followStatus = '';
  String? enquiryForVal = '';
  String? referenceNameVal = '';
  String? statusVal = '';
  String? enquiryDate = '';
  bool? isSms = false;
  bool? isEmail = false;
  String? enquiryDateFormat = '';
  int? status = 0;
  String? createdDate = '';
  int? createdID = 0;

  TodayFollowUp(
      {this.iD,
      this.name,
      this.fatherName,
      this.motherName,
      this.contactNo,
      this.emailID,
      this.followupid,
      this.enquiryType,
      this.comments,
      this.referenceID,
      this.enquiryFor,
      this.classID,
      this.followUpDateFormat,
      this.followStatus,
      this.enquiryForVal,
      this.referenceNameVal,
      this.statusVal,
      this.enquiryDate,
      this.isSms,
      this.isEmail,
      this.enquiryDateFormat,
      this.status,
      this.createdDate,
      this.createdID});

  TodayFollowUp.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    fatherName = json['FatherName'];
    motherName = json['MotherName'];
    contactNo = json['ContactNo'];
    emailID = json['EmailID'];
    followupid = json['Followupid'];
    enquiryType = json['EnquiryType'];
    comments = json['Comments'];
    referenceID = json['ReferenceID'];
    enquiryFor = json['EnquiryFor'];
    classID = json['ClassID'];
    followUpDateFormat = json['FollowUpDateFormat'];
    followStatus = json['FollowStatus'];
    enquiryForVal = json['EnquiryForVal'];
    referenceNameVal = json['ReferenceNameVal'];
    statusVal = json['StatusVal'];
    enquiryDate = json['EnquiryDate'];
    isSms = json['IsSms'];
    isEmail = json['IsEmail'];
    enquiryDateFormat = json['EnquiryDateFormat'];
    status = json['Status'];
    createdDate = json['CreatedDate'];
    createdID = json['CreatedID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Name'] = this.name;
    data['FatherName'] = this.fatherName;
    data['MotherName'] = this.motherName;
    data['ContactNo'] = this.contactNo;
    data['EmailID'] = this.emailID;
    data['Followupid'] = this.followupid;
    data['EnquiryType'] = this.enquiryType;
    data['Comments'] = this.comments;
    data['ReferenceID'] = this.referenceID;
    data['EnquiryFor'] = this.enquiryFor;
    data['ClassID'] = this.classID;
    data['FollowUpDateFormat'] = this.followUpDateFormat;
    data['FollowStatus'] = this.followStatus;
    data['EnquiryForVal'] = this.enquiryForVal;
    data['ReferenceNameVal'] = this.referenceNameVal;
    data['StatusVal'] = this.statusVal;
    data['EnquiryDate'] = this.enquiryDate;
    data['IsSms'] = this.isSms;
    data['IsEmail'] = this.isEmail;
    data['EnquiryDateFormat'] = this.enquiryDateFormat;
    data['Status'] = this.status;
    data['CreatedDate'] = this.createdDate;
    data['CreatedID'] = this.createdID;
    return data;
  }
}
