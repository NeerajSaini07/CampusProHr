class FeeBalanceMonthListEmployeeModel {
  String? monthID;
  String? monthName;

  FeeBalanceMonthListEmployeeModel({this.monthID, this.monthName});

  FeeBalanceMonthListEmployeeModel.fromJson(Map<String, dynamic> json) {
    monthID = json['MonthID'] != null ? json['MonthID'] : "";
    monthName = json['MonthName'] != null ? json['MonthName'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MonthID'] = this.monthID;
    data['MonthName'] = this.monthName;
    return data;
  }
}
