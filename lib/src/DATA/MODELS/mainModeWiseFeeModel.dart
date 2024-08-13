class MainModeWiseFeeModel {
  String? feeHead = '';
  String? amount = '';

  MainModeWiseFeeModel({this.feeHead, this.amount});

  MainModeWiseFeeModel.fromJson(Map<String, dynamic> json) {
    feeHead = json['FeeHead'] != null ? json['FeeHead'] : "";
    amount = json['Amount'] != null ? json['Amount'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FeeHead'] = this.feeHead;
    data['Amount'] = this.amount;
    return data;
  }
}
