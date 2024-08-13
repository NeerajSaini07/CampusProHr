class BillDetailsBillApproveModel {
  String? billNo = '';
  String? billTotal = '';
  String? isFinalize = '';
  String? billType = '';

  BillDetailsBillApproveModel(
      {this.billNo, this.billTotal, this.isFinalize, this.billType});

  BillDetailsBillApproveModel.fromJson(Map<String, dynamic> json) {
    billNo = json['BillNo'] ?? "";
    billTotal = json['BillTotal'] ?? "";
    isFinalize = json['IsFinalize'] ?? "";
    billType = json['BillType'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BillNo'] = this.billNo;
    data['BillTotal'] = this.billTotal;
    data['IsFinalize'] = this.isFinalize;
    data['BillType'] = this.billType;
    return data;
  }
}
