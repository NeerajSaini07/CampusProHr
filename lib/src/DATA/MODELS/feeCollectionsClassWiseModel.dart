class FeeCollectionsClassWiseModel {
  String? className = '';
  String? collection = '';

  FeeCollectionsClassWiseModel({this.className, this.collection});

  FeeCollectionsClassWiseModel.fromJson(Map<String, dynamic> json) {
    className = json['ClassName'] != null ? json['ClassName'] : "";
    collection = json['Collection'] != null ? json['Collection'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClassName'] = this.className;
    data['Collection'] = this.collection;
    return data;
  }
}
