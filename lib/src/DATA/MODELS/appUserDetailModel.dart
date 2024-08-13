class AppUserDetailModel {
  String? sTUEMPID = '';
  String? aDMNO = '';
  String? sTUEMPNAME = '';
  String? fATHERNAME = '';
  String? mOBILENO = '';
  String? oLOGINID = '';
  String? oUSERPASSWORD = '';
  String? lASTACTIVETIME = '';
  String? lASTTIME = '';
  String? cLASSNAME = '';
  String? iD = '';
  String? dISPLAYORDERNO = '';
  String? stuOrEmp = '';
  String? sECTIONID = '';
  String? cLASSSECTION = '';

  AppUserDetailModel(
      {this.sTUEMPID,
      this.aDMNO,
      this.sTUEMPNAME,
      this.fATHERNAME,
      this.mOBILENO,
      this.oLOGINID,
      this.oUSERPASSWORD,
      this.lASTACTIVETIME,
      this.lASTTIME,
      this.cLASSNAME,
      this.iD,
      this.dISPLAYORDERNO,
      this.stuOrEmp,
      this.sECTIONID,
      this.cLASSSECTION});

  AppUserDetailModel.fromJson(Map<String, dynamic> json) {
    sTUEMPID = json['STUEMPID'] ?? "";
    aDMNO = json['ADMNO'] ?? "";
    sTUEMPNAME = json['STUEMPNAME'] ?? "";
    fATHERNAME = json['FATHERNAME'] ?? "";
    mOBILENO = json['MOBILENO'] ?? "";
    oLOGINID = json['OLOGINID'] ?? "";
    oUSERPASSWORD = json['OUSERPASSWORD'] ?? "";
    lASTACTIVETIME = json['LASTACTIVETIME'] ?? "";
    lASTTIME = json['LASTTIME'] ?? "";
    cLASSNAME = json['CLASSNAME'] ?? "";
    iD = json['ID'] ?? "";
    dISPLAYORDERNO = json['DISPLAYORDERNO'] ?? "";
    stuOrEmp = json['StuOrEmp'] ?? "";
    sECTIONID = json['SECTIONID'] ?? "";
    cLASSSECTION = json['CLASSSECTION'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STUEMPID'] = this.sTUEMPID;
    data['ADMNO'] = this.aDMNO;
    data['STUEMPNAME'] = this.sTUEMPNAME;
    data['FATHERNAME'] = this.fATHERNAME;
    data['MOBILENO'] = this.mOBILENO;
    data['OLOGINID'] = this.oLOGINID;
    data['OUSERPASSWORD'] = this.oUSERPASSWORD;
    data['LASTACTIVETIME'] = this.lASTACTIVETIME;
    data['LASTTIME'] = this.lASTTIME;
    data['CLASSNAME'] = this.cLASSNAME;
    data['ID'] = this.iD;
    data['DISPLAYORDERNO'] = this.dISPLAYORDERNO;
    data['StuOrEmp'] = this.stuOrEmp;
    data['SECTIONID'] = this.sECTIONID;
    data['CLASSSECTION'] = this.cLASSSECTION;
    return data;
  }
}
