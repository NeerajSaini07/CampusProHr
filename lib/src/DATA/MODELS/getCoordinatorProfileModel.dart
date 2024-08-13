class GetCoordinatorProfileModel {
  String? empno = "";
  String? name = "";
  String? fatherName = "";
  String? designation = "";
  String? department = "";
  String? image = "";

  GetCoordinatorProfileModel(
      {this.empno,
      this.name,
      this.fatherName,
      this.designation,
      this.department,
      this.image});

  GetCoordinatorProfileModel.fromJson(Map<String, dynamic> json) {
    empno = json['Empno'] != null ? json['Empno'] : "";
    name = json['Name'] != null ? json['Name'] : "";
    fatherName = json['FatherName'] != null ? json['FatherName'] : "";
    designation = json['Designation'] != null ? json['Designation'] : "";
    department = json['Department'] != null ? json['Department'] : "";
    image = json['Image'] != null ? json['Image'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Empno'] = this.empno;
    data['Name'] = this.name;
    data['FatherName'] = this.fatherName;
    data['Designation'] = this.designation;
    data['Department'] = this.department;
    data['Image'] = this.image;
    return data;
  }
}
