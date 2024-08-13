class DiscountGivenAllowDiscountModel {
  String? desigid = '';
  String? name = '';

  DiscountGivenAllowDiscountModel({this.desigid, this.name});

  DiscountGivenAllowDiscountModel.fromJson(Map<String, dynamic> json) {
    desigid = json['desigid'] ?? "";
    name = json['name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desigid'] = this.desigid;
    data['name'] = this.name;
    return data;
  }
}
