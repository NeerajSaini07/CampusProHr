class SearchStudentFromRecordsCommonModel {
  String? studentid = "";
  String? admno = "";
  String? stname = "";
  String? fathername = '';
  String? classsection = '';
  String? guardianmobileno = '';
  String? prsntAddress = '';
  String? displayorderno = '';
  String? address = '';
  String? compClass = '';
  String? imageUrl = '';

  SearchStudentFromRecordsCommonModel({
    this.studentid,
    this.admno,
    this.stname,
    this.fathername,
    this.classsection,
    this.guardianmobileno,
    this.prsntAddress,
    this.displayorderno,
    this.address,
    this.compClass,
    this.imageUrl,
  });

  SearchStudentFromRecordsCommonModel.fromJson(Map<String, dynamic> json) {
    studentid = json['studentid'] != null ? json['studentid'] : "";
    admno = json['admno'] != null ? json['admno'] : "";
    stname = json['Stname'] != null ? json['Stname'] : "";
    fathername = json['fathername'] != null ? json['fathername'] : "";
    classsection = json['classsection'] != null ? json['classsection'] : "";
    guardianmobileno =
        json['guardianmobileno'] != null ? json['guardianmobileno'] : "";
    prsntAddress = json['PrsntAddress'] != null ? json['PrsntAddress'] : "";
    displayorderno =
        json['displayorderno'] != null ? json['displayorderno'] : "";
    address = json['address'] != null ? json['address'] : "";
    compClass = json['CompClass'] != null ? json['CompClass'] : "";
    imageUrl = json["StudentImagePath"] != null ? json["StudentImagePath"] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentid'] = this.studentid;
    data['admno'] = this.admno;
    data['Stname'] = this.stname;
    data['fathername'] = this.fathername;
    data['classsection'] = this.classsection;
    data['guardianmobileno'] = this.guardianmobileno;
    data['PrsntAddress'] = this.prsntAddress;
    data['displayorderno'] = this.displayorderno;
    data['address'] = this.address;
    data['CompClass'] = this.compClass;
    data['StudentImagePath'] = this.imageUrl;
    return data;
  }
}
