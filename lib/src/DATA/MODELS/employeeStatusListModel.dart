class EmployeeStatusListModel {
  List<Data1>? data1 = [];
  List<Data2>? data2 = [];

  EmployeeStatusListModel({this.data1, this.data2});

  EmployeeStatusListModel.fromJson(Map<String, dynamic> json) {
    if (json['Data1'] != null) {
      data1 = <Data1>[];
      json['Data1'].forEach((v) {
        data1!.add(new Data1.fromJson(v));
      });
    }
    if (json['Data2'] != null) {
      data2 = <Data2>[];
      json['Data2'].forEach((v) {
        data2!.add(new Data2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data1 != null) {
      data['Data1'] = this.data1!.map((v) => v.toJson()).toList();
    }
    if (this.data2 != null) {
      data['Data2'] = this.data1!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data1 {
  int? oUserId = -1;
  int? oTP = -1;
  String? ouserPassword = '';

  Data1({this.oUserId, this.oTP, this.ouserPassword});

  Data1.fromJson(Map<String, dynamic> json) {
    oUserId = json['OUserId'] != null ? json['OUserId'] : -1;
    oTP = json['OTP'] != null ? json['OTP'] : -1;
    ouserPassword = json['OuserPassword'] != null ? json['OuserPassword'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OUserId'] = this.oUserId;
    data['OTP'] = this.oTP;
    data['OuserPassword'] = this.ouserPassword;
    return data;
  }
}

class Data2 {
  int? oUserId = -1;
  int? schoolId = -1;
  int? organizationId = -1;
  int? stuEmpID = -1;
  String? isActive = '';
  String? oUserType = '';
  String? stuEmpName = '';
  String? mobileNo = '';
  String? lastActiveTime = '';
  String? busId = '';
  String? dateadded = '';
  int? userAccesstype = -1;
  String? userToken = '';
  String? typeName = '';

  Data2(
      {this.oUserId,
      this.schoolId,
      this.organizationId,
      this.stuEmpID,
      this.isActive,
      this.oUserType,
      this.stuEmpName,
      this.mobileNo,
      this.lastActiveTime,
      this.busId,
      this.dateadded,
      this.userAccesstype,
      this.userToken,
      this.typeName});

  Data2.fromJson(Map<String, dynamic> json) {
    oUserId = json['OUserId'];
    schoolId = json['SchoolId'];
    organizationId = json['OrganizationId'];
    stuEmpID = json['StuEmpID'];
    isActive = json['isActive'];
    oUserType = json['OUserType'];
    stuEmpName = json['StuEmpName'];
    mobileNo = json['mobileNo'];
    lastActiveTime = json['LastActiveTime'];
    busId = json['BusId'];
    dateadded = json['Dateadded'];
    userAccesstype = json['UserAccesstype'];
    userToken = json['userToken'];
    typeName = json['TypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OUserId'] = this.oUserId;
    data['SchoolId'] = this.schoolId;
    data['OrganizationId'] = this.organizationId;
    data['StuEmpID'] = this.stuEmpID;
    data['isActive'] = this.isActive;
    data['OUserType'] = this.oUserType;
    data['StuEmpName'] = this.stuEmpName;
    data['mobileNo'] = this.mobileNo;
    data['LastActiveTime'] = this.lastActiveTime;
    data['BusId'] = this.busId;
    data['Dateadded'] = this.dateadded;
    data['UserAccesstype'] = this.userAccesstype;
    data['userToken'] = this.userToken;
    data['TypeName'] = this.typeName;
    return data;
  }
}
