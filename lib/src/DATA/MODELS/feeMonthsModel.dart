class FeeMonthsModel {
  String? feeMonthId = "";
  String? feeMonthName = "";
  String? isBalance = "";
  String? feeType = "";

  FeeMonthsModel(
      {this.feeMonthId, this.feeMonthName, this.isBalance, this.feeType});

  FeeMonthsModel.fromJson(Map<String, dynamic> json) {
    feeMonthId = json['FeeMonthId'] != null ? json['FeeMonthId'] : "";
    feeMonthName = json['FeeMonthName'] != null ? json['FeeMonthName'] : "";
    isBalance = json['IsBalance'] != null ? json['IsBalance'] : "";
    feeType = json['FeeType'] != null ? json['FeeType'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FeeMonthId'] = this.feeMonthId;
    data['FeeMonthName'] = this.feeMonthName;
    data['IsBalance'] = this.isBalance;
    data['FeeType'] = this.feeType;
    return data;
  }
}
