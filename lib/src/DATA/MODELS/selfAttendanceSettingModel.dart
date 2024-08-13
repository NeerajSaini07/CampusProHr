//TODO- Wrong Model - This is a AppConfig Model for temporary
class SelfAttendanceSettingModel {
  String? incrementMonthId;
  String? buttonConfigString;
  String? showFeeReceipt;
  String? editAmount;
  String? letPayOldFeeMonths;

  SelfAttendanceSettingModel({
    this.incrementMonthId,
    this.buttonConfigString,
    this.showFeeReceipt,
    this.editAmount,
    this.letPayOldFeeMonths,
  });

  SelfAttendanceSettingModel.fromJson(Map<String, dynamic> json) {
    incrementMonthId = json['IncrementMonthId'];
    buttonConfigString = json['ButtonConfigString'];
    showFeeReceipt = json['ShowFeeReceipt'];
    editAmount = json['EditAmount'];
    letPayOldFeeMonths = json['LetPayOldFeeMonths'];
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
