class AllowDiscountListModel {
  String? receiptno = '';
  String? studentid = '';
  String? feetotal = '';
  String? balanceamt = '';
  String? feedate = '';
  String? receiveamount = '';
  String? spdiscnt = '';
  String? remarks = '';
  String? feemonthdesc = '';
  String? feecat = '';
  String? feecatid = '';
  String? discountapplied = '';
  String? stname = '';
  String? admno = '';
  String? fathername = '';
  String? feedate1 = '';
  String? disuserid = '';
  bool? isChecked = false;

  AllowDiscountListModel(
      {this.receiptno,
      this.studentid,
      this.feetotal,
      this.balanceamt,
      this.feedate,
      this.receiveamount,
      this.spdiscnt,
      this.remarks,
      this.feemonthdesc,
      this.feecat,
      this.feecatid,
      this.discountapplied,
      this.stname,
      this.admno,
      this.fathername,
      this.feedate1,
      this.disuserid,
      this.isChecked});

  AllowDiscountListModel.fromJson(Map<String, dynamic> json) {
    receiptno = json['receiptno'] ?? "";
    studentid = json['studentid'] ?? "";
    feetotal = json['feetotal'] ?? "";
    balanceamt = json['balanceamt'] ?? "";
    feedate = json['feedate'] ?? "";
    receiveamount = json['receiveamount'] ?? "";
    spdiscnt = json['spdiscnt'] ?? "";
    remarks = json['remarks'] ?? "";
    feemonthdesc = json['feemonthdesc'] ?? "";
    feecat = json['feecat'] ?? "";
    feecatid = json['feecatid'] ?? "";
    discountapplied = json['discountapplied'] ?? "";
    stname = json['stname'] ?? "";
    admno = json['admno'] ?? "";
    fathername = json['fathername'] ?? "";
    feedate1 = json['feedate1'] ?? "";
    disuserid = json['disuserid'] ?? "";
    isChecked = json['isChecked'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['receiptno'] = this.receiptno;
    data['studentid'] = this.studentid;
    data['feetotal'] = this.feetotal;
    data['balanceamt'] = this.balanceamt;
    data['feedate'] = this.feedate;
    data['receiveamount'] = this.receiveamount;
    data['spdiscnt'] = this.spdiscnt;
    data['remarks'] = this.remarks;
    data['feemonthdesc'] = this.feemonthdesc;
    data['feecat'] = this.feecat;
    data['feecatid'] = this.feecatid;
    data['discountapplied'] = this.discountapplied;
    data['stname'] = this.stname;
    data['admno'] = this.admno;
    data['fathername'] = this.fathername;
    data['feedate1'] = this.feedate1;
    data['disuserid'] = this.disuserid;
    data['isChecked'] = this.isChecked;
    return data;
  }

  @override
  String toString() {
    return "{receiptno: $receiptno, isChecked: $isChecked}";
  }
}
