class AppConfigSettingModel {
  String? incrementMonthId = "";
  String? buttonConfigString = "";
  String? showFeeReceipt = "";
  String? editAmount = "";
  String? letPayOldFeeMonths = "";

  AppConfigSettingModel({
    this.incrementMonthId,
    this.buttonConfigString,
    this.showFeeReceipt,
    this.editAmount,
    this.letPayOldFeeMonths,
  });

  AppConfigSettingModel.fromJson(Map<String, dynamic> json) {
    incrementMonthId =
        json['IncrementMonthId'] != null ? json['IncrementMonthId'] : "";
    buttonConfigString =
        json['ButtonConfigString'] != null ? json['ButtonConfigString'] : "";
    showFeeReceipt =
        json['ShowFeeReceipt'] != null ? json['ShowFeeReceipt'] : "";
    editAmount = json['EditAmount'] != null ? json['EditAmount'] : "";
    letPayOldFeeMonths =
        json['LetPayOldFeeMonths'] != null ? json['LetPayOldFeeMonths'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IncrementMonthId'] = this.incrementMonthId;
    data['ButtonConfigString'] = this.buttonConfigString;
    data['ShowFeeReceipt'] = this.showFeeReceipt;
    data['EditAmount'] = this.editAmount;
    data['LetPayOldFeeMonths'] = this.letPayOldFeeMonths;
    return data;
  }
}
