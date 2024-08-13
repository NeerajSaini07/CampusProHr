class BillsListBillApproveModel {
  String? billId = '';
  String? billNo = '';
  String? billDate = '';
  String? billTotal = '';
  String? type = '';
  String? isFinalize = '';
  String? name = '';

  BillsListBillApproveModel(
      {this.billId,
      this.billNo,
      this.billDate,
      this.billTotal,
      this.type,
      this.isFinalize,
      this.name});

  BillsListBillApproveModel.fromJson(Map<String, dynamic> json) {
    billId = json['BillId'] ?? "";
    billNo = json['BillNo'] ?? "";
    billDate = json['BillDate'] ?? "";
    billTotal = json['BillTotal'] ?? "";
    type = json['Type'] ?? "";
    isFinalize = json['IsFinalize'] ?? "";
    name = json['Name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BillId'] = this.billId;
    data['BillNo'] = this.billNo;
    data['BillDate'] = this.billDate;
    data['BillTotal'] = this.billTotal;
    data['Type'] = this.type;
    data['IsFinalize'] = this.isFinalize;
    data['Name'] = this.name;
    return data;
  }
}
