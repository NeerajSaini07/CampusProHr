class SearchEmployeeFromRecordsCommonModel {
  String? empId = '';
  String? name = '';
  String? empno = '';
  String? fatherName = '';
  String? husbandName = '';
  String? gender = '';
  String? nationality = '';
  String? dateOfBirth = '';
  String? religion = '';
  String? emailId = '';
  String? groupType = '';
  String? designation = '';
  String? grade = '';
  String? category = '';
  String? weekoff = '';
  String? jobtype = '';
  String? status = '';
  String? bankacct = '';
  String? panNo = '';
  String? prsAddr = '';
  String? prscity = '';
  String? prsstate = '';
  String? prsPhone = '';
  String? prsMobile = '';
  String? prsmail = '';
  String? prspin = '';
  String? prmAddr = '';
  String? image = '';
  String? relieving = '';
  String? leave = '';
  String? bankName = '';
  String? department = '';
  String? groupName = '';
  String? desigName = '';
  String? mobileNo = '';
  String? deptName = '';
  String? isTeacher = '';
  String? employeeImagePath = '';
  String? displayorderno = '';

  SearchEmployeeFromRecordsCommonModel(
      {this.empId,
      this.name,
      this.empno,
      this.fatherName,
      this.husbandName,
      this.gender,
      this.nationality,
      this.dateOfBirth,
      this.religion,
      this.emailId,
      this.groupType,
      this.designation,
      this.grade,
      this.category,
      this.weekoff,
      this.jobtype,
      this.status,
      this.bankacct,
      this.panNo,
      this.prsAddr,
      this.prscity,
      this.prsstate,
      this.prsPhone,
      this.prsMobile,
      this.prsmail,
      this.prspin,
      this.prmAddr,
      this.image,
      this.relieving,
      this.leave,
      this.bankName,
      this.department,
      this.groupName,
      this.desigName,
      this.mobileNo,
      this.deptName,
      this.isTeacher,
      this.employeeImagePath,
      this.displayorderno});

  SearchEmployeeFromRecordsCommonModel.fromJson(Map<String, dynamic> json) {
    empId = json['EmpId'] != null ? json['EmpId'] : "";
    name = json['Name'] != null ? json['Name'] : "";
    empno = json['Empno'] != null ? json['Empno'] : "";
    fatherName = json['FatherName'] != null ? json['FatherName'] : "";
    husbandName = json['HusbandName'] != null ? json['HusbandName'] : "";
    gender = json['Gender'] != null ? json['Gender'] : "";
    nationality = json['Nationality'] != null ? json['Nationality'] : "";
    dateOfBirth = json['DateOfBirth'] != null ? json['DateOfBirth'] : "";
    religion = json['Religion'] != null ? json['Religion'] : "";
    emailId = json['EmailId'] != null ? json['EmailId'] : "";
    groupType = json['GroupType'] != null ? json['GroupType'] : "";
    designation = json['Designation'] != null ? json['Designation'] : "";
    grade = json['Grade'] != null ? json['Grade'] : "";
    category = json['category'] != null ? json['category'] : "";
    weekoff = json['Weekoff'] != null ? json['Weekoff'] : "";
    jobtype = json['Jobtype'] != null ? json['Jobtype'] : "";
    status = json['status'] != null ? json['status'] : "";
    bankacct = json['Bankacct'] != null ? json['Bankacct'] : "";
    panNo = json['PanNo'] != null ? json['PanNo'] : "";
    prsAddr = json['PrsAddr'] != null ? json['PrsAddr'] : "";
    prscity = json['Prscity'] != null ? json['Prscity'] : "";
    prsstate = json['Prsstate'] != null ? json['Prsstate'] : "";
    prsPhone = json['PrsPhone'] != null ? json['PrsPhone'] : "";
    prsMobile = json['PrsMobile'] != null ? json['PrsMobile'] : "";
    prsmail = json['Prsmail'] != null ? json['Prsmail'] : "";
    prspin = json['Prspin'] != null ? json['Prspin'] : "";
    prmAddr = json['PrmAddr'] != null ? json['PrmAddr'] : "";
    image = json['Image'] != null ? json['Image'] : "";
    relieving = json['Relieving'] != null ? json['Relieving'] : "";
    leave = json['Leave'] != null ? json['Leave'] : "";
    bankName = json['BankName'] != null ? json['BankName'] : "";
    department = json['Department'] != null ? json['Department'] : "";
    groupName = json['GroupName'] != null ? json['GroupName'] : "";
    desigName = json['DesigName'] != null ? json['DesigName'] : "";
    mobileNo = json['MobileNo'] != null ? json['MobileNo'] : "";
    deptName = json['DeptName'] != null ? json['DeptName'] : "";
    isTeacher = json['IsTeacher'] != null ? json['IsTeacher'] : "";
    employeeImagePath =
        json['EmployeeImagePath'] != null ? json['EmployeeImagePath'] : "";
    displayorderno =
        json['displayorderno'] != null ? json['displayorderno'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmpId'] = this.empId;
    data['Name'] = this.name;
    data['Empno'] = this.empno;
    data['FatherName'] = this.fatherName;
    data['HusbandName'] = this.husbandName;
    data['Gender'] = this.gender;
    data['Nationality'] = this.nationality;
    data['DateOfBirth'] = this.dateOfBirth;
    data['Religion'] = this.religion;
    data['EmailId'] = this.emailId;
    data['GroupType'] = this.groupType;
    data['Designation'] = this.designation;
    data['Grade'] = this.grade;
    data['category'] = this.category;
    data['Weekoff'] = this.weekoff;
    data['Jobtype'] = this.jobtype;
    data['status'] = this.status;
    data['Bankacct'] = this.bankacct;
    data['PanNo'] = this.panNo;
    data['PrsAddr'] = this.prsAddr;
    data['Prscity'] = this.prscity;
    data['Prsstate'] = this.prsstate;
    data['PrsPhone'] = this.prsPhone;
    data['PrsMobile'] = this.prsMobile;
    data['Prsmail'] = this.prsmail;
    data['Prspin'] = this.prspin;
    data['PrmAddr'] = this.prmAddr;
    data['Image'] = this.image;
    data['Relieving'] = this.relieving;
    data['Leave'] = this.leave;
    data['BankName'] = this.bankName;
    data['Department'] = this.department;
    data['GroupName'] = this.groupName;
    data['DesigName'] = this.desigName;
    data['MobileNo'] = this.mobileNo;
    data['DeptName'] = this.deptName;
    data['IsTeacher'] = this.isTeacher;
    data['EmployeeImagePath'] = this.employeeImagePath;
    data['displayorderno'] = this.displayorderno;
    return data;
  }
}
