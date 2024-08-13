class FeeTransactionHistoryModel {
  String? transId = '';
  String? transDate = '';
  String? transStatus = '';
  String? amountDep = '';
  String? transStatus1 = '';
  String? transDate1 = '';

  FeeTransactionHistoryModel(
      {this.transId,
      this.transDate,
      this.transStatus,
      this.amountDep,
      this.transStatus1,
      this.transDate1});

  FeeTransactionHistoryModel.fromJson(Map<String, dynamic> json) {
    transId = json['TransId'] != null ? json['TransId'] : "";
    transDate = json['TransDate'] != null ? json['TransDate'] : "";
    transStatus = json['TransStatus'] != null ? json['TransStatus'] : "";
    amountDep = json['AmountDep'] != null ? json['AmountDep'] : "";
    transStatus1 = json['TransStatus1'] != null ? json['TransStatus1'] : "";
    transDate1 = json['TransDate1'] != null ? json['TransDate1'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TransId'] = this.transId;
    data['TransDate'] = this.transDate;
    data['TransStatus'] = this.transStatus;
    data['AmountDep'] = this.amountDep;
    data['TransStatus1'] = this.transStatus1;
    data['TransDate1'] = this.transDate1;
    return data;
  }
}
