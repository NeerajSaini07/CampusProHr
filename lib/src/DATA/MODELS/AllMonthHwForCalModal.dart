class AllMonthHwForCalModal {
  String? id;
  String? name;
  String? description;
  String? date;
  String? type;
  String? color;

  AllMonthHwForCalModal(
      {this.id, this.name, this.description, this.date, this.type, this.color});

  AllMonthHwForCalModal.fromJson(Map<String, dynamic> json) {
    id = json['Id'] != null ? json['Id'] : "";
    name = json['Name'] != null ? json['Name'] : "";
    description = json['Description'] != null ? json['Description'] : "";
    date = json['Date'] != null ? json['Date'] : "";
    type = json['Type'] != null ? json['Type'] : "";
    color = json['Color'] != null ? json['Color'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    data['description'] = this.description;
    data['date'] = this.date;
    data['type'] = this.type;
    data['color'] = this.color;
    return data;
  }
}
