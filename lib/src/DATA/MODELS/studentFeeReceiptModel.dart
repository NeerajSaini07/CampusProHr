class StudentFeeReceiptModel {
  String? feeDetailId = "";
  String? feeName = "";
  String? mAmount = "";
  String? preBalance = "";
  String? concessionType = "";
  String? concessionAmount = "";
  String? spConcession = "";
  String? amountPayable = "";
  String? dispOrder = "";
  String? forMonths = "";
  String? addFee = "";
  String? discount = "";
  String? actFeeAmount = "";
  String? concFeeAmount = "";
  String? amountPaid = "";
  String? showFee = "";
  String? mandatory = "";
  String? isMandatory = "";

  StudentFeeReceiptModel(
      {this.feeDetailId,
      this.feeName,
      this.mAmount,
      this.preBalance,
      this.concessionType,
      this.concessionAmount,
      this.spConcession,
      this.amountPayable,
      this.dispOrder,
      this.forMonths,
      this.addFee,
      this.discount,
      this.actFeeAmount,
      this.concFeeAmount,
      this.amountPaid,
      this.showFee,
      this.mandatory,
      this.isMandatory});

  StudentFeeReceiptModel.fromJson(Map<String, dynamic> json) {
    feeDetailId = json['FeeDetailId'] != null ? json['FeeDetailId'] : "";
    feeName = json['FeeName'] != null ? json['FeeName'] : "";
    mAmount = json['MAmount'] != null ? json['MAmount'] : "";
    preBalance = json['PreBalance'] != null ? json['PreBalance'] : "";
    concessionType =
        json['ConcessionType'] != null ? json['ConcessionType'] : "";
    concessionAmount =
        json['ConcessionAmount'] != null ? json['ConcessionAmount'] : "";
    spConcession = json['spConcession'] != null ? json['spConcession'] : "";
    amountPayable = json['AmountPayable'] != null ? json['AmountPayable'] : "";
    dispOrder = json['DispOrder'] != null ? json['DispOrder'] : "";
    forMonths = json['ForMonths'] != null ? json['ForMonths'] : "";
    addFee = json['AddFee'] != null ? json['AddFee'] : "";
    discount = json['Discount'] != null ? json['Discount'] : "";
    actFeeAmount = json['ActFeeAmount'] != null ? json['ActFeeAmount'] : "";
    concFeeAmount = json['ConcFeeAmount'] != null ? json['ConcFeeAmount'] : "";
    amountPaid = json['AmountPaid'] != null ? json['AmountPaid'] : "";
    showFee = json['ShowFee'] != null ? json['ShowFee'] : "";
    mandatory = json['Mandatory'] != null ? json['Mandatory'] : "";
    isMandatory = json['IsMandatory'] != null ? json['IsMandatory'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FeeDetailId'] = this.feeDetailId;
    data['FeeName'] = this.feeName;
    data['MAmount'] = this.mAmount;
    data['PreBalance'] = this.preBalance;
    data['ConcessionType'] = this.concessionType;
    data['ConcessionAmount'] = this.concessionAmount;
    data['spConcession'] = this.spConcession;
    data['AmountPayable'] = this.amountPayable;
    data['DispOrder'] = this.dispOrder;
    data['ForMonths'] = this.forMonths;
    data['AddFee'] = this.addFee;
    data['Discount'] = this.discount;
    data['ActFeeAmount'] = this.actFeeAmount;
    data['ConcFeeAmount'] = this.concFeeAmount;
    data['AmountPaid'] = this.amountPaid;
    data['ShowFee'] = this.showFee;
    data['Mandatory'] = this.mandatory;
    data['IsMandatory'] = this.isMandatory;
    return data;
  }
}
