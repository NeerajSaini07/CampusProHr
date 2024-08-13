class GetClassSectionAdminModel {
  int? id;
  String? classSection;

  GetClassSectionAdminModel(this.id, this.classSection);

  GetClassSectionAdminModel.fromJson(Map<String, dynamic> json) {
    this.id = json['Id'] != null ? json['Id'] : -1;
    this.classSection =
        json['ClassSection'] != null ? json['ClassSection'] : "";
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['Id'] = this.id;
    data['ClassSection'] = this.classSection;
    return data;
  }
}
