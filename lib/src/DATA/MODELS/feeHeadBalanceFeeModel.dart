class FeeHeadBalanceFeeModel {
  String? feeDetailID = '';
  String? feeName = '';

  FeeHeadBalanceFeeModel({this.feeDetailID, this.feeName});

  FeeHeadBalanceFeeModel.fromJson(Map<String, dynamic> json) {
    feeDetailID = json['FeeDetailID'] != null ? json['FeeDetailID'] : "";
    feeName = json['FeeName'] != null ? json['FeeName'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FeeDetailID'] = this.feeDetailID;
    data['FeeName'] = this.feeName;
    return data;
  }
}
