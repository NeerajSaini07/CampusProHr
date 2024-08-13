class CircularStudentModel {
  String? organizationid = '';
  String? schoolid = '';
  String? sessionid = '';
  String? forstuemp = '';
  String? circularid = '';
  String? circulardate = '';
  String? cirno = '';
  String? cirsubject = '';
  String? circontent = '';
  String? forall = '';
  String? classid = '';
  String? sectionid = '';
  String? streamid = '';
  String? yearid = '';
  String? groupid = '';
  String? isactive = '';
  String? userid = '';
  String? timestamp = '';
  String? byuserid = '';
  String? circularfileurl = '';
  String? empid = '';
  String? usertype = '';
  String? authCheck = '';

  CircularStudentModel(
      {this.organizationid,
      this.schoolid,
      this.sessionid,
      this.forstuemp,
      this.circularid,
      this.circulardate,
      this.cirno,
      this.cirsubject,
      this.circontent,
      this.forall,
      this.classid,
      this.sectionid,
      this.streamid,
      this.yearid,
      this.groupid,
      this.isactive,
      this.userid,
      this.timestamp,
      this.byuserid,
      this.circularfileurl,
      this.empid,
      this.usertype,
      this.authCheck});

  CircularStudentModel.fromJson(Map<String, dynamic> json) {
    organizationid =
        json['organizationid'] != null ? json['organizationid'] : "";
    schoolid = json['schoolid'] != null ? json['schoolid'] : "";
    sessionid = json['sessionid'] != null ? json['sessionid'] : "";
    forstuemp = json['forstuemp'] != null ? json['forstuemp'] : "";
    circularid = json['circularid'] != null ? json['circularid'] : "";
    circulardate = json['circulardate'] != null ? json['circulardate'] : "";
    cirno = json['cirno'] != null ? json['cirno'] : "";
    cirsubject = json['cirsubject'] != null ? json['cirsubject'] : "";
    circontent = json['circontent'] != null ? json['circontent'] : "";
    forall = json['forall'] != null ? json['forall'] : "";
    classid = json['classid'] != null ? json['classid'] : "";
    sectionid = json['sectionid'] != null ? json['sectionid'] : "";
    streamid = json['streamid'] != null ? json['streamid'] : "";
    yearid = json['yearid'] != null ? json['yearid'] : "";
    groupid = json['groupid'] != null ? json['groupid'] : "";
    isactive = json['isactive'] != null ? json['isactive'] : "";
    userid = json['userid'] != null ? json['userid'] : "";
    timestamp = json['timestamp'] != null ? json['timestamp'] : "";
    byuserid = json['byuserid'] != null ? json['byuserid'] : "";
    circularfileurl =
        json['circularfileurl'] != null ? json['circularfileurl'] : "";
    empid = json['empid'] != null ? json['empid'] : "";
    usertype = json['usertype'] != null ? json['usertype'] : "";
    authCheck = json['AuthCheck'] != null ? json['AuthCheck'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['organizationid'] = this.organizationid;
    data['schoolid'] = this.schoolid;
    data['sessionid'] = this.sessionid;
    data['forstuemp'] = this.forstuemp;
    data['circularid'] = this.circularid;
    data['circulardate'] = this.circulardate;
    data['cirno'] = this.cirno;
    data['cirsubject'] = this.cirsubject;
    data['circontent'] = this.circontent;
    data['forall'] = this.forall;
    data['classid'] = this.classid;
    data['sectionid'] = this.sectionid;
    data['streamid'] = this.streamid;
    data['yearid'] = this.yearid;
    data['groupid'] = this.groupid;
    data['isactive'] = this.isactive;
    data['userid'] = this.userid;
    data['timestamp'] = this.timestamp;
    data['byuserid'] = this.byuserid;
    data['circularfileurl'] = this.circularfileurl;
    data['empid'] = this.empid;
    data['usertype'] = this.usertype;
    data['AuthCheck'] = this.authCheck;
    return data;
  }
}
