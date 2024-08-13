class PayUBizHashModel {
  String? mainHash = '';
  String? vasHash = '';
  String? paymentHash = '';

  PayUBizHashModel({this.mainHash, this.vasHash, this.paymentHash});

  PayUBizHashModel.fromJson(Map<String, dynamic> json) {
    mainHash = json['mainHash'];
    vasHash = json['vasHash'];
    paymentHash = json['paymentHash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mainHash'] = this.mainHash;
    data['vasHash'] = this.vasHash;
    data['paymentHash'] = this.paymentHash;
    return data;
  }
}
