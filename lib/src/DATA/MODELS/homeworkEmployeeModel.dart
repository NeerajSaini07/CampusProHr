class HomeworkEmployeeModel {
  String? classname = '';
  String? subject = '';
  String? homework = '';
  String? imageurl = '';
  String? iD = '';
  String? attdate = '';
  String? empid = '';
  String? homeworktype = '';
  String? empname = '';
  String? homeworkid = '';

  HomeworkEmployeeModel(
      {this.classname,
      this.subject,
      this.homework,
      this.imageurl,
      this.iD,
      this.attdate,
      this.empid,
      this.homeworktype,
      this.empname,
      this.homeworkid});

  HomeworkEmployeeModel.fromJson(Map<String, dynamic> json) {
    classname = json['classname'] != null ? json['classname'] : "";
    subject = json['subject'] != null ? json['subject'] : "";
    homework = json['homework'] != null ? json['homework'] : "";
    imageurl = json['imageurl'] != null ? json['imageurl'] : "";
    iD = json['ID'] != null ? json['ID'] : "";
    attdate = json['attdate'] != null ? json['attdate'] : "";
    empid = json['empid'] != null ? json['empid'] : "";
    homeworktype = json['homeworktype'] != null ? json['homeworktype'] : "";
    empname = json['empname'] != null ? json['empname'] : "";
    homeworkid = json['homeworkid'] != null ? json['homeworkid'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['classname'] = this.classname;
    data['subject'] = this.subject;
    data['homework'] = this.homework;
    data['imageurl'] = this.imageurl;
    data['ID'] = this.iD;
    data['attdate'] = this.attdate;
    data['empid'] = this.empid;
    data['homeworktype'] = this.homeworktype;
    data['empname'] = this.empname;
    data['homeworkid'] = this.homeworkid;
    return data;
  }
}
