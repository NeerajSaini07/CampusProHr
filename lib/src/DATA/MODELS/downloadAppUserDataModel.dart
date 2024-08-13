class DownloadAppUserDataModel {
  String? admno = '';
  String? stname = '';
  String? fatherName = '';
  String? className = '';
  String? classSection = '';
  String? oLoginid = '';
  String? ouserpassword = '';

  DownloadAppUserDataModel(
      {this.admno,
      this.stname,
      this.fatherName,
      this.className,
      this.classSection,
      this.oLoginid,
      this.ouserpassword});

  DownloadAppUserDataModel.fromJson(Map<String, dynamic> json) {
    admno = json['admno'] ?? "";
    stname = json['stname'] ?? "";
    fatherName = json['FatherName'] ?? "";
    className = json['className'] ?? "";
    classSection = json['ClassSection'] ?? "";
    oLoginid = json['OLoginid'] ?? "";
    ouserpassword = json['Ouserpassword'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admno'] = this.admno;
    data['stname'] = this.stname;
    data['FatherName'] = this.fatherName;
    data['className'] = this.className;
    data['ClassSection'] = this.classSection;
    data['OLoginid'] = this.oLoginid;
    data['Ouserpassword'] = this.ouserpassword;
    return data;
  }
}
