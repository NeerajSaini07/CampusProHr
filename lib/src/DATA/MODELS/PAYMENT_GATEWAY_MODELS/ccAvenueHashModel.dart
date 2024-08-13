class CCAvenueHashModel {
  String? mainHash = '';
  String? vasHash = '';
  String? paymentHash = '';

  CCAvenueHashModel({this.mainHash, this.vasHash, this.paymentHash});

  CCAvenueHashModel.fromJson(Map<String, dynamic> json) {
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
