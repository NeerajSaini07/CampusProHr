class BalanceFeeAdminModel {
  String? classID = '';
  String? classSectionID = '';
  String? className = '';
  String? balanceAmt = '';

  BalanceFeeAdminModel(
      {this.classID, this.classSectionID, this.className, this.balanceAmt});

  BalanceFeeAdminModel.fromJson(Map<String, dynamic> json) {
    classID = json['ClassID'] != null ? json['ClassID'] : "";
    classSectionID =
        json['ClassSectionID'] != null ? json['ClassSectionID'] : "";
    className = json['ClassName'] != null ? json['ClassName'] : "";
    balanceAmt = json['BalanceAmt'] != null ? json['BalanceAmt'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClassID'] = this.classID;
    data['ClassSectionID'] = this.classSectionID;
    data['ClassName'] = this.className;
    data['BalanceAmt'] = this.balanceAmt;
    return data;
  }
}
