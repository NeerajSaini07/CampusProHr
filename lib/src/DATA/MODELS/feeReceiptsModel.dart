class FeeReceiptsModel {
  String? receiptNo = "";
  String? feeDate = "";
  String? feeTotal = "";
  String? spDiscnt = "";
  String? receiveAmount = "";
  String? balanceAmt = "";
  String? newFeeDate = "";

  FeeReceiptsModel(
      {this.receiptNo,
      this.feeDate,
      this.feeTotal,
      this.spDiscnt,
      this.receiveAmount,
      this.balanceAmt,
      this.newFeeDate});

  FeeReceiptsModel.fromJson(Map<String, dynamic> json) {
    receiptNo = json['ReceiptNo'] != null ? json['ReceiptNo'] : "";
    feeDate = json['FeeDate'] != null ? json['FeeDate'] : "";
    feeTotal = json['FeeTotal'] != null ? json['FeeTotal'] : "";
    spDiscnt = json['SpDiscnt'] != null ? json['SpDiscnt'] : "";
    receiveAmount = json['ReceiveAmount'] != null ? json['ReceiveAmount'] : "";
    balanceAmt = json['BalanceAmt'] != null ? json['BalanceAmt'] : "";
    newFeeDate = json['NewFeeDate'] != null ? json['NewFeeDate'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ReceiptNo'] = this.receiptNo;
    data['FeeDate'] = this.feeDate;
    data['FeeTotal'] = this.feeTotal;
    data['SpDiscnt'] = this.spDiscnt;
    data['ReceiveAmount'] = this.receiveAmount;
    data['BalanceAmt'] = this.balanceAmt;
    data['NewFeeDate'] = this.newFeeDate;
    return data;
  }
}
