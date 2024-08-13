class CircularEmployeeModel {
  String? circularId = '';
  String? cirNo = '';
  String? circularDate = '';
  String? cirSubject = '';
  String? cirContent = '';
  String? circularFileurl = '';
  String? className = '';
  String? empid = '';
  String? empname = '';
  String? forStuEmp = '';

  CircularEmployeeModel(
      {this.circularId,
      this.cirNo,
      this.circularDate,
      this.cirSubject,
      this.cirContent,
      this.circularFileurl,
      this.className,
      this.empid,
      this.empname,
      this.forStuEmp});

  CircularEmployeeModel.fromJson(Map<String, dynamic> json) {
    circularId = json['CircularId'] != null ? json['CircularId'] : "";
    cirNo = json['CirNo'] != null ? json['CirNo'] : "";
    circularDate = json['CircularDate'] != null ? json['CircularDate'] : "";
    cirSubject = json['CirSubject'] != null ? json['CirSubject'] : "";
    cirContent = json['CirContent'] != null ? json['CirContent'] : "";
    circularFileurl = json['CircularFileurl'] != null ? json['CircularFileurl'] : "";
    className = json['ClassName'] != null ? json['ClassName'] : "";
    empid = json['empid'] != null ? json['empid'] : "";
    empname = json['empname'] != null ? json['empname'] : "";
    forStuEmp = json['ForStuEmp'] != null ? json['ForStuEmp'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CircularId'] = this.circularId;
    data['CirNo'] = this.cirNo;
    data['CircularDate'] = this.circularDate;
    data['CirSubject'] = this.cirSubject;
    data['CirContent'] = this.cirContent;
    data['CircularFileurl'] = this.circularFileurl;
    data['ClassName'] = this.className;
    data['empid'] = this.empid;
    data['empname'] = this.empname;
    data['ForStuEmp'] = this.forStuEmp;
    return data;
  }
}
